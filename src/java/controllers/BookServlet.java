/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import DBAccess.DBConnection;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import models.BookModel;



import java.sql.*;
import java.util.ArrayList;
import models.CategoryModel;
/**
 *
 * @author HP
 */

@WebServlet("/BookServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)

public class BookServlet extends HttpServlet {
 
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addBook(request, response);
        } else if ("update".equals(action)) {
            updateBook(request, response);
        }
    }
    
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            deleteBook(request, response);
        }

        if ("addForm".equals(action) || "updateForm".equals(action)) {
            List<CategoryModel> categories = loadCategories();
            request.setAttribute("categories", categories);

            if ("updateForm".equals(action)) {
                int bookId = Integer.parseInt(request.getParameter("id"));
                BookModel book = getBookById(bookId);
                request.setAttribute("book", book);
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("/views/popups/addBook.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // Default: show book list with pagination & search
        String search = request.getParameter("search");
        if (search != null && !search.trim().isEmpty()) {
            List<BookModel> searchResults = searchBooks(search.trim());
            request.setAttribute("books", searchResults);
            request.setAttribute("totalBooks", searchResults.size());
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
            request.setAttribute("totalBooks", totalBooks);
        }

        request.getRequestDispatcher("views/books.jsp").forward(request, response);
    }

    private void addBook(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try (Connection connection = DBConnection.getConnection()) {
            connection.setAutoCommit(false); // Start transaction

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            // Handle file upload
            Part filePart = request.getPart("image_path");
            String fileName = null;
            if (filePart != null && filePart.getSize() > 0) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                filePart.write(uploadPath + File.separator + fileName);
            }

            // Insert into tblbook and get ID
            String bookQuery = "INSERT INTO tblbook (title, author, price, category_id, image_path) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = connection.prepareStatement(bookQuery, Statement.RETURN_GENERATED_KEYS);

            pst.setString(1, request.getParameter("title"));
            pst.setString(2, request.getParameter("author"));
            pst.setDouble(3, Double.parseDouble(request.getParameter("price")));
            pst.setInt(4, Integer.parseInt(request.getParameter("category_id")));
            pst.setString(5, fileName != null ? fileName : "");

            int rowInserted = pst.executeUpdate();

            if (rowInserted > 0) {
                ResultSet rs = pst.getGeneratedKeys();
                int bookId = 0;
                if (rs.next()) {
                    bookId = rs.getInt(1);
                }

                if (bookId > 0) {
                    // Insert into tblstock
                    int initialQuantity = 0; // Change if you want from form
                    String stockQuery = "INSERT INTO tblstock (book_id, quantity) VALUES (?, ?)";
                    PreparedStatement stockPst = connection.prepareStatement(stockQuery);
                    stockPst.setInt(1, bookId);
                    stockPst.setInt(2, initialQuantity);

                    int stockInserted = stockPst.executeUpdate();

                    if (stockInserted > 0) {
                        connection.commit(); // Commit both inserts
                        response.setContentType("text/html");
                        PrintWriter out = response.getWriter();
                        out.println("<script>");
                        out.println("alert('✅ Book and stock added successfully!');");
                        out.println("window.parent.closeAddBookPopup();");
                        out.println("window.parent.location.reload();");
                        out.println("</script>");
                        return;
                    } else {
                        throw new SQLException("Failed to insert into tblstock.");
                    }
                } else {
                    throw new SQLException("Failed to retrieve new book ID.");
                }
            } else {
                throw new SQLException("Failed to insert into tblbook.");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.setContentType("text/plain");
            ex.printStackTrace(response.getWriter()); // Show exact error in browser
        }
    }

    
 
    
    private void updateBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try (Connection connection = DBConnection.getConnection()) {
            String query = "UPDATE tblbook SET title=?, author=?, price=?, category_id=?, image_path=? WHERE id=?";

            PreparedStatement pst = connection.prepareStatement(query);

            pst.setString(1, request.getParameter("title"));
            pst.setString(2, request.getParameter("author"));
            pst.setDouble(3, Double.parseDouble(request.getParameter("price")));
            pst.setInt(4, Integer.parseInt(request.getParameter("category_id")));

            Part filePart = request.getPart("image_path");
            if (filePart != null && filePart.getSize() > 0) {
                pst.setBlob(5, filePart.getInputStream());
            } else {
                pst.setNull(5, Types.BLOB);
            }

            pst.setInt(6, Integer.parseInt(request.getParameter("id")));

            int success = pst.executeUpdate();

            PrintWriter out = response.getWriter();
            response.setContentType("text/html");

            if (success > 0) {
                out.println("<script>alert('✅ Book updated successfully!'); window.location='BookServlet';</script>");
            } else {
                out.println("<script>alert('❌ Failed to update book'); history.back();</script>");
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(500, "Internal server error");
        }
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection connection = DBConnection.getConnection()) {
            String query = "DELETE FROM tblbook WHERE id=?";
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(request.getParameter("id")));

            int success = pst.executeUpdate();
            PrintWriter out = response.getWriter();
            response.setContentType("text/html");

            if (success > 0) {
                out.println("<script>alert('✅ Book deleted successfully!'); window.location='BookServlet';</script>");
            } else {
                out.println("<script>alert('❌ Failed to delete book'); history.back();</script>");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(500, "Internal server error");
        }
    }
    
    private List<BookModel> getAllBooks(int offset, int noOfRecords) {
    List<BookModel> books = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection()) {
            String query = "SELECT b.*, c.category_name " +
                           "FROM tblbook b " +
                           "JOIN tblcategory c ON b.category_id = c.id " +
                           "ORDER BY b.id DESC LIMIT ?, ?";
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setInt(1, offset);
            pst.setInt(2, noOfRecords);

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                BookModel book = new BookModel();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getDouble("price"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setCategoryName(rs.getString("category_name")); // ✅ set category name
                book.setImagePath(rs.getString("image_path"));
                books.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return books;
    }
  
    private BookModel getBookById(int id) {
        BookModel book = null;
        try (Connection connection = DBConnection.getConnection()) {
            String query = "SELECT * FROM tblbook WHERE id=?";
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setInt(1, id);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                book = new BookModel();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getDouble("price"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setImagePath(rs.getString("image_path"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return book;
    }

    private int getBookCount() {
        int count = 0;
        try (Connection connection = DBConnection.getConnection()) {
            String query = "SELECT COUNT(*) FROM tblbook";
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
    
    private List<BookModel> searchBooks(String keyword) {
    List<BookModel> books = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection()) {
            String query = "SELECT b.*, c.category_name " +
                           "FROM tblbook b " +
                           "JOIN tblcategory c ON b.category_id = c.id " +
                           "WHERE b.title LIKE ? OR b.author LIKE ? OR b.price LIKE ? OR c.category_name LIKE ?";

            PreparedStatement pst = connection.prepareStatement(query);
            String searchValue = "%" + keyword + "%";
            pst.setString(1, searchValue);
            pst.setString(2, searchValue);
            pst.setString(3, searchValue);
            pst.setString(4, searchValue);

            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                BookModel book = new BookModel();
                book.setId(rs.getInt("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setPrice(rs.getDouble("price"));
                book.setCategoryId(rs.getInt("category_id"));
                book.setCategoryName(rs.getString("category_name")); // ✅ Now this works
                book.setImagePath(rs.getString("image_path"));
                books.add(book);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return books;
    }

    private List<CategoryModel> loadCategories() {
        List<CategoryModel> categories = new ArrayList<>();
        try (Connection connection = DBConnection.getConnection()) {
            String query = "SELECT id, category_name, description FROM tblcategory ORDER BY id DESC";
            PreparedStatement pst = connection.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                CategoryModel c = new CategoryModel();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("category_name"));
                c.setDescription(rs.getString("description"));
                categories.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("Loaded categories count: " + categories.size());
        return categories;
    }
}