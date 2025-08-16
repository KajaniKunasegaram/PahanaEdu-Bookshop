/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DBAccess;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author kajani.k
 */
public class DBConnection {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/bookshop";
    private static final String DB_USERNAME = "root";
    private static final String DB_PASSWORD = "";
    
    private static DBConnection instance;
    
    private Connection connection;
    
    private DBConnection() throws SQLException
    {
         try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found.", e);
        }        
    }
   
    public static DBConnection getInstance() throws SQLException {
        if (instance == null || instance.getConnection().isClosed()) {
            instance = new DBConnection();
        }
        return instance;
    }    
    public Connection getConnection() {
        return connection;
    }
}
