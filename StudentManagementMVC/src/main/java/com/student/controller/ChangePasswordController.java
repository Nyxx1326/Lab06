package com.student.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import org.mindrot.jbcrypt.BCrypt;
import com.student.dao.UserDAO;
import com.student.model.User;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO(); // Initialize DAO
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show change password form
        request.getRequestDispatcher("/views/change-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        try {
            // 1. Fetch latest password from DB
            User freshUser = userDAO.getUserById(currentUser.getId());
            if (freshUser == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // 2. Verify current password
            if (!BCrypt.checkpw(currentPassword, freshUser.getPassword())) {
                response.sendRedirect(request.getContextPath() + "/change-password.jsp?error=Current+password+is+incorrect");
                return;
            }

            // 3. Validate new password
            if (newPassword == null || newPassword.length() < 8) {
                response.sendRedirect(request.getContextPath() + "/change-password.jsp?error=New+password+must+be+at+least+8+characters");
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                response.sendRedirect(request.getContextPath() + "/change-password.jsp?error=New+password+and+confirmation+do+not+match");
                return;
            }

            // 4. Hash new password before saving
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

            boolean updated = userDAO.updatePassword(currentUser.getId(), hashedPassword);

            if (updated) {
                // Update session user password
                currentUser.setPassword(hashedPassword);
                session.setAttribute("currentUser", currentUser);
                session.setAttribute("passwordChangeSuccess", "Password changed successfully!");
                response.sendRedirect(request.getContextPath() + "/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/change-password.jsp?error=Failed+to+update+password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/change-password.jsp?error=An+error+occurred");
        }
    }
}
