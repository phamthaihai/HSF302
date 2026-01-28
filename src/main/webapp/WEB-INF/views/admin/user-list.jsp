<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>User List</title>

    <!-- 🔥 CSS USER LIST -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/user-list.css">

</head>

<body>

<h2>User Account List</h2>
<div class="mb-3">
    <a href="${pageContext.request.contextPath}/admin/dashboard"
       class="btn btn-secondary">
        ⬅ Back to Dashboard

    </a>
</div>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Full Name</th>
        <th>Email</th>
        <th>Role</th>
        <th>Action</th> <!-- 🔥 thêm -->
    </tr>

    <c:forEach var="u" items="${users}">
        <tr>
            <td>${u.userId}</td>
            <td>${u.fullName}</td>
            <td>${u.email}</td>
            <td>${u.roleName}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/users/edit/${u.userId}">
                    Update
                </a>
                <a href="${pageContext.request.contextPath}/admin/users/delete/${u.userId}"
                   onclick="return confirm('Bạn có chắc muốn vô hiệu hóa tài khoản này?')"
                   style="color:red">
                    Delete
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
