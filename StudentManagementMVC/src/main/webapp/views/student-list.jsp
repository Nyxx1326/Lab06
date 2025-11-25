    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Student List - MVC</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                padding: 20px;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                background: white;
                border-radius: 10px;
                padding: 30px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            }

            h1 {
                color: #333;
                margin-bottom: 10px;
                font-size: 32px;
            }

            .subtitle {
                color: #666;
                margin-bottom: 30px;
                font-style: italic;
            }

            .message {
                padding: 15px;
                margin-bottom: 20px;
                border-radius: 5px;
                font-weight: 500;
            }

            .success {
                background-color: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .error {
                background-color: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }

            .btn {
                display: inline-block;
                padding: 12px 24px;
                text-decoration: none;
                border-radius: 5px;
                font-weight: 500;
                transition: all 0.3s;
                border: none;
                cursor: pointer;
                font-size: 14px;
            }

            .btn-primary {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            }

            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }

            .btn-danger {
                background-color: #dc3545;
                color: white;
                padding: 8px 16px;
                font-size: 13px;
            }

            .btn-danger:hover {
                background-color: #c82333;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            thead {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
            }

            th, td {
                padding: 15px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                font-weight: 600;
                text-transform: uppercase;
                font-size: 13px;
                letter-spacing: 0.5px;
            }

            tbody tr {
                transition: background-color 0.2s;
            }

            tbody tr:hover {
                background-color: #f8f9fa;
            }

            .actions {
                display: flex;
                gap: 10px;
            }

            .empty-state {
                text-align: center;
                padding: 60px 20px;
                color: #999;
            }

            .empty-state-icon {
                font-size: 64px;
                margin-bottom: 20px;
            }

            .pagination {
                margin: 20px 0;
                text-align: center;
            }

            .pagination a {
                padding: 8px 12px;
                margin: 0 4px;
                border: 1px solid #ddd;
                text-decoration: none;
                color: #333;
                border-radius: 4px;
                transition: background 0.3s;
            }

            .pagination a:hover {
                background-color: #667eea;
                color: white;
                border-color: #667eea;
            }

            .pagination strong {
                padding: 8px 12px;
                margin: 0 4px;
                background-color: #764ba2;
                color: white;
                border-radius: 4px;
            }

        </style>
    </head>
    <body>
        <div class="navbar">
            <h2>📚 Student Management System</h2>
            <div class="navbar-right">
                <div class="user-info">
                    <span>Welcome, ${sessionScope.fullName}</span>
                    <span class="role-badge role-${sessionScope.role}">
                        ${sessionScope.role}
                    </span>
                </div>
                <a href="dashboard">Dashboard</a>
                <a href="logout">Logout</a>
            </div>
        </div>

        <div class="container">
            <p class="subtitle">MVC Pattern with Jakarta EE & JSTL</p>

            <!-- Success Message -->
            <c:if test="${not empty param.message}">
                <div class="message success">
                    ✅ ${param.message}
                </div>
            </c:if>

            <!-- Error Message -->
            <c:if test="${not empty param.error}">
                <div class="message error">
                    ❌ ${param.error}
                </div>
            </c:if>

            <!-- Add New Student Button -->
            <c:if test="${sessionScope.role eq 'admin'}">
                <div style="margin-bottom: 20px;">
                    <a href="student-list?action=new" class="btn btn-primary">
                        ➕ Add New Student
                    </a>
                </div>
            </c:if>

            <!--Search Student-->
            <div class="search-box">
                <form action="student-list" method="get">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" placeholder="Search by name, code, or email" value="${keyword}">
                    <button type="submit">🔍 Search</button>
                    <c:if test="${not empty keyword}">
                        <a href="student-list?action=list">Clear</a>
                    </c:if>

                </form>
            </div>

            <c:if test="${not empty keyword}">
                <p>Search results for: <strong>${keyword}</strong></p>
            </c:if>

            <!-- Student Table -->
            <c:choose>
                <c:when test="${not empty students}">
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-state-icon">📭</div>
                        <h3>No students found</h3>
                        <p>Start by adding a new student</p>
                    </div>
                </c:otherwise>
            </c:choose>
                    <table>
                        <thead>
                            <tr>
                                <th><a href="student-list?action=sort&sortBy=id&order=asc">ID</a></th>
                                <th><a href="student-list?action=sort&sortBy=student_code&order=asc">Code</a></th>
                                <th><a href="student-list?action=sort&sortBy=full_name&order=asc">Name</a></th>
                                <th><a href="student-list?action=sort&sortBy=email&order=asc">Email</a></th>
                                <th><a href="student-list?action=sort&sortBy=major&order=asc">Major</a></th>
                                <c:if test="${sessionScope.role eq 'admin'}">
                                    <th>Actions</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="student" items="${students}">
                                <tr>
                                    <td>${student.id}</td>
                                    <td><strong>${student.studentCode}</strong></td>
                                    <td>${student.fullName}</td>
                                    <td>${student.email}</td>
                                    <td>${student.major}</td>
                                    <c:if test="${sessionScope.role eq 'admin'}">
                                        <td>
                                            <div class="actions">
                                                <a href="student-list?action=edit&id=${student.id}" class="btn btn-secondary">
                                                    ✏️ Edit
                                                </a>
                                                <a href="student-list?action=delete&id=${student.id}"
                                                   class="btn btn-danger"
                                                   onclick="return confirm('Are you sure you want to delete this student?')">
                                                    🗑️ Delete
                                                </a>
                                            </div>
                                        </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!--Pagination -->
                    <c:if test="${totalPages > 1}">
                        <div class="pagination">
                            <!-- Previous button -->
                            <c:if test="${currentPage > 1}">
                                <a href="student-list?action=list&page=${currentPage - 1}">« Previous</a>
                            </c:if>

                            <!-- Page numbers -->
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <c:choose>
                                    <c:when test="${i == currentPage}">
                                        <strong>${i}</strong>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="student-list?action=list&page=${i}">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <!-- Next button -->
                            <c:if test="${currentPage < totalPages}">
                                <a href="student-list?action=list&page=${currentPage + 1}">Next »</a>
                            </c:if>
                        </div>

                        <p>Showing page ${currentPage} of ${totalPages}</p>
                    </c:if>

        </div>
    </body>
    </html>
