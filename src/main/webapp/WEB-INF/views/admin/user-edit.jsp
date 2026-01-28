<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Update User</title>

    <!-- CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/user-edit.css">

</head>

<body>

<h2>Update User</h2>

<!-- HIỂN THỊ LỖI -->
<c:if test="${not empty error}">
    <div style="color:red; margin-bottom:10px;">
            ${error}
    </div>
</c:if>

<form:form method="post"
           action="${pageContext.request.contextPath}/admin/users/edit"
           modelAttribute="user">

    <form:hidden path="userId"/>

    <label>Full Name:</label><br>
    <form:input path="fullName"/>
    <br><br>

    <label>Email:</label><br>
    <form:input path="email"/>
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
