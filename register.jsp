<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Result</title>
</head>
<body>
    <h2>Registration Result</h2>
    
    <%
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String password = request.getParameter("password");
        
        String dbUrl = "jdbc:mysql://localhost:3306/your_database_name"; // Replace with your DB URL
        String dbUser = "your_db_username"; // Replace with your DB username
        String dbPassword = "your_db_password"; // Replace with your DB password
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            
            String query = "INSERT INTO users (name, email, phone, password) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, phoneNumber);
            preparedStatement.setString(4, password);
            
            int rowsAffected = preparedStatement.executeUpdate();
            
            if (rowsAffected > 0) {
    %>
                <p>Registration successful!</p>
    <%
            } else {
    %>
                <p>Registration failed. Please try again.</p>
    <%
            }
            
            preparedStatement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
    %>
            <p>An error occurred: <%= e.getMessage() %></p>
    <%
        }
    %>
</body>
</html>
