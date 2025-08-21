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
import models.StockModel;

import java.sql.*;


/**
 *
 * @author HP
 */
@WebServlet("/StockServlet")
public class StockServlet extends HttpServlet {
       
     @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String search = request.getParameter("search");

            if (search != null && !search.trim().isEmpty()) {
                // Search mode
                List<StockModel> searchResults = searchStock(search.trim());
                request.setAttribute("stockList", searchResults);
                request.setAttribute("totalStocks", searchResults.size());
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", 1);
            } else {
                // Pagination mode
                int page = 1;
                int recordsPerPage = 10;

                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }

                List<StockModel> stocks = getAllStocks((page - 1) * recordsPerPage, recordsPerPage);
                int totalStocks = getStockCount();
                int totalPages = (int) Math.ceil(totalStocks * 1.0 / recordsPerPage);

                request.setAttribute("stockList", stocks);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("totalStocks", totalStocks);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("views/stock.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int stockId = Integer.parseInt(request.getParameter("stockId"));
        int qtyToAdd = Integer.parseInt(request.getParameter("qty"));

        try (Connection conn = DBConnection.getInstance().getConnection()) {

            String selectSQL = "SELECT quantity, total_qty FROM tblstock WHERE id = ?";
            try (PreparedStatement psSelect = conn.prepareStatement(selectSQL)) {
                psSelect.setInt(1, stockId);
                try (ResultSet rs = psSelect.executeQuery()) {
                    if (rs.next()) {
                        int currentQty = rs.getInt("quantity");
                        int currentTotal = rs.getInt("total_qty");

                        int newQty = currentQty + qtyToAdd;
                        int newTotal = currentTotal + qtyToAdd;

                        String updateSQL = "UPDATE tblstock SET quantity = ?, total_qty = ? WHERE id = ?";
                        try (PreparedStatement psUpdate = conn.prepareStatement(updateSQL)) {
                            psUpdate.setInt(1, newQty);
                            psUpdate.setInt(2, newTotal);
                            psUpdate.setInt(3, stockId);
                            psUpdate.executeUpdate();
                        }
                    }
                }
            }

            response.sendRedirect("StockServlet"); // Reload list

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ----------------- Builder-based methods -----------------

    private int getStockCount() {
        int count = 0;
        String query = "SELECT COUNT(*) FROM tblstock";

        try (Connection connection = DBConnection.getInstance().getConnection();
             PreparedStatement pst = connection.prepareStatement(query);
             ResultSet rs = pst.executeQuery()) {

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    private List<StockModel> getAllStocks(int offset, int noOfRecords) {
        List<StockModel> stocks = new ArrayList<>();
        String query = "SELECT s.id, b.title, c.category_name, s.quantity, s.total_qty, b.price, b.image_path " +
                "FROM tblstock s " +
                "JOIN tblbook b ON s.book_id = b.id " +
                "JOIN tblcategory c ON b.category_id = c.id " +
                "ORDER BY b.title LIMIT ?, ?";

        try (Connection connection = DBConnection.getInstance().getConnection();
             PreparedStatement pst = connection.prepareStatement(query)) {

            pst.setInt(1, offset);
            pst.setInt(2, noOfRecords);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    StockModel stock = new StockModel.Builder()
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

    private List<StockModel> searchStock(String keyword) {
        List<StockModel> stocks = new ArrayList<>();
        String query = "SELECT s.id, b.title, c.category_name, s.quantity, s.total_qty, b.price, b.image_path " +
                "FROM tblstock s " +
                "JOIN tblbook b ON s.book_id = b.id " +
                "JOIN tblcategory c ON b.category_id = c.id " +
                "WHERE (b.title LIKE ? OR c.category_name LIKE ? OR s.quantity LIKE ? OR s.total_qty LIKE ? OR b.price LIKE ?) " +
                "ORDER BY b.title";

        try (Connection connection = DBConnection.getInstance().getConnection();
             PreparedStatement pst = connection.prepareStatement(query)) {

            String searchValue = "%" + keyword + "%";
            pst.setString(1, searchValue);
            pst.setString(2, searchValue);
            pst.setString(3, searchValue);
            pst.setString(4, searchValue);
            pst.setString(5, searchValue);

            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    StockModel stock = new StockModel.Builder()
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

        System.out.println("Search results count: " + stocks.size());
        return stocks;
    }
}
    
