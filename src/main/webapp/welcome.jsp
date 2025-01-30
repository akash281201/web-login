<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <% String username = (String) session.getAttribute("username"); %>
    <h1>Welcome, <%= username %>!</h1>
    <p>Login successful.</p>
    <a href="login.jsp">Logout</a>
</body>
</html>