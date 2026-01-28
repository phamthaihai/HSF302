<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>

    <!-- CSS ADD USER -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/user-add.css">

</head>

<body>

<h2>Add New User</h2>

<!-- HIỂN THỊ LỖI -->
<c:if test="${not empty error}">
    <div style="color:red; margin-bottom:10px;">
            ${error}
    </div>
</c:if>

<form:form method="post"
           action="${pageContext.request.contextPath}/admin/users/add"
           modelAttribute="user">

    <label>Full Name:</label><br>
    <form:input path="fullName"/>
    <br><br>

    <label>Email:</label><br>
    <form:input path="email"/>
    <br><br>

    <label>Password:</label><br>
    <form:password path="password"/>
    <br><br>

    <label>Role:</label><br>
    <form:select path="roleId">
        <form:option value="2" label="TEACHER"/>
        <form:option value="3" label="STUDENT"/>
    </form:select>
    <br><br>

    <button type="submit">Save</button>

</form:form>

<br>
<a href="${pageContext.request.contextPath}/admin/users">
    ← Back to User List
</a>

</body>
</html>
