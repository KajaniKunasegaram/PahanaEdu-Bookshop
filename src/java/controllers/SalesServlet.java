/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import DBAccess.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import models.CategoryModel;

/**
 *
 * @author HP
 */
@WebServlet("/SalesServlet")
public class SalesServlet extends HttpServlet {

      @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // get categories from DB
        List<CategoryModel> categories = getAllCategories();

        // put them in request scope
        request.setAttribute("categories", categories);

        // forward to sales.jsp
        request.getRequestDispatcher("views/sales.jsp").forward(request, response);
    }

    private List<CategoryModel> getAllCategories() {
        List<CategoryModel> categories = new ArrayList<>();
        try (Connection connection = DBConnection.getInstance().getConnection()) {
            String query = "SELECT id, category_name, description FROM tblcategory ORDER BY id DESC";
            try (PreparedStatement pst = connection.prepareStatement(query)) {
                try (ResultSet result = pst.executeQuery()) {
                    while (result.next()) {
                        CategoryModel category = new CategoryModel();
                        category.setId(result.getInt("id"));
                        category.setName(result.getString("category_name"));
                        category.setDescription(result.getString("description"));
                        categories.add(category);
                    }
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return categories;
    }
}

//    private void getAllCategories(HttpServletRequest request, HttpServletResponse response) 
//            throws ServletException, IOException {
//        List<CategoryModel> categories = new ArrayList<>();
//        try (Connection conn = DBConnection.getConnection()) {
//            String query = "SELECT id, category_name, description FROM tblcategory ORDER BY category_name";
//            PreparedStatement ps = conn.prepareStatement(query);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                CategoryModel category = new CategoryModel();
//                category.setId(rs.getInt("id"));
//                category.setName(rs.getString("category_name")); // matches JSP ${cat.name}
//                category.setDescription(rs.getString("description"));
//                categories.add(category);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        request.setAttribute("categories", categories);
//        request.getRequestDispatcher("sales.jsp").forward(request, response);
//    }

//}
