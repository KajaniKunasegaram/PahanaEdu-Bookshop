<%-- 
    Document   : addBook
    Created on : Jul 29, 2025, 3:52:12 PM
    Author     : HP
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="models.CategoryModel"%>
<%@page import="models.BookModel"%>

<%
    String action = request.getParameter("action");
    BookModel book = (BookModel) request.getAttribute("book");

    String id = (book != null) ? String.valueOf(book.getId()) : "";
    String title = (book != null) ? book.getTitle() : "";
    String author = (book != null) ? book.getAuthor() : "";
    String price = (book != null) ? String.valueOf(book.getPrice()) : "";
    String category_id = (book != null) ? String.valueOf(book.getCategoryId()) : "";
    String image_path = (book != null) ? book.getImagePath() : "";

    boolean isUpdate = "update".equalsIgnoreCase(action);

    List<CategoryModel> categories = (List<CategoryModel>) request.getAttribute("categories");
%>


<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><%= isUpdate ? "Update Book" : "Add Book" %></title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addPopupStyle.css">
  <style>
      .img-preview {
          margin-top: 8px;
          max-width: 120px;
          max-height: 160px;
          border: 1px solid #ddd;
          border-radius: 4px;
      }
  </style>
</head>
<body>

<div class="container">
  <form action="${pageContext.request.contextPath}/BookServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="action" value="<%= isUpdate ? "update" : "add" %>">
        <input type="hidden" name="id" value="<%= id %>">
        <input type="hidden" name="oldImage" value="<%= image_path %>"><!-- Keep old image path -->

        <div class="add-group">
            <label for="title">Title</label>
            <input type="text" id="title" name="title" required value="<%= title %>">
        </div>

        <div class="add-group">
            <label for="author">Author</label>
            <input type="text" id="author" name="author" value="<%= author %>">
        </div>

        <div class="add-group">
            <label for="price">Price</label>
            <input type="number" step="0.01" id="price" name="price" value="<%= price %>">
        </div>

        <div class="add-group">
            <label for="category_id">Category</label>
            <select id="category_id" name="category_id" required>
                <option value="">-- Select Category --</option>
                <%
                    if (categories != null && !categories.isEmpty()) {
                        for (CategoryModel c : categories) {
                            String selected = (category_id != null && category_id.equals(String.valueOf(c.getId()))) ? "selected" : "";
                %>
                            <option value="<%= c.getId() %>" <%= selected %>><%= c.getName() %></option>
                <%
                        }
                    } else {
                %>
                    <option disabled style="color:red;">No categories available</option>
                <%
                    }
                %>
            </select>
        </div>

        <div class="add-group">
            <label for="image_path">Book Image</label>
            <input type="file" id="image_path" name="image_path" accept="image/*" <%= isUpdate ? "" : "required" %>>
            <% if (isUpdate && image_path != null && !image_path.isEmpty()) { %>
                <img src="${pageContext.request.contextPath}/uploads/<%= image_path %>" 
                     alt="Current Book Image" class="img-preview">
            <% } %>
        </div>

        <div class="add-actions" style="margin-right: 10px;">
            <button type="submit" class="btn-save">Save</button>
            <button type="button" class="btn-cancel" onclick="parent.closeAddBookPopup()">Cancel</button>
        </div>
    </form>
</div>

</body>
</html>