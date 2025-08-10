<%-- 
    Document   : addCategory
    Created on : Aug 9, 2025, 10:02:42 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String action = request.getParameter("action");
    String id = request.getParameter("id");
    String category_name = request.getParameter("category_name");
    String description = request.getParameter("description");
    
    boolean isUpdate = "update".equals(action);

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Category</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addPopupStyle.css">
</head>
<body>
<div class="container">
    <form action="${pageContext.request.contextPath}/CategoryServlet" method="post">
        <input type="hidden" name="action" value="<%= isUpdate ? "update" : "add" %>">
        <input type="hidden" name="id" value="<%= id != null ? id : "" %>">

        <div class="add-group">
            <label for="category_name">Category Name</label>
            <input type="text" id="category_name" name="category_name" value="<%= category_name != null ? category_name : "" %>" required>
        </div>

        <div class="add-group">
            <label for="description">Description (Optional)</label>
            <textarea id="description" name="description" rows="2" placeholder="Enter category description"><%= description != null ? description : "" %></textarea>
        </div>

        <div class="add-actions" style="margin-right: 10px;">
            <button type="submit" class="btn-save">Save</button>
            <button type="button" class="btn-cancel" onclick="parent.closeAddCategoryPopup()">Cancel</button>
        </div>
    </form>
</div>
</body>
</html>