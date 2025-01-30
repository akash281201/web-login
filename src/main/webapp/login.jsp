<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
<h1>Login</h1>
<% String registrationSuccess = request.getParameter("registration");
   if("success".equals(registrationSuccess)){ %>
    <p style="color: green;">Registration Successful! Please Login.</p>
<% } %>
<form action="login_process.jsp" method="post">
    Username: <input type="text" name="username" required><br>
    Password: <input type="password" name="password" required><br>
    <input type="submit" value="Login">
</form>
<a href="register.jsp">Register</a> <%-- Link to the registration page --%>
</body>
</html>
