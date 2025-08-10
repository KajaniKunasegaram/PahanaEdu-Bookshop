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
import java.util.List;
import models.BookModel;

import java.sql.*;
import java.util.ArrayList;
/**
 *
 * @author HP
 */
@WebServlet("/BookServlet")
public class BookServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if("add".equals(action))
        {
            addBook(request,response);
        }
        else if("update".equals(action))
        {
            updateBook(request,response);
        }
        
    }
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String action = request.getParameter("action");
        if("delete".equals(action))
        {
            deleteBook(request,response);
        }
        else
        {
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                List<BookModel> searchResults = searchCustomers(search.trim());
                request.setAttribute("Books", searchResults);
                request.setAttribute("totalCustomers", searchResults.size());
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", 1);
            } else {
                int page = 1;
                int recordsPerPage = 10;

                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }

                List<BookModel> bookList = getAllBooks((page - 1) * recordsPerPage, recordsPerPage);
                int totalBooks = getBookCount();
                int totalPages = (int) Math.ceil(totalBooks * 1.0 / recordsPerPage);

                request.setAttribute("books", bookList);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("totalCustomers", totalBooks);
            }

            request.getRequestDispatcher("/views/books.jsp").forward(request, response);
        }
    }
    
    private void addBook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        try
        {
            Connection connection = DBConnection.getConnection();
            System.out.println("✅ Connection successful");
            String query ="INSERT INTO tblbook (account_no, name, phone, address) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = connection.prepareStatement(query);
            
            pst.setString(1, request.getParameter("title"));
            pst.setString(2, request.getParameter("author"));
            pst.setString(3, request.getParameter("price"));
            pst.setString(4, request.getParameter("categoryName"));
            
            int rowInserted = pst.executeUpdate();

            if (rowInserted > 0) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("window.parent.location.reload();");
                out.println("alert('✅ Book added successfully!');");

                out.println("window.parent.closeAddCustomerPopup();");
                out.println("window.parent.document.getElementById('contentFrame').src = window.parent.document.getElementById('contentFrame').src;");
                out.println("</script>");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("alert('❌ Failed to add book');");
                out.println("window.history.back();");
                out.println("</script>");
            }
            
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    
    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException
    {
        try
        {
            Connection connection = DBConnection.getConnection();
            String query ="UPDATE tblBook SET title=?, author=?, price=?,categoryName=? WHERE id=?";
            
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setString(1, request.getParameter("title"));
            pst.setString(2, request.getParameter("author"));
            pst.setString(3, request.getParameter("price"));
            pst.setString(4, request.getParameter("categoryName"));
            
            int success = pst.executeUpdate();
            if (success > 0) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("window.parent.location.reload();");
                out.println("alert('✅ Book updated successfully!');");

                out.println("window.parent.closeAddCustomerPopup();");
                out.println("window.parent.document.getElementById('contentFrame').src = window.parent.document.getElementById('contentFrame').src;");
                out.println("</script>");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("alert('❌ Failed to update Book');");
                out.println("window.history.back();");
                out.println("</script>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
     
     
    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException
    {
        try
        {
            Connection connection = DBConnection.getConnection();
            String query = "DELETE FROM tblbook WHERE id=?";
            
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(request.getParameter("id")));
            
            int success = pst.executeUpdate();
            if(success>0)
            {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("window.parent.location.reload();");
                out.println("alert('✅ book deleted successfully!');");
                out.println("</script>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();  
            
        }
    }
    
    private List<BookModel> getAllBooks(int offset, int noOfRecords) {
        List<BookModel> Customers = new ArrayList<>();

        try {
            Connection connection = DBConnection.getConnection();
            String query = "SELECT * FROM tblbook ORDER BY id DESC LIMIT ? , ?";
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setInt(1, offset);
            pst.setInt(2, noOfRecords);
            ResultSet result = pst.executeQuery();

            while (result.next()) {
                BookModel book = new BookModel();
                book.setId(result.getInt("id"));
                book.setTitle(result.getString("title"));
                book.setAuthor(result.getString("author"));
                book.setPrice(result.getDouble("price"));
                book.setCategoryName(result.getString("categoryName"));
                Customers.add(book);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return Customers;
    }
    
    private int getBookCount() {
        int count = 0;
        try {
            Connection connection = DBConnection.getConnection();
            String query = "SELECT COUNT(*) FROM tblcustomer ";
            PreparedStatement pst = connection.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    private List<BookModel> searchCustomers(String keyword) {
        List<BookModel> Books = new ArrayList<>();
            try {
                
                 Connection connection = DBConnection.getConnection();
            String query = "SELECT * FROM tblbook WHERE title LIKE "
                    + "? OR price LIKE ? OR author LIKE ? OR categoryName LIKE ?";
            PreparedStatement pst = connection.prepareStatement(query);
            String searchValue = "%" + keyword + "%";
            pst.setString(1, searchValue);
            pst.setString(2, searchValue);
            pst.setString(3, searchValue);
            pst.setString(4, searchValue);
            
            ResultSet result = pst.executeQuery();
            while (result.next()) {
                BookModel book = new BookModel();
                book.setTitle(result.getString("title"));
                book.setAuthor(result.getString("author"));
                book.setPrice(result.getDouble("price"));
                book.setCategoryName(result.getString("categoryName"));
                Books.add(book);
            }
            
                
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return Books;
    }


}
