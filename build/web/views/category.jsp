<%-- 
    Document   : category
    Created on : Aug 9, 2025, 9:41:08 AM
    Author     : HP
--%>

<%@page import="models.CategoryModel"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <title>Category Management</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popupStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewStyle.css">

    <style>
      .search-form {
       display: flex;
       align-items: center;
    }

     .search-form input[type="text"] {
         padding: 10px 10px;
         font-size: 14px;
         border-radius: 4px;
         border: 1px solid #ccc;
         width: 500px;
     }

     .search-form input[type="text"]:focus {
         border-color: #ccc; /* or any color you want */
         outline: none;
     }
    </style>
    
    
</head>
    <body>
        <%
        String searchQuery = request.getParameter("search");
        boolean isSearching = searchQuery != null && !searchQuery.trim().isEmpty();
        %>

        <div class="heading">
            <h2>Category Management</h2>
            <form action="CategoryServlet" method="get" class="search-form">
                <input type="text" name="search" id="searchInput"
                       placeholder="Search customer..."
                       value="<%= searchQuery != null ? searchQuery : "" %>"
                       onkeyup="this.form.submit();" />
            </form>
            <button class="add-btn" onclick="openAddCategoryPopup()">+ Add Category</button>
        </div>
        <div class="page-container">
            <div class="table-section">
                <table>
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th>Description</th>                  
                      <th>Edit</th>
                      <th>Delete</th>
                    </tr>
                  </thead>
                  <tbody id="customerTableBody">
                    <%
                        List<CategoryModel> categories = (List<CategoryModel>) request.getAttribute("categories");
                        if (categories != null && !categories.isEmpty()) {
                            for (CategoryModel category : categories) {
                    %>
                    <tr>

                        <td><%= category.getName() %></td>
                        <td><%= category.getDescription() %></td>
                        <td class="actions">
                            <button class="edit"
                                    onclick="openEditCategoryPopup(<%= category.getId() %>,
                                            '<%= category.getName() %>',
                                            '<%= category.getDescription() %>')">Edit</button>
                        </td>
                        <td class="actions">
                            <button class="delete" onclick="openDeleteCategoryPopup(<%= category.getId() %>)">Delete</button>
                        </td>                    
                    </tr>
                    <%
                        }
                    }
                        else
                        {
                    %>
                    <tr>
                        <td colspan="9" style="text-align: center; color: crimson; font-size: 20px; font-weight: bold;">
                            <i class="fas fa-exclamation-triangle" style="color: crimson; margin-right: 8px;"></i>
                            No category found.
                        </td>
                    </tr>
                    <%
                        }
                    %>
                  </tbody>
                </table>
            </div>
            <div class="pagination-wrapper">
                <div class="pagination-line">
                    <span>Total Category <strong><%= request.getAttribute("totalCategories") %></strong></span>

                    <div class="pagination-controls">
                        <%
                            Integer currentPageAttr = (Integer) request.getAttribute("currentPage");
                            Integer totalPagesAttr = (Integer) request.getAttribute("totalPages");

                            int currentPage = currentPageAttr != null ? currentPageAttr : 1;
                            int totalPages = totalPagesAttr != null ? totalPagesAttr : 1;

                            String searchParam = searchQuery != null ? "&search=" + searchQuery : "";

                            for (int i = 1; i <= totalPages; i++) {
                                if (i == currentPage) {
                        %>
                        <span class="active-page"><%= i %></span>
                        <%
                                } else {
                        %>
                        <a href="CategoryServlet?page=<%= i %><%= searchParam %>"><%= i %></a>
                        <%
                                }
                            }
                        %>
                        <span><%= currentPage %> of <%= totalPages %> pages</span>
                </div>
            </div>

        </div>

        <div id="addCategoryPopup" class="add-popup-overlay">
            <div class="add-popup-content" >
            <div class="add-popup-header">
                <h2 id="popup-title">Add New Category</h2>
                <button class="add-popup_close" onclick="closeAddCategoryPopup()">X</button>
            </div>
                <iframe id="popup-frame" class="frame"></iframe>
          </div>
        </div>

        <div id="deleteCategoryPopup" class="add-popup-overlay">
            <div class="delete-popup-content">
                <p class="confirmation">Delete Confirmation</p>
                <p class="confirm">Are you sure you want to delete this category?</p>
                <form id="deleteForm" method="get" action="CategoryServlet">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" id="deleteCategoryId"/>
                    <div class="delete-actions">
                        <button type="submit" class="btn-yes">Yes</button>
                        <button type="button" class="btn-no" onclick="closeDeleteCategoryPopup()">No</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openAddCategoryPopup() {
            document.getElementById("popup-title").innerText = "Add New Category";
            document.getElementById("popup-frame").src = "views/popups/addCategory.jsp";
            document.getElementById("addCategoryPopup").style.display = "flex";
        }
        
        function closeAddCategoryPopup() {
            document.getElementById("addCategoryPopup").style.display = "none";
            location.reload();
        }
        
        function openEditCategoryPopup(id, category_name, description) {
            document.getElementById("popup-title").innerText = "Update Category";

            const params = new URLSearchParams({
                action: "update",
                id, category_name, description
            });

            document.getElementById("popup-frame").src = "views/popups/addCategory.jsp?" + params.toString();
            document.getElementById("addCategoryPopup").style.display = "flex";
        }
    
        function openDeleteCategoryPopup(categoryId) {
            document.getElementById("deleteCategoryPopup").style.display = "flex";
            document.getElementById("deleteCategoryId").value = categoryId;
        }
    
        function closeDeleteCategoryPopup() {
            document.getElementById("deleteCategoryPopup").style.display = "none";
        }

        window.onload = function () {
            const input = document.getElementById("searchInput");
            input.focus();
            const length = input.value.length;
            input.setSelectionRange(length, length);
        };
    </script>
    
   
</body>
</html>