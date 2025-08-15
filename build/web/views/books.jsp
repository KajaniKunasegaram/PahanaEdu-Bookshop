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
    <meta charset="UTF-8">
    <title>Book Management</title>
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
    <h2>Book Management</h2>
    <form action="BookServlet" method="get" class="search-form">
        <input type="text" name="search" id="searchInput"
               placeholder="Search books..."
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
                <th>Image</th>
                <th>Title</th>
                <th>Author</th>
                <th>Category</th>
                <th>Price</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
            </thead>
            <tbody id="bookTableBody">
            <%
                List<BookModel> books = (List<BookModel>) request.getAttribute("books");
                if (books != null && !books.isEmpty()) {
                    for (BookModel book : books) {
            %>
            <tr>
                <td>
                    <img src="${pageContext.request.contextPath}/uploads/<%= book.getImagePath() %>" 
                         alt="Book Image" class="book-thumb">
                </td>
                <td><%= book.getTitle() %></td>
                <td><%= book.getAuthor() %></td>
                <td><%= book.getCategoryName() %></td>
                <td>₹<%= book.getPrice() %></td>
                <td class="actions">
                    <button class="edit"
                            onclick="openEditBookPopup(<%= book.getId() %>, 
                                '<%= book.getTitle() %>',
                                '<%= book.getAuthor() %>',    
                                '<%= book.getPrice() %>',
                                '<%= book.getCategoryName() %>',
                                '<%= book.getImagePath() %>')">Edit</button>
                </td>
                <td class="actions">
                    <button class="delete" onclick="openDeleteBookPopup(<%= book.getId() %>)">Delete</button>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7" style="text-align: center; color: crimson; font-size: 20px; font-weight: bold;">
                    No books found.
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <!-- Pagination -->
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
            
</div>

<!-- Add Book Popup -->
<div id="addBookPopup" class="add-popup-overlay">
    <div class="add-popup-content">
        <div class="add-popup-header">
            <h2 id="popup-title">Add New Book</h2>
            <button class="add-popup_close" onclick="closeAddBookPopup()">X</button>
        </div>
        <iframe id="popup-frame" class="frame"></iframe>
    </div>
</div>

<!-- Delete Confirmation -->
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
//        document.getElementById("popup-frame").src = "views/popups/addBook.jsp";
    document.getElementById("popup-frame").src = "BookServlet?action=addForm";

        document.getElementById("addBookPopup").style.display = "flex";
    }

    function closeAddBookPopup() {
        document.getElementById("addBookPopup").style.display = "none";
        location.reload();
    }
    
    function openEditBookPopup(id, title, author, price, category_id, image_path) {
    document.getElementById("popup-title").innerText = "Update Book";
    
    const params = new URLSearchParams({
        action: "updateForm",
        id: id,
        title: title,
        author: author,
        price: price,
        category_id: category_id,
        image_path: image_path
    });
        document.getElementById("popup-frame").src = "BookServlet?action=addForm";


//    document.getElementById("popup-frame").src = "views/popups/addBook.jsp?" + params.toString();
    document.getElementById("addBookPopup").style.display = "flex";
}
//
//    function openEditBookPopup(id, title, author, price, category_id, image_path) {
//        document.getElementById("popup-title").innerText = "Update Book";
//        const params = new URLSearchParams({
//            action: "update",
//            id, title, author, price, category_id, image_path
//        });
////        document.getElementById("popup-frame").src = "views/popups/addBook.jsp?" + params.toString();
//    document.getElementById("popup-frame").src = "BookServlet?action=updateForm";
//
//        document.getElementById("addBookPopup").style.display = "flex";
//    }

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
</html>