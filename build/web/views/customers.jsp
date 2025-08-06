<%-- 
    Document   : customers
    Created on : Jul 20, 2025, 11:02:43 PM
    Author     : Kajani.K
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Customer Management</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popupStyle.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/viewStyle.css">
</head>
<body>

  <div class="heading">
    <h2>Customer Management</h2>
    <button class="add-btn" onclick="openAddCustomerPopup()">+ Add Customer</button>
  </div>

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
    <tbody>
      <tr>
        <td>ACC001</td>
        <td>Sanjeewa</td>
        <td>Colombo 07</td>
        <td>0771234567</td>
        <td class="actions">
          <button class="edit" onclick="openAddCustomerPopup()">Edit</button>
        </td>
         <td class="actions">
          <button class="delete" onclick="openDeleteCustomerPopup()">Delete</button>
        </td>
      </tr>
      
    </tbody>
  </table>

    
    <div id="addCustomerPopup" class="add-popup-overlay">
        <div class="add-popup-content" style="width: 30%; height: 480px;">
        <div class="add-popup-header">
            <h2>Add New Customer</h2>
            <button class="add-popup_close" onclick="closeAddCustomerPopup()">X</button>
        </div>
            <iframe src="popups/addCustomer.jsp" class="frame" ></iframe>
      </div>
    </div>
    
    <div id="deleteCustomerPopup" class="add-popup-overlay">
        <div class="delete-popup-content"> 
            <P class="confirmation">Delete Confirmation</h3>
            <p class="confirm">Are you sure you want to delete this customer?</p>
            <div class="delete-actions">
                <button type="submit" class="btn-yes" onclick="DeleteConfirmCustomerPopup()">Yes</button>
                <button type="button" class="btn-no" onclick="closeDeleteCustomerPopup()">No</button>
            </div>
        </div>
    </div>
    
    
    <script>
        function openAddCustomerPopup()
        {
            document.getElementById("addCustomerPopup").style.display="flex";
        }
        function closeAddCustomerPopup()
        {
            document.getElementById("addCustomerPopup").style.display="none";
        }
        
        function openDeleteCustomerPopup()
        {
            document.getElementById("deleteCustomerPopup").style.display = "flex";
        }
        
        function closeDeleteCustomerPopup()
        {
            document.getElementById("deleteCustomerPopup").style.display = "none";
        }
        
        function DeleteConfirmCustomerPopup()
        {
            closeDeleteCustomerPopup();
        }
    </script>
</body>
</html>
