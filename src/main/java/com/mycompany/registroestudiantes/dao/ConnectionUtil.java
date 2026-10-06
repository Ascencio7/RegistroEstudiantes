package com.mycompany.registroestudiantes.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class ConnectionUtil {
    private ConnectionUtil() {
    }

    public static Connection getConnection() throws SQLException {
        String url = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/control_estudiantes_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
        String user = System.getenv().getOrDefault("DB_USER", "root");
        String password = System.getenv().getOrDefault("DB_PASSWORD", "");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            throw new SQLException("No se encontró el driver de MySQL.", ex);
        }

        return DriverManager.getConnection(url, user, password);
    }
}
