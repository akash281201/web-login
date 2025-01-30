<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%
    String enteredUsername = request.getParameter("username");
    String enteredPassword = request.getParameter("password"); // Hash this before comparing!

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_db", "root", "October@2001");

        String sql = "SELECT * FROM users WHERE username = ?"; // Parameterized query
        statement = connection.prepareStatement(sql);
        statement.setString(1, enteredUsername);
        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String storedPassword = resultSet.getString("password");
            if (enteredPassword.equals(storedPassword)) { // Compare hashed passwords in real app!
                session.setAttribute("username", enteredUsername); // Store username in session
                response.sendRedirect("welcome.jsp");
            } else {
                response.sendRedirect("error.jsp?error=invalid_password");
            }
        } else {
            response.sendRedirect("error.jsp?error=user_not_found");
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace(); // Handle exceptions
        response.sendRedirect("login.jsp?error=database_error");
    } finally {
        try { if (resultSet != null) resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (statement != null) statement.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>