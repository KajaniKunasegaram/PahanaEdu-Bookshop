/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package services;

import DBAccess.DBConnection;
import models.UserModel;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP
 */
public class UserService {
    // Add User
    public void addUser(UserModel user) throws SQLException {
        Connection con = DBConnection.getInstance().getConnection();
        String query = "INSERT INTO tbluser(username,password,phone,email,status,role,address) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setString(1, user.getUsername());
        pst.setString(2, user.getPassword());
        pst.setString(3, user.getPhone());
        pst.setString(4, user.getMail());
        pst.setString(5, user.getStatus());
        pst.setString(6, user.getRole());
        pst.setString(7, user.getAddress());
        pst.executeUpdate();
    }

    // Update User
    public void updateUser(UserModel user) throws SQLException {
        Connection con = DBConnection.getInstance().getConnection();
        String query = "UPDATE tbluser SET username=?, password=?, phone=?, email=?, status=?, role=?, address=? WHERE id=?";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setString(1, user.getUsername());
        pst.setString(2, user.getPassword());
        pst.setString(3, user.getPhone());
        pst.setString(4, user.getMail());
        pst.setString(5, user.getStatus());
        pst.setString(6, user.getRole());
        pst.setString(7, user.getAddress());
        pst.setInt(8, user.getId());
        pst.executeUpdate();
    }

    // Delete User
    public void deleteUser(int userId) throws SQLException {
        Connection con = DBConnection.getInstance().getConnection();
        String query = "DELETE FROM tbluser WHERE id=?";
        PreparedStatement pst = con.prepareStatement(query);
        pst.setInt(1, userId);
        pst.executeUpdate();
    }

    // Get all Users
    public List<UserModel> getAllUsers() throws SQLException {
        List<UserModel> users = new ArrayList<>();
        Connection con = DBConnection.getInstance().getConnection();
        String query = "SELECT * FROM tbluser";
        ResultSet rs = con.prepareStatement(query).executeQuery();
        while(rs.next()) {
            UserModel u = new UserModel();
            u.setId(rs.getInt("id"));
            u.setUsername(rs.getString("username"));
            u.setPassword(rs.getString("password"));
            u.setPhone(rs.getString("phone"));
            u.setMail(rs.getString("email"));
            u.setStatus(rs.getString("status"));
            u.setRole(rs.getString("role"));
            u.setAddress(rs.getString("address"));
            users.add(u);
        }
        return users;
    }

}
