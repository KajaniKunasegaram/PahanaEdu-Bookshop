<%-- 
    Document   : books
    Created on : Aug 5, 2025, 3:29:59 PM
    Author     : HP
--%>

<%@page import="models.BookModel"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">       
        <title>Books Management</title>
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
            <h2>Book Management</h2>
            <form action="BookServlet" method="get" class="search-form">
                <input type="text" name="search" id="searchInput"
                       placeholder="Search customer..."
                       value="<%= searchQuery != null ? searchQuery : "" %>"
                       onkeyup="this.form.submit();" />
            </form>
            <button class="add-btn" onclick="openAddBookPopup()">+ Add Book</button>
        </div>

        <div class="page-container">
            <div class="table-section">
                <table>
                  <thead>
                    <tr>
                      <th>Title</th>
                      <th>Author</th>
                      <th>Price</th>
                      <th>Category</th>
                      <th>Edit</th>
                      <th>Delete</th>
                    </tr>
                  </thead>
                  <tbody>
                    <%
                        List<BookModel> books = (List<BookModel>) request.getAttribute("books");
                        if (books != null && !books.isEmpty()) {
                            for (BookModel book : books) {
                    %>
                    <tr>

                        <td><%= book.getTitle() %></td>
                        <td><%= book.getAuthor() %></td>
                        <td><%= book.getPrice() %></td>
                        <td><%= book.getCategoryName() %></td>
                        <td class="actions">
                            <button class="edit"
                                    onclick="openEditBookPopup(<%= book.getId() %>,
                                            '<%= book.getTitle() %>',
                                            '<%= book.getAuthor() %>',    
                                            '<%= book.getPrice() %>',
                                            '<%= book.getCategoryName() %>')">Edit</button>
                        </td>
                        <td class="actions">
                            <button class="delete" onclick="openDeleteBookPopup(<%= book.getId() %>)">Delete</button>
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
                            No books found.
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
                    <span>Total Books: <strong><%= request.getAttribute("totalBooks") %></strong></span>

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
                        <a href="BookServlet?page=<%= i %><%= searchParam %>"><%= i %></a>
                        <%
                                }
                            }
                        %>
                        <span><%= currentPage %> of <%= totalPages %> pages</span>
                </div>
            </div>

        </div>

        <div id="addBookPopup" class="add-popup-overlay">
            <div class="add-popup-content">
            <div class="add-popup-header">
                <h2 id="popup-title">Add New Book</h2>
                <button class="add-popup_close" onclick="closeAddBookPopup()">X</button>
            </div>
                <iframe id="popup-frame" class="frame"></iframe>
          </div>
        </div>

        <div id="deleteBookPopup" class="add-popup-overlay">
            <div class="delete-popup-content">
                <p class="confirmation">Delete Confirmation</p>
                <p class="confirm">Are you sure you want to delete this book?</p>
                <form id="deleteForm" method="get" action="BookServlet">
                    <input type="hidden" name="action" value="delete"/>
                    <input type="hidden" name="id" id="deleteBookId"/>
                    <div class="delete-actions">
                        <button type="submit" class="btn-yes">Yes</button>
                        <button type="button" class="btn-no" onclick="closeDeleteBookPopup()">No</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function openAddBookPopup() {
                document.getElementById("popup-title").innerText = "Add New Book";
                document.getElementById("popup-frame").src = "views/popups/addBook.jsp";
                document.getElementById("addBookPopup").style.display = "flex";
            }

            function closeAddBookPopup() {
                document.getElementById("addBookPopup").style.display = "none";
                location.reload();
            }

            function openEditBookPopup(id, title, author, price, categoryName) {
                document.getElementById("popup-title").innerText = "Update Book";

                const params = new URLSearchParams({
                    action: "update",
                    id, title, author, price, categoryName
                });

                document.getElementById("popup-frame").src = "views/popups/addBook.jsp?" + params.toString();
                document.getElementById("addBookPopup").style.display = "flex";
            }

            function openDeleteBookPopup(bookId) {
                document.getElementById("deleteBookPopup").style.display = "flex";
                document.getElementById("deleteBookId").value = bookId;
            }

            function closeDeleteBookPopup() {
                document.getElementById("deleteBookPopup").style.display = "none";
            }

            window.onload = function () {
                const input = document.getElementById("searchInput");
                input.focus();
                const length = input.value.length;
                input.setSelectionRange(length, length);
            };
        </script>



    

        
        
    </body>
    
<!--    <body>
        <div class="heading">
            <h2>Book Management</h2>
            <button class="add-btn" onclick="openAddStockPopup()">+ Add Book</button>
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
                     <td class="actions">
                      <button class="delete" onclick="openDeleteCustomerPopup()">Delete</button>
                    </td>
                </tr>       
            </tbody>
        </table>

        <div id="addBookPopup" class="add-popup-overlay">
            <div class="add-popup-content" style="height: 340px;">
            <div class="add-popup-header">
                <h2>Add New Book</h2>
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
        
    </body>-->
</html>

