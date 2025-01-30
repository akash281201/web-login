<%@ page import="java.sql.*" contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password"); // In a real app, hash this!

    Connection connection = null;
    PreparedStatement statement = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load the MySQL driver
        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_db", "root", "October@2001"); // DB URL and credentials

        String sql = "INSERT INTO users (username, password) VALUES (?, ?)"; // Use a parameterized query!
        statement = connection.prepareStatement(sql);
        statement.setString(1, username);
        statement.setString(2, password); // Hash the password before storing!
        int rowsInserted = statement.executeUpdate();

        if (rowsInserted > 0) {
            response.sendRedirect("login.jsp?registration=success"); // Redirect to login with a success message
        } else {
            response.sendRedirect("register.jsp?error=registration_failed"); // Redirect back to registration with an error
        }

    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace(); // Handle exceptions appropriately (log them, display a user-friendly error message)
        response.sendRedirect("register.jsp?error=database_error");
    } finally {
        // Close resources in a finally block to ensure they are always closed
        try { if (statement != null) statement.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (connection != null) connection.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>