package controllers;

import java.sql.*;
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
import models.CategoryModel;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addCategory(request, response);
        } else if ("update".equals(action)) {
            updateCategory(request, response);
        } else {
            response.sendError(400, "Invalid POST action");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            deleteCategory(request, response);
        } else {
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                List<CategoryModel> searchResults = searchCategories(search.trim());
                request.setAttribute("categories", searchResults);
                request.setAttribute("totalCategories", searchResults.size());
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", 1);
            } else {
                int page = 1;
                int recordsPerPage = 10;

                if (request.getParameter("page") != null) {
                    try {
                        page = Integer.parseInt(request.getParameter("page"));
                    } catch (NumberFormatException e) {
                        page = 1;
                    }
                }

                List<CategoryModel> categoryList = getAllCategories((page - 1) * recordsPerPage, recordsPerPage);
                int totalCategories = getCategoriesCount();
                int totalPages = (int) Math.ceil(totalCategories * 1.0 / recordsPerPage);

                
                request.setAttribute("categories", categoryList);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("totalCategories", totalCategories);
            }

            request.getRequestDispatcher("/views/category.jsp").forward(request, response);
        }
    }

    private void addCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = DBConnection.getInstance().getConnection()) {
            String query = "INSERT INTO tblcategory (category_name, description) VALUES (?, ?)";
            try (PreparedStatement pst = connection.prepareStatement(query)) {
                pst.setString(1, request.getParameter("category_name"));
                pst.setString(2, request.getParameter("description"));

                int rowInserted = pst.executeUpdate();

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                if (rowInserted > 0) {
                    out.println("<script>");
                    out.println("window.parent.location.reload();");
                    out.println("alert('✅ Category added successfully!');");
                    out.println("window.parent.closeAddCategoryPopup();");
                    out.println("window.parent.document.getElementById('contentFrame').src = window.parent.document.getElementById('contentFrame').src;");
                    out.println("</script>");
                } else {
                    out.println("<script>");
                    out.println("alert('❌ Failed to add category');");
                    out.println("window.history.back();");
                    out.println("</script>");
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setContentType("text/plain");
            ex.printStackTrace(response.getWriter());
        }
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection connection = DBConnection.getInstance().getConnection()) {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendError(400, "Missing id parameter");
                return;
            }
            int id = Integer.parseInt(idStr);

            String category_name = request.getParameter("category_name");
            String description = request.getParameter("description");

            if (category_name == null || category_name.trim().isEmpty()) {
                response.sendError(400, "Missing category_name parameter");
                return;
            }

            String query = "UPDATE tblcategory SET category_name=?, description=? WHERE id=?";
            try (PreparedStatement pst = connection.prepareStatement(query)) {
                pst.setString(1, category_name);
                pst.setString(2, description);
                pst.setInt(3, id);

                int success = pst.executeUpdate();

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                if (success > 0) {
                    out.println("<script>");
                    out.println("window.parent.location.reload();");
                    out.println("alert('✅ Category updated successfully!');");
                    out.println("window.parent.closeAddCategoryPopup();");
                    out.println("window.parent.document.getElementById('contentFrame').src = window.parent.document.getElementById('contentFrame').src;");
                    out.println("</script>");
                } else {
                    out.println("<script>");
                    out.println("alert('❌ Failed to update Category');");
                    out.println("window.history.back();");
                    out.println("</script>");
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setContentType("text/plain");
            ex.printStackTrace(response.getWriter());
        }
    }

    private void deleteCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try (Connection connection = DBConnection.getInstance().getConnection()) {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.isEmpty()) {
                response.sendError(400, "Missing id parameter");
                return;
            }
            int id = Integer.parseInt(idStr);

            String query = "DELETE FROM tblcategory WHERE id=?";
            try (PreparedStatement pst = connection.prepareStatement(query)) {
                pst.setInt(1, id);
                int success = pst.executeUpdate();

                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                if (success > 0) {
                    out.println("<script>");
                    out.println("window.parent.location.reload();");
                    out.println("alert('✅ Category deleted successfully!');");
                    out.println("</script>");
                } else {
                    out.println("<script>");
                    out.println("alert('❌ Failed to delete category');");
                    out.println("window.history.back();");
                    out.println("</script>");
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            response.setContentType("text/plain");
            ex.printStackTrace(response.getWriter());
        }
    }

    private List<CategoryModel> getAllCategories(int offset, int noOfRecords) {
        List<CategoryModel> categories = new ArrayList<>();
        try (Connection connection = DBConnection.getInstance().getConnection()) {
            String query = "SELECT id, category_name, description  FROM tblcategory ORDER BY id DESC LIMIT ? , ?";
            try (PreparedStatement pst = connection.prepareStatement(query)) {
                pst.setInt(1, offset);
                pst.setInt(2, noOfRecords);

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

    private int getCategoriesCount() {
        int count = 0;
        try (Connection connection = DBConnection.getInstance().getConnection()) {
            String query = "SELECT COUNT(*) FROM tblcategory";
            try (PreparedStatement pst = connection.prepareStatement(query);
                    ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return count;
    }

    private List<CategoryModel> searchCategories(String keyword) {
        List<CategoryModel> categories = new ArrayList<>();
        try (Connection connection = DBConnection.getInstance().getConnection()) {
            String query = "SELECT * FROM tblcategory WHERE category_name LIKE ? OR description LIKE ?";
            try (PreparedStatement pst = connection.prepareStatement(query)) {
                String searchValue = "%" + keyword + "%";
                pst.setString(1, searchValue);
                pst.setString(2, searchValue);

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
