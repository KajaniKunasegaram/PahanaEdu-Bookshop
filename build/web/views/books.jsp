<%-- 
    Document   : books
    Created on : Aug 5, 2025, 3:29:59 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
        <title>Books Management</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popupStyle.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewStyle.css">     
    </head>
    <body>
        <div class="heading">
            <h2>Stock Management</h2>
            <button class="add-btn" onclick="openAddStockPopup()">+ Add Stock</button>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Date</th>
                    <th>Edit</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>aaaaa</td>
                    <td>aaaaaaa</td>
                    <td>15</td>
                    <td>10</td>
                    <td>10-05-2025</td>
                    <td class="actions">
                      <button class="edit" onclick="openAddStockPopup()">Edit</button>
                    </td>
<!--                     <td class="actions">
                      <button class="delete" onclick="openDeleteCustomerPopup()">Delete</button>
                    </td>-->
                </tr>       
            </tbody>
        </table>

        <div id="addStockPopup" class="add-popup-overlay">
            <div class="add-popup-content" style="height: 340px;">
            <div class="add-popup-header">
                <h2>Add New Stock</h2>
                <button class="add-popup_close" onclick="closeAddStockPopup()">X</button>
            </div>
                <iframe src="popups/addStock.jsp" class="frame" ></iframe>
          </div>
        </div>
        
        <script>
            function openAddStockPopup()
            {
                document.getElementById("addStockPopup").style.display = "flex";
            }
            
            function closeAddStockPopup()
            {
                document.getElementById("addStockPopup").style.display ="none";
            }
        </script>
        
    </body>
</html>

