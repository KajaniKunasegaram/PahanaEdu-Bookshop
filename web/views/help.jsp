<%-- 
    Document   : help
    Created on : Jul 21, 2025, 11:30:31 PM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Help</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                line-height: 1.6;
                background-color: #f9f9f9;
            }
            h1 {
                color: #2c3e50;
                text-align: center;
                margin-bottom: 20px;
            }
            h2 {
                color: #34495e;
                margin-top: 20px;
            }
            ul {
                margin-left: 30px;
            }
            .section {
                background: #ffffff;
                border: 1px solid #ddd;
                border-radius: 8px;
                padding: 15px;
                margin-bottom: 15px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            }
        </style>
    </head>
    <body>
        <h1>📘 Help Section</h1>
        <h2 style="text-align:center;">System Usage Guidelines for New Users</h2>
        
        <div class="section">
            <h2>1. Login to the System</h2>
            <ul>
                <li>Open the application through the given URL.</li>
                <li>Enter your <b>Username</b> and <b>Password</b>.</li>
                <li>If you are a first-time user, request login credentials from the <b>Administrator</b>.</li>
                <li>Only Admin can add a new user.</li>

            </ul>
        </div>
        
        <div class="section">
            <h2>2. Navigation</h2>
            <p>The main menu bar contains options such as:</p>
            <ul>
                <li>Sales</li>
                <li>Customers</li>
                <li>Categories</li>
                <li>Books</li>
                <li>Stock</li>
                <li>Users</li>
            </ul>
            <p>    The menu bar items visible to a user depend on their login role:<br><br></p>
        </div>
        
        <div class="section">
            <h2>3. Adding Records</h2>
            <ul>
                <li>Go to the respective module (e.g., Manage Books).</li>
                <li>Click <b>Add New</b>.</li>
                <li>Fill in all required fields (marked with *).</li>
                <li>Press <b>Save</b> to store the details.</li>
            </ul>
        </div>
        
        <div class="section">
            <h2>4. Updating Records</h2>
            <ul>
                <li>Search for the required record using the <b>Search Box</b>.</li>
                <li>Select the record and click <b>Edit</b>.</li>
                <li>Update the fields and press <b>Update</b>.</li>
            </ul>
        </div>
        
        <div class="section">
            <h2>5. Deleting Records</h2>
            <ul>
                <li>Locate the record from the list.</li>
                <li>Click the <b>Delete</b> button.</li>
                <li>Confirm deletion when prompted.</li>
            </ul>
        </div>
        
        <div class="section">
            <h2>6. Managing Users (Admin Only)</h2>
            <ul>
                <li>Admins can create, update, or remove staff accounts.</li>
                <li>Go to <b>Users</b> section to perform these operations.</li>
            </ul>
        </div>
        
        <div class="section">
            <h2>7. Help & Support</h2>
            <ul>
                <li>For password reset, contact the <b>system administrator</b>.</li>
                <li>For technical issues, refer to the <b>troubleshooting guide</b> in the documentation or reach out to the IT support team.</li>
            </ul>
        </div>
    </body>
</html>
