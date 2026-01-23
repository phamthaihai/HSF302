<h2>User Profile</h2>
Email: ${sessionScope.loggedUser.email} <br/>
Full Name: ${sessionScope.loggedUser.fullName} <br/>

<a href="${pageContext.request.contextPath}/user/logout">Logout</a>
