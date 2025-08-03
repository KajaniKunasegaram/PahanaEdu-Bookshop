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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popupStyle.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewStyle.css">
        <title>User Management</title>
    </head>
    <body>
           
        <div class="heading">
            <h2>User Management</h2>
            <button class="add-btn" onclick="openAddUserPopup()">+ Add User</button>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Phone No</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Address</th>
                    <th>Status</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                
                <%
                    List<UserModel> users = (List<UserModel>) request.getAttribute("users");
                    if(users !=null && !users.isEmpty())
                    {
                        for(UserModel user : users)
                        {
                        
                %>        
                        
                <tr>
                    <td><%= user.getUsername() %></td>
                    <td><%= user.getPassword() %></td>
                    <td><%= user.getPhone() %></td>
                    <td><%= user.getMail() %></td>
                    <td><%= user.getRole() %></td>
                    <td><%= user.getAddress() %></td>
                    <td><%= user.getStatus() %></td>

                    <td class="actions">
                        <button class="edit" 
                                onclick="openEditUserPopup(<%= user.getId() %>, 
                                            '<%= user.getUsername() %>', 
                                            '<%= user.getPhone() %>', 
                                            '<%= user.getStatus() %>', 
                                            '<%= user.getPassword() %>',
                                            '<%= user.getMail() %>', 
                                            '<%= user.getRole() %>', 
                                            '<%= user.getAddress() %>')">
                            Edit</button>
                    </td>
                    
                    <td class="actions">
                        <button class="delete" onclick="openDeleteUserPopup(<%= user.getId() %>)">Delete</button>
                    </td>
                </tr>
                <%
                        }
                    }
                    else
                    {
                %>
                
                <tr>
                    <td colspan="9">No user found.</td>
                </tr>
                <%
                    }
                %>
                
            </tbody>
        </table>
        
        <div id="addUserPopup" class="add-popup-overlay">
            <div class="add-popup-content">
                <div class="add-popup-header">
                    <h2 id="popup-title">Add New User</h2>
                    <button class="add-popup_close" onclick="closeAddUserPopup()">X</button>
                </div>
                <iframe id="popup-frame" class="frame"></iframe>
                <!--<iframe src="${pageContext.request.contextPath}/views/popups/addUser.jsp" class="frame" ></iframe>-->
            </div>
        </div>
            
        <div id="deleteUserPopup" class="add-popup-overlay">
            <div class="delete-popup-content"> 
                <P class="confirmation">Delete Confirmation</h3>
                <p class="confirm">Are you sure you want to delete this user?</p>
                
                <form id="deleteForm" method="get" action="UserServlet">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" id="deleteUserId" /> 
                    
                    <div class="delete-actions">
                        <button type="submit" class="btn-yes" >Yes</button>
                        <button type="button" class="btn-no" onclick="closeDeleteUserPopup()">No</button>
                    </div>
                    
                </form>

            </div>
        </div>
        
        
        
        <script>
            function openAddUserPopup()
            {
                document.getElementById("popup-title").innerText = "Add New User";
                document.getElementById("popup-frame").src = "views/popups/addUser.jsp";
                document.getElementById("addUserPopup").style.display="flex";
            }
            
            function closeAddUserPopup()
            {
                document.getElementById("addUserPopup").style.display="none";
                    location.reload();

            }
            
            function openEditUserPopup(id, username, phone, status, password, email, role, address)
            {
                document.getElementById("popup-title").innerText = "Update User";

                // Encode all parameters to avoid issues with spaces/special characters
                const params = new URLSearchParams({
                    action: "update",
                    id, username, phone, status, password, email, role, address
                });

                // ✅ Use correct ID
                document.getElementById("popup-frame").src = "views/popups/addUser.jsp?" + params.toString();
                document.getElementById("addUserPopup").style.display = "flex";
            }

            
//            function openEditUserPopup(id, username, phone, status, password, email, role, address)
//            {
//                document.getElementById("popupTitle").innerText = "Update User";
//
//                // Encode all parameters to avoid issues with spaces/special characters
//                const params = new URLSearchParams({
//                    action: "update",
//                    id, username, phone, status, password, email, role, address
//                });
//
//                document.getElementById("popupFrame").src = "views/popups/addUser.jsp?" + params.toString();
//                document.getElementById("addUserPopup").style.display = "flex";
//            }
            
            function openDeleteUserPopup(userId)
            {
                document.getElementById("deleteUserPopup").style.display="flex";
                document.getElementById("deleteUserId").value = userId;
            }
            
            function closeDeleteUserPopup()
            {
                document.getElementById("deleteUserPopup").style.display="none";
            }
            
            function DeleteConfirmUserPopup()
            {
                closeDeleteUserPopup();
            }
        </script>
    </body>
</html>
