<%-- 
    Document   : customers
    Created on : Jul 20, 2025, 11:02:43 PM
    Author     : Kajani.K
--%>

<%@page import="models.CustomerModel"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Customer Management</title>
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
        <h2>Customer Management</h2>
        <form action="CustomerServlet" method="get" class="search-form">
            <input type="text" name="search" id="searchInput"
                   placeholder="Search customer..."
                   value="<%= searchQuery != null ? searchQuery : "" %>"
                   onkeyup="this.form.submit();" />
        </form>
        <button class="add-btn" onclick="openAddCustomerPopup()">+ Add Customer</button>
    </div>

    <div class="page-container">
        <div class="table-section">
            <table>
              <thead>
                <tr>
                  <th>Account No</th>
                  <th>Name</th>
                  <th>Address</th>
                  <th>Phone</th>
                  <th>Edit</th>
                  <th>Delete</th>
                </tr>
              </thead>
              <tbody id="customerTableBody">
                <%
                    List<CustomerModel> customers = (List<CustomerModel>) request.getAttribute("customers");
                    if (customers != null && !customers.isEmpty()) {
                        for (CustomerModel customer : customers) {
                %>
                <tr>
                    
                    <td><%= customer.getAccountNo() %></td>
                    <td><%= customer.getName() %></td>
                    <td><%= customer.getAddress() %></td>
                    <td><%= customer.getPhone() %></td>
                    <td class="actions">
                        <button class="edit"
                                onclick="openEditCustomerPopup(<%= customer.getId() %>,
                                        '<%= customer.getAccountNo() %>',
                                        '<%= customer.getName() %>',    
                                        '<%= customer.getPhone() %>',
                                        '<%= customer.getAddress() %>')">Edit</button>
                    </td>
                    <td class="actions">
                        <button class="delete" onclick="openDeleteCustomerPopup(<%= customer.getId() %>)">Delete</button>
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
                        No customer found.
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
                <span>Total Customers: <strong><%= request.getAttribute("totalCustomers") %></strong></span>

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
                    <a href="CustomerServlet?page=<%= i %><%= searchParam %>"><%= i %></a>
                    <%
                            }
                        }
                    %>
                    <span><%= currentPage %> of <%= totalPages %> pages</span>
            </div>
        </div>
            
    </div>
    
    <div id="addCustomerPopup" class="add-popup-overlay">
        <div class="add-popup-content" style="width: 30%; height: 480px;">
        <div class="add-popup-header">
            <h2 id="popup-title">Add New Customer</h2>
            <button class="add-popup_close" onclick="closeAddCustomerPopup()">X</button>
        </div>
            <iframe id="popup-frame" class="frame"></iframe>
      </div>
    </div>
    
    <div id="deleteCustomerPopup" class="add-popup-overlay">
        <div class="delete-popup-content">
            <p class="confirmation">Delete Confirmation</p>
            <p class="confirm">Are you sure you want to delete this customer?</p>
            <form id="deleteForm" method="get" action="CustomerServlet">
                <input type="hidden" name="action" value="delete"/>
                <input type="hidden" name="id" id="deleteCustomerId"/>
                <div class="delete-actions">
                    <button type="submit" class="btn-yes">Yes</button>
                    <button type="button" class="btn-no" onclick="closeDeleteCustomerPopup()">No</button>
                </div>
            </form>
        </div>
    </div>
     
    <script>
        function openAddCustomerPopup() {
            document.getElementById("popup-title").innerText = "Add New Customer";
            document.getElementById("popup-frame").src = "views/popups/addCustomer.jsp";
            document.getElementById("addCustomerPopup").style.display = "flex";
        }
        
        function closeAddCustomerPopup() {
            document.getElementById("addCustomerPopup").style.display = "none";
            location.reload();
        }
        
        function openEditCustomerPopup(id, account_no, name, phone, address) {
            document.getElementById("popup-title").innerText = "Update Customer";

            const params = new URLSearchParams({
                action: "update",
                id, account_no, name, phone, address
            });

            document.getElementById("popup-frame").src = "views/popups/addCustomer.jsp?" + params.toString();
            document.getElementById("addCustomerPopup").style.display = "flex";
        }
    
        function openDeleteCustomerPopup(customerId) {
            document.getElementById("deleteCustomerPopup").style.display = "flex";
            document.getElementById("deleteCustomerId").value = customerId;
        }
    
        function closeDeleteCustomerPopup() {
            document.getElementById("deleteCustomerPopup").style.display = "none";
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
