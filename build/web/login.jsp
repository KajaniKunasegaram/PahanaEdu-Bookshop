<%-- 
    Document   : index
    Created on : Jul 20, 2025, 6:17:36 PM
    Author     : Kajani.K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String error = (String) request.getAttribute("error"); %>
<% if (error != null) { %>
<script>
    alert("<%= error %>");
</script>
<% } %>
<!DOCTYPE html>
<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(135deg, #fdfcfb, #e2d1c3);
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .login-container {
      background: #fff;
      padding: 40px 30px;
      border-radius: 12px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.1);
      width: 360px;
      text-align: center;
    }

    .login-container h1 {
      font-size: 28px;
      color: #4b2e2e;
      margin-bottom: 10px;
    }

    .login-container p {
      font-size: 14px;
      color: #7a6e66;
      margin-bottom: 25px;
    }

    .input-field {
      margin-bottom: 20px;
      text-align: left;
    }

    .input-field label {
      display: block;
      font-size: 14px;
      margin-bottom: 6px;
      color: #5e4b45;
    }

    .input-field input {
      width: 100%;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 14px;
      transition: 0.3s;
    }

    .input-field input:focus {
      border-color: #c59d5f;
      outline: none;
    }

    button {
      background-color: #008080;
      color: #fff;
      border: none;
      padding: 12px 0;
      border-radius: 8px;
      width: 100%;
      font-size: 16px;
      cursor: pointer;
      transition: background 0.3s;
    }

    button:hover {
      background-color: #005f5f;
    }

    .extra-links {
      margin-top: 15px;
      font-size: 13px;
      color: #6e5b52;
    }

    .extra-links a {
      color: #8b5e3c;
      text-decoration: none;
      margin: 0 5px;
    }

    .extra-links a:hover {
      text-decoration: underline;
    }

    .logo {
      margin-bottom: 20px;
    }

    .logo img {
      width: 60px;
    }
  </style>
</head>
<body>

  <div class="login-container">
    <div class="logo">
      <img src="https://cdn-icons-png.flaticon.com/512/29/29302.png" alt="Book Shop Logo">
    </div>
    <h1>Pahana Edu Login</h1>
    <p>Welcome back! Please log in to continue exploring your favorite reads.</p>
    
    <form action="LoginServlet" method="POST">
      <div class="input-field">
        <label for="username">Email or Username</label>
        <input type="text" id="username" name="username" required
       value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>">
      </div>
      
      <div class="input-field">
        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>
      </div>

      <button type="submit">Login</button>
    </form>

<!--    <div class="extra-links">
      <a href="#">Forgot Password?</a> |
      <a href="#">Create Account</a>
    </div>-->
  </div>

</body>
</html>

