<%-- 
    Document   : addBook
    Created on : Jul 29, 2025, 3:52:12 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Book</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addPopupStyle.css">
        <style>
        .category-container {
            display: flex;
            width: 100%;
            gap: 5px; /* space between select and button */
        }

        .category-container select {
            flex: 1; /* take remaining width */
            padding: 4px;
            font-size: 14px;
        }

        .category-container button {
            padding: 4px 8px;
            font-size: 18px;
            cursor: pointer;
        }

        </style>
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
                            <div class="category-container">
                                <select id="category" name="category" required>
                                    <option value="">-- Select Category --</option>                                
                                    <option>vdff</option>                                
                                </select>
                                <button type="button" id="addCategoryBtn" title="Add New Category" onclick="openAddCategoryPopup()">+</button>
                            </div>
                        </div>               
                    </div>
                </div>
                <div class="add-actions">
                    <button type="submit" class="btn-save">Save</button>
                    <button type="button" class="btn-cancel" onclick="parent.closeAddCustomerPopup()">Cancel</button>
                </div>
            </form>
        </div>
        
        
        <script>
            function openAddCategoryPopup() {
                var popup = window.open(
                    "views/popups/addCategory.jsp", // path to popup JSP
                    "Add Category",
                    "width=500,height=400,resizable=no,scrollbars=yes"
                );
            }
            </script>
    </body>
</html>
