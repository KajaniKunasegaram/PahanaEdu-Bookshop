/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBAccess.DBConnection;
import models.UserModel;
import java.sql.*;

/**
 *
 * @author HP
 */
public class UserDAO {
   public UserModel getUserByUsernameOrEmail(String usernameOrEmail) {
        UserModel user = null;
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            String sql = "SELECT * FROM tbluser WHERE username=? OR email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new UserModel();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setMail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    } 
}
