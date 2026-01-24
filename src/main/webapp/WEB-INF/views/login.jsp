<h2>User Login</h2>
<form action="${pageContext.request.contextPath}/user/login" method="post">
    Email: <input type="text" name="email"/><br/>
    Password: <input type="password" name="password"/><br/>
    <button type="submit">Login</button>
</form>
<p style="color:red">${error}</p>
<a href="${pageContext.request.contextPath}/user/register">Register</a>
