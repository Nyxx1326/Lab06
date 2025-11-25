STUDENT INFORMATION: Name: Pham Thanh Trung Student ID: ITITIU22170 Class: Wed 13h15

COMPLETED EXERCISES: [x] Exercise 5:  [x] Exercise 6: [x] Exercise 7:  [ ] Exercise 8: 

AUTHENTICATION COMPONENTS:
- Models: User.java
- DAOs: UserDAO.java
- Controllers: LoginController.java, LogoutController.java, DashboardController.java
- Filters: AuthFilter.java, AdminFilter.java
- Views: login.jsp, dashboard.jsp, updated student-list.jsp

TEST CREDENTIALS:
Admin:
- Username: admin
- Password: password1234

Regular User:
- Username: john
- Password: password123

FEATURES IMPLEMENTED:
- User authentication with BCrypt
- Session management
- Login/Logout functionality
- Dashboard with statistics
- Authentication filter for protected pages
- Admin authorization filter
- Role-based UI elements
- Password security

SECURITY MEASURES:
- BCrypt password hashing
- Session regeneration after login
- Session timeout (30 minutes)
- SQL injection prevention (PreparedStatement)
- Input validation
- XSS prevention (JSTL escaping)

KNOWN ISSUES:
- [List any bugs or limitations]
- whatever i insert in change password, it still turn me todashboard, and the password does not change

BONUS FEATURES:
- [List any bonus features implemented]

TIME SPENT: 6h

TESTING NOTES:
[Describe how you tested authentication, filters, and authorization]
