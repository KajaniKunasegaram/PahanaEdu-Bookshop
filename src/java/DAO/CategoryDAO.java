/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DBAccess.DBConnection;
import java.util.ArrayList;
import java.util.List;
import models.CategoryModel;
import java.sql.*;

/**
 *
 * @author HP
 */
public class CategoryDAO {
     public List<CategoryModel> getAllCategories() {
        List<CategoryModel> list = new ArrayList<>();
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            String query = "SELECT id, category_name, description FROM tblcategory ORDER BY id DESC";
            try (PreparedStatement pst = conn.prepareStatement(query)) {
                try (ResultSet rs = pst.executeQuery()) {
                    while (rs.next()) {
                        CategoryModel c = new CategoryModel();
                        c.setId(rs.getInt("id"));
                        c.setName(rs.getString("category_name"));
                        c.setDescription(rs.getString("description"));
                        list.add(c);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
