<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Result</title>
</head>
<body>
    <h2>Login Result</h2>
    
    <% 
        String enteredUsername = request.getParameter("email");
        String enteredPassword = request.getParameter("password");
        
        String dbUrl = "jdbc:mysql://localhost:3306/login"; // Replace with your DB URL
        String dbUser = "root"; // Replace with your DB username
        String dbPassword = "root"; // Replace with your DB password
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, enteredUsername);
            preparedStatement.setString(2, enteredPassword);
            
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
    %>
                <p>Login successful!</p>
    <%
      response.sendRedirect("home2.html");
            } else {
    %>
                <p>Login failed. Please check your username and password.</p>
    <%
            }
            
            resultSet.close();
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <p>An error occurred. Please try again later.</p>
    <%
        }
    %>
</body>
</html>
