<%-- 
    Document   : addCustomer.jsp
    Created on : Jul 21, 2025, 5:03:27 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
  <meta charset="UTF-8">
  <title>Add Customer</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/addPopupStyle.css">
</head>
<body>

<div class="container">
  <!--<h2>Add New Customer</h2>-->
    <form action="SaveCustomerServlet" method="post">
        <div class="add-container">

            <div class="add-left">

                <div class="add-group">
                    <label for="accountNo">Account No</label>
                    <input type="text" id="accountNo" name="accountNo" required>
                </div>

                <div class="add-group">
                    <label for="phone">Phone</label>
                    <input type="tel" id="phone" name="phone" pattern="[0-9]{10}" required>
                </div>

                <div class="add-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email">
                </div>

            </div>

            <div class="add-right">

                <div class="add-group">
                    <label for="name">Customer Name</label>
                    <input type="text" id="name" name="name" required>
                </div>

    <!--        <div class="add-group">
              <label for="units">Unit Consumed</label>
              <input type="number" id="units" name="units" min="0" required>
            </div>-->

                <div class="add-group">
                    <label for="status">Status</label>
                    <select id="status" name="status" required>
                      <option value="">-- Select --</option>
                      <option value="Active">Active</option>
                      <option value="Inactive">Inactive</option>
                    </select>
                </div>

                <div class="add-group">
                    <label for="address">Address</label>
                    <textarea id="address" name="address" rows="3" required></textarea>
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
