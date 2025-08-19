/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import DAO.CategoryDAO;
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
import models.CategoryCollection;
import models.CategoryModel;
import models.StockModel;

/**
 *
 * @author HP
 */
@WebServlet("/SalesServlet")
public class SalesServlet extends HttpServlet {

      protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        // Fetch all categories
        CategoryDAO dao = new CategoryDAO();
        List<CategoryModel> categories = dao.getAllCategories();
        CategoryCollection collection = new CategoryCollection(categories);
        request.setAttribute("categoryCollection", collection);

        // Get category filter from request
        String categoryIdParam = request.getParameter("categoryId");
        List<models.StockModel> stockList;
        if(categoryIdParam == null || categoryIdParam.equals("all")) {
            // Show all stocks
            stockList = getAllStock(); // your method to get all stock
        } else {
            int categoryId = Integer.parseInt(categoryIdParam);
            stockList = getStockByCategory(categoryId); // method to get stock by category
        }

        request.setAttribute("stockList", stockList);

        request.getRequestDispatcher("views/sales.jsp").forward(request, response);
    }
      
    private List<models.StockModel> getStockByCategory(int categoryId) {
        List<models.StockModel> stocks = new ArrayList<>();
        String query = "SELECT s.id, b.title, c.category_name, s.quantity, s.total_qty, b.price, b.image_path " +
                       "FROM tblstock s " +
                       "JOIN tblbook b ON s.book_id = b.id " +
                       "JOIN tblcategory c ON b.category_id = c.id " +
                       "WHERE c.id = ? " +
                       "ORDER BY b.title";

        try (Connection conn = DBAccess.DBConnection.getInstance().getConnection();
             PreparedStatement pst = conn.prepareStatement(query)) {

            pst.setInt(1, categoryId);

            try (ResultSet rs = pst.executeQuery()) {
                while(rs.next()) {
                    models.StockModel stock = new models.StockModel.Builder()
                        .setId(rs.getInt("id"))
                        .setTitle(rs.getString("title"))
                        .setCategoryName(rs.getString("category_name"))
                        .setQuantity(rs.getInt("quantity"))
                        .setTotalQty(rs.getInt("total_qty"))
                        .setPrice(rs.getDouble("price"))
                        .setImagePath(rs.getString("image_path"))
                        .build();
                    stocks.add(stock);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return stocks;
    }
    
    private List<models.StockModel> getAllStock() {
        List<models.StockModel> stocks = new ArrayList<>();
        String query = "SELECT s.id, b.title, c.category_name, s.quantity, s.total_qty, b.price, b.image_path " +
                       "FROM tblstock s " +
                       "JOIN tblbook b ON s.book_id = b.id " +
                       "JOIN tblcategory c ON b.category_id = c.id " +
                       "ORDER BY b.title";

        try (Connection conn = DBAccess.DBConnection.getInstance().getConnection();
             PreparedStatement pst = conn.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {

            while(rs.next()) {
                models.StockModel stock = new models.StockModel.Builder()
                    .setId(rs.getInt("id"))
                    .setTitle(rs.getString("title"))
                    .setCategoryName(rs.getString("category_name"))
                    .setQuantity(rs.getInt("quantity"))
                    .setTotalQty(rs.getInt("total_qty"))
                    .setPrice(rs.getDouble("price"))
                    .setImagePath(rs.getString("image_path"))
                    .build();
                stocks.add(stock);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return stocks;
    }

}