<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Admin Dashboard</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/dashboard.css">

</head>
<body>

<h2>Admin Dashboard</h2>

<a href="${pageContext.request.contextPath}/admin/users">
    View User List
</a>
<br/><br/>

<a href="${pageContext.request.contextPath}/admin/users/add">
    Add New User
</a>

</body>
</html>
