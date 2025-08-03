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
    private static final String DB_Password = "";
    
    static
    {
       try
        {
            Class.forName("com.mysql.cj.jdbc.Driver");
        }
        catch(ClassNotFoundException ex)
        {
            System.out.println("Mysql jdbc driver not found.");
            ex.printStackTrace();
        } 
    }
    
    
    public static Connection getConnection()
            throws SQLException
    {
        return DriverManager.getConnection(DB_URL,DB_USERNAME,DB_Password);
    }
}
