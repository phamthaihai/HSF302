<h2>User Register</h2>
<form action="${pageContext.request.contextPath}/user/register" method="post">
    Email: <input type="text" name="email"/><br/>
    Full Name: <input type="text" name="fullName"/><br/>
    Password: <input type="password" name="password"/><br/>
    <button type="submit">Register</button>
</form>
<a href="${pageContext.request.contextPath}/user/login">Login</a>
