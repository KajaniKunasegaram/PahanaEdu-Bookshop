
<%-- 
    Document   : home
    Created on : Jul 20, 2025, 8:58:12 PM
    Author     : Kajani.K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    models.UserModel user = (models.UserModel) session.getAttribute("loggedUser");
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Dashboard - Pahana Edu</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homeStyle.css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    
  </style>
</head>
<body>

  <!-- Top Navbar -->
  <div class="navbar">
    <div class="nav-links">
<!--     <button class="nav-btn " onclick="loadPage(this, 'dashboard.jsp')">
       <i class="fas fa-tachometer-alt"></i> Dashboard
     </button>-->

     <% if("Admin".equalsIgnoreCase(user.getRole())) { %>
     
        <button class="nav-btn active" onclick="loadPage(this, '${pageContext.request.contextPath}/SalesServlet')">
           <i class="fas fa-shopping-cart"></i> Sales
         </button>
           
        
         <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/CategoryServlet')">
           <i class="fas fa-list-alt"></i> Category
         </button>
           
         <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/BookServlet')">
           <i class="fas fa-book"></i> Books
         </button> 
           
         <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/StockServlet')">
           <i class="fas fa-warehouse"></i> Stocks
         </button> 
           
            <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/CustomerServlet')">
           <i class="fas fa-user"></i> Customers
         </button>
         
         <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/UserServlet')">
           <i class="fas fa-users-cog"></i> Users
         </button>
           
         <button class="nav-btn" onclick="loadPage(this, 'reports.jsp')">
           <i class="fas fa-chart-line"></i> Reports
         </button>
           
         <button class="nav-btn" onclick="loadPage(this, 'help.jsp')">
           <i class="fas fa-question-circle"></i> Help
         </button>
     <% } 
        else if("Staff".equalsIgnoreCase(user.getRole())) { %>
            <button class="nav-btn active" onclick="loadPage(this, '${pageContext.request.contextPath}/SalesServlet')">
               <i class="fas fa-shopping-cart"></i> Sales
             </button>
               
              <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/CategoryServlet')">
               <i class="fas fa-list-alt"></i> Category
             </button> 
               
             <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/BookServlet')">
               <i class="fas fa-book"></i> Books
             </button> 
               
             <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/StockServlet')">
               <i class="fas fa-warehouse"></i> Stocks
             </button> 

             <button class="nav-btn" onclick="loadPage(this, '${pageContext.request.contextPath}/CustomerServlet')">
               <i class="fas fa-user"></i> Customers
             </button>

             <button class="nav-btn" onclick="loadPage(this, 'help.jsp')">
               <i class="fas fa-question-circle"></i> Help
             </button>
     <% } %>

     <!-- Profile section always visible -->
     <div class="profile-section" onclick="toggleDropdown()">
         <div class="profile-circle"><%= user.getUsername().substring(0,1).toUpperCase() %></div>
         <div class="dropdown-icon">&#9660;</div>
         <div class="profile-dropdown" id="profileDropdown">
             <p><%= user.getRole() %></p>
             <p><%= user.getUsername() %></p>
             <a href="${pageContext.request.contextPath}/LogoutServlet" class="logout">Logout</a>                
         </div>
     </div>
 </div>
  </div>

  <!-- Main Content -->
    <iframe id="contentFrame" src="${pageContext.request.contextPath}/SalesServlet"></iframe>

  <!--<iframe id="contentFrame" src="sales.jsp"></iframe>-->

  <script>
    function loadPage(button, page) {
        // Remove active class from all buttons
        document.querySelectorAll('.nav-btn').forEach(btn => btn.classList.remove('active'));
        // Add to clicked
        button.classList.add('active');
        // Load into iframe
        document.getElementById('contentFrame').src = page;
    }
    
    function toggleDropdown() 
        { const dropdown = document.getElementById("profileDropdown"); 
            dropdown.style.display = dropdown.style.display === "block" ? "none" : "block"; 
        }
    // Close dropdown if clicked outside
    document.addEventListener("click", function(event) {
        const profileSection = document.querySelector(".profile-section");
        const dropdown = document.getElementById("profileDropdown");
        if (!profileSection.contains(event.target)) {
            dropdown.classList.remove("show");
        }
    });
    
  </script>

</body>
</html>