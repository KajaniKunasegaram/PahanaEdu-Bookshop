<%-- 
    Document   : addUser
    Created on : Jul 24, 2025, 3:02:51 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String action = request.getParameter("action");
    String id = request.getParameter("id");
    String username = request.getParameter("username");
    String phone = request.getParameter("phone");
    String status = request.getParameter("status");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String role = request.getParameter("role");
    String address = request.getParameter("address");

    boolean isUpdate = "update".equals(action);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addPopupStyle.css">
        <title>Add User</title>
        
    </head>
    <body>
        
        <div class="container">
                <form action="${pageContext.request.contextPath}/UserServlet" method="post">
                    <input type="hidden" name="action" value="<%= isUpdate ? "update" : "add" %>">
                    <input type="hidden" name="id" value="<%= id != null ? id : "" %>">
                <div class="add-container" style="margin-top: -20px;">
                    <div>
                        <div class="add-group">
                            <label for="username">Username</label>
                            <input type="text" id="username" name="username" required value="<%= username != null ? username : "" %>">
                            <!--<span class="error-message" id="usernameError"></span>-->
                        </div>

                        <div class="add-group">
                            <label for="phone">Phone</label>
                            <input type="tel" id="phone" name="phone" required value="<%= phone != null ? phone : "" %>">

                            <!--<input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required>-->
                        </div>                        

                        <div class="add-group">
                            <label for="status">Status</label>
                            <select id="status" name="status" required>
                                <option value="">-- Select --</option>
                                <option value="active" <%= "active".equals(status) ? "selected" : "" %>>Active</option>
                                <option value="inactive" <%= "inactive".equals(status) ? "selected" : "" %>>Inactive</option>
                            </select>
                        </div>
                    </div>

                    <div>
                        <div class="add-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" name="password" required value="<%= password != null ? password : "" %>">
                        </div>

                        <div class="add-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" name="email" required value="<%= email != null ? email : "" %>">
                        </div>

                        <div class="add-group">
                            <label for="role">Role</label>
                            <select id="role" name="role" required>
                                <option value="">-- Select --</option>
                                <option value="admin" <%= "admin".equals(role) ? "selected" : "" %>>Admin</option>
<!--                                <option value="manager" <%= "admin".equals(role) ? "selected" : "" %>>Manager</option>
                                <option value="cashier" <%= "admin".equals(role) ? "selected" : "" %>>Cashier</option>-->
                                <option value="staff" <%= "admin".equals(role) ? "selected" : "" %>>Staff</option>
                            </select>
                        </div>                       
                    </div>                     

                    <div class="add-group full-width">
                        <label for="address">Address</label>
                        <textarea id="address" name="address" rows="2" required><%= address != null ? address : "" %></textarea>
                    </div>
                </div>

                <div class="add-actions" style="margin-top: -3px;">
                    <button type="submit" class="btn-save">Save</button>
                    <button type="button" class="btn-cancel" onclick="parent.closeAddUserPopup()">Cancel</button>
                </div>
            </form>
        </div>

<!--        <script>
            parent.closeAddUserPopup();
            parent.document.getElementById("contentFrame").src = parent.document.getElementById("contentFrame").src;
        </script>-->
    </body>
</html>
