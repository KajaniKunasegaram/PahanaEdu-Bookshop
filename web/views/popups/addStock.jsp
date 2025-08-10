<%-- 
    Document   : addStock
    Created on : Jul 29, 2025, 3:55:11 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Book</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addPopupStyle.css">
    </head>
    <body>
        <div class="container">
            <!--<h2>Add New Customer</h2>-->
            <form action="SaveCustomerServlet" method="post">
                <div class="add-container">

                    <div class="add-left">
                        <div class="add-group">
                            <label for="title">Book Title</label>
                            <input type="text" id="title" name="title" required>
                        </div>

                        <div class="add-group">
                            <label for="author">Author</label>
                            <input type="text" id="author" name="author" required>
                        </div>                   
                        
                    </div>

                    <div class="add-right">

                       <div class="add-group">
                            <label for="price">Price</label>
                            <input type="text" id="price" name="price" required>
                        </div>
                    
                        <div class="add-group">
                            <label for="category">Category</label>
                            <input type="text" id="category" name="category" required>
                        </div>               
                    </div>
                </div>
                <div class="add-actions">
                    <button type="submit" class="btn-save">Save</button>
                    <button type="button" class="btn-cancel" onclick="parent.closeAddCustomerPopup()">Cancel</button>
                </div>
            </form>
        </div>
    </body>
</html>
