<%-- 
    Document   : stock.jsp
    Created on : Jul 29, 2025, 12:35:41 PM
    Author     : HP
--%>

<%@page import="models.StockModel"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
        <title>Stock Management</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popupStyle.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewStyle.css">     
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addPopupStyle.css">
        
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
                border-color: #ccc;
                outline: none;
            }
            img.book-thumb {
                width: 50px;
                height: 70px;
                object-fit: cover;
                border-radius: 4px;
            }
        </style>
    
    </head>
    <body>
        
        <%
            String searchQuery = request.getParameter("search");
            boolean isSearching = searchQuery != null && !searchQuery.trim().isEmpty();
        %>


        <div class="heading">
            <h2>Stock Management</h2>
            <form action="StockServlet" method="get" class="search-form">
                   
                <input style="margin-right:20px;" type="text" name="search" id="searchInput"
                       placeholder="Search stock..."
                       value="<%= searchQuery != null ? searchQuery : "" %>"
                        accept=""onkeyup="this.form.submit();" />
                
            </form>
            <!--<button class="add-btn" onclick="openAddStockPopup()">+ Add Stock</button>-->
        </div>
        
<div class="page-container">
    <div class="table-section">
        <table>
            <thead>
                <tr>
                    <th>Image</th>
                    <th>Title</th>
                    <th>Category</th>
                    <th>Qty</th>
                    <th>Total Qty</th>
                    <th>Price</th>
                    <th>Update Qty</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<StockModel> stockList = (List<StockModel>) request.getAttribute("stockList");
                    if (stockList != null && !stockList.isEmpty()) {
                        for (StockModel stock : stockList) { 
                %>
                    <tr>
                        <td>
                            <img src="uploads/<%= stock.getImagePath() %>" width="50" height="60" alt="Book Image">
                        </td>
                        <td><%= stock.getTitle() %></td>
                        <td><%= stock.getCategoryName() %></td>
                        <td><%= stock.getQuantity() %></td>
                        <td><%= stock.getTotalQuantity() %></td>
                        <td><%= stock.getPrice() %></td>
                        <td class="actions">
                            <button class="edit" onclick="openAddStockPopup(<%= stock.getId() %>)">Update</button>
                        </td>
                    </tr>
                <% 
                        }
                    } else { 
                %>
                <tr>
                    <td colspan="7" style="text-align: center; color: crimson; font-size: 20px; font-weight: bold;">
                        No stock found.
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
            <span>Total Stock <strong><%= request.getAttribute("totalStocks") %></strong></span>
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
                <a href="StockServlet?page=<%= i %><%= searchParam %>"><%= i %></a>
                <%
                        }
                    }
                %>
                <span><%= currentPage %> of <%= totalPages %> pages</span>
            </div>
        </div>
    </div>
</div>
                
        <div id="addStockPopup" class="add-popup-overlay">
            <form action="StockServlet" method="post">
                <div class="add-popup-content" style="height: 200px; width:400px; ">
                    <!--<div class="add-popup-header">-->
                        <h4 style="margin-left:20px;">Update stock quantity</h4>
                        <p style="margin-left:20px; margin-right:20px; font-size:14px; color:#555;">
                        The entered quantity will be <b>added</b> to the current stock.
                        </p>
                        <!--<button class="add-popup_close" onclick="closeAddStockPopup()">X</button>-->
                    <!--</div>-->
                    <input type="hidden" id="stockId" name="stockId">
                    <div class="add-group" style="margin-left:20px;margin-right: 20px;">
                        <input type="number" id="qty" name="qty" required>
                    </div>
                    <div class="add-actions" style="margin-right: 20px;">
                        <button type="submit" class="btn-save">Update</button>
                        <button type="button" class="btn-cancel" onclick="closeAddStockPopup()">Cancel</button>
                    </div>
                </div>
            </form>
        </div>
        
        <script>
            function openAddStockPopup(stockId)
            {
                document.getElementById("stockId").value = stockId;
                document.getElementById("addStockPopup").style.display = "flex";
            }
            
            function closeAddStockPopup()
            {
                document.getElementById("addStockPopup").style.display ="none";
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
