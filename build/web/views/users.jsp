<%-- 
    Document   : users
    Created on : Jul 20, 2025, 11:02:56 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="models.UserModel" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
    <h2>User Management</h2>
    <form action="UserServlet" method="get" class="search-form">
        <input type="text" name="search" id="searchInput"
               placeholder="Search user..."
               value="<%= searchQuery != null ? searchQuery : "" %>"
               onkeyup="this.form.submit();" />
    </form>
    <button class="add-btn" onclick="openAddUserPopup()">+ Add User</button>
</div>

<div class="page-container">
    <div class="table-section">
        <% List<UserModel> users = (List<UserModel>) request.getAttribute("users"); %>
        <table>
            <thead>
                <tr>
                    <th>Username</th><th>Password</th><th>Phone</th><th>Email</th><th>Role</th><th>Address</th><th>Status</th><th>Edit</th><th>Delete</th>
                </tr>
            </thead>
            <tbody id="userTableBody">
                <%
                    if(users != null && !users.isEmpty()) {
                        for(UserModel u: users) {
                %>
                <tr>
                    <td><%= u.getUsername() %></td>
                    <td><%= u.getPassword() %></td>
                    <td><%= u.getPhone() %></td>
                    <td><%= u.getMail() %></td>
                    <td><%= u.getRole() %></td>
                    <td><%= u.getAddress() %></td>
                    <td><%= u.getStatus() %></td>
                    <td class="actions"><button class="edit" onclick="openEditUserPopup(<%=u.getId()%>,
                                 '<%= u.getUsername() %>',
                                    '<%= u.getPhone() %>',
                                    '<%= u.getStatus() %>',
                                    '<%= u.getPassword() %>',
                                    '<%= u.getMail() %>',
                                    '<%= u.getRole() %>',
                                    '<%= u.getAddress() %>')">Edit</button></td>
                    <td class="actions"><button class="delete" onclick="openDeleteUserPopup(<%=u.getId()%>)">Delete</button></td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="9" style="text-align: center; color: crimson; font-size: 20px; font-weight: bold;">
                        <i class="fas fa-exclamation-triangle" style="color: crimson; margin-right: 8px;"></i>
                        No user found.
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>

    
    </div>

    <!-- Pagination (always shown) -->
    <div class="pagination-wrapper">
        <div class="pagination-line">
            <span>Total Users: <strong><%= request.getAttribute("totalUsers") %></strong></span>

            <div class="pagination-controls">
                <%
                    int currentPage = (int) request.getAttribute("currentPage");
                    int totalPages = (int) request.getAttribute("totalPages");
                    String searchParam = searchQuery != null ? "&search=" + searchQuery : "";

                    for (int i = 1; i <= totalPages; i++) {
                        if (i == currentPage) {
                %>
                <span class="active-page"><%= i %></span>
                <%
                        } else {
                %>
                <a href="UserServlet?page=<%= i %><%= searchParam %>"><%= i %></a>
                <%
                        }
                    }
                %>
            </div>

            <span><%= currentPage %> of <%= totalPages %> pages</span>
        </div>
    </div>
</div>

<!-- Add/Edit Popup -->
<div id="addUserPopup" class="add-popup-overlay">
    <div class="add-popup-content">
        <div class="add-popup-header">
            <h2 id="popup-title">Add New User</h2>
            <button class="add-popup_close" onclick="closeAddUserPopup()">X</button>
        </div>
        <iframe id="popup-frame" class="frame"></iframe>
    </div>
</div>

<!-- Delete Popup -->
<div id="deleteUserPopup" class="add-popup-overlay">
    <div class="delete-popup-content">
        <p class="confirmation">Delete Confirmation</p>
        <p class="confirm">Are you sure you want to delete this user?</p>
        <form id="deleteForm" method="get" action="UserServlet">
            <input type="hidden" name="action" value="delete"/>
            <input type="hidden" name="id" id="deleteUserId"/>
            <div class="delete-actions">
                <button type="submit" class="btn-yes">Yes</button>
                <button type="button" class="btn-no" onclick="closeDeleteUserPopup()">No</button>
            </div>
        </form>
    </div>
</div>

<!-- Scripts -->
<script>
    function openAddUserPopup() {
        document.getElementById("popup-title").innerText = "Add New User";
        document.getElementById("popup-frame").src = "views/popups/addUser.jsp";
        document.getElementById("addUserPopup").style.display = "flex";
    }

    function closeAddUserPopup() {
        document.getElementById("addUserPopup").style.display = "none";
        location.reload();
    }

    function openEditUserPopup(id, username, phone, status, password, email, role, address) {
        document.getElementById("popup-title").innerText = "Update User";

        const params = new URLSearchParams({
            action: "update",
            id, username, phone, status, password, email, role, address
        });

        document.getElementById("popup-frame").src = "views/popups/addUser.jsp?" + params.toString();
        document.getElementById("addUserPopup").style.display = "flex";
    }

    function openDeleteUserPopup(userId) {
        document.getElementById("deleteUserPopup").style.display = "flex";
        document.getElementById("deleteUserId").value = userId;
    }

    function closeDeleteUserPopup() {
        document.getElementById("deleteUserPopup").style.display = "none";
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