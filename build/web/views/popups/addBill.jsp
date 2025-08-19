<%-- 
    Document   : addBill
    Created on : Jul 26, 2025, 10:47:48 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String price = request.getParameter("price");
    String image = request.getParameter("image");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add Bill</title>
    <style>
        .popup-image {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 8px;
        }

        .popup-name {
            font-size: 18px;
            font-weight: bold;
            text-align: center;
            margin: 10px 0;
        }

        .quantity-controls {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 5px;
            margin: 5px 0;
        }

        .qty-btn {
            font-size: 18px;
            background-color: #008080;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            padding: 5px 10px;
        }

        #qtyInput {
            width: 50px;
            text-align: center;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .add-btn {
            margin-top: 10px;
            background-color: #008080;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s;
            text-align: center;
            width: 100%;
        }

        .add-btn:hover {
            background-color: #006666;
        }

        h4 {
            margin: 8px 0;
        }

        .button-wrapper {
            text-align: center;
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Product Image -->
        <img src="<%= request.getContextPath() %>/uploads/<%= image %>" alt="<%= name %>" class="popup-image"/>

        <!-- Product Details -->
        <div class="section">
            <div class="popup-name"><%= name %></div>

            <div style="display: flex; margin-top: 5px;">
                <div style="flex: 1; text-align: left;">
                    <h4>Price</h4>
                    <h4>Quantity</h4>
                    <h4>Total</h4>
                </div>

                <div style="flex: 1; text-align: right;">
                    <h4 id="price"><%= price %></h4>
                    <div class="quantity-controls">
                        <button class="qty-btn" onclick="decreaseQty()">−</button>
                        <input type="number" id="qtyInput" value="1" min="1" oninput="findTotal()" />
                        <button class="qty-btn" onclick="increaseQty()">+</button>
                    </div>
                    <h4 id="total"><%= price %></h4>
                </div>
            </div>

            <!-- Add to Bill Button -->
           <div class="button-wrapper">
    <button class="add-btn" onclick="addItemToBill('<%= name.replace("'", "\\'") %>', <%= price %>)">
        Add to Bill
    </button>
</div>

        </div>
    </div>

    <script>
        function increaseQty() {
            const qtyInput = document.getElementById("qtyInput");
            qtyInput.value = parseInt(qtyInput.value) + 1;
            findTotal();
        }

        function decreaseQty() {
            const qtyInput = document.getElementById("qtyInput");
            if (qtyInput.value > 1) {
                qtyInput.value = parseInt(qtyInput.value) - 1;
            }
            findTotal();
        }

        function findTotal() {
            const qty = parseInt(document.getElementById("qtyInput").value) || 1;
            const price = parseFloat(document.getElementById("price").textContent);
            const total = document.getElementById("total");
            const finalTotal = qty * price;
            total.textContent = finalTotal.toFixed(2);
        }
        
        
//        function addItemToBill(name, price) {
//            const qty = parseInt(document.getElementById("qtyInput").value) || 1;
//
//            if (parent && parent.addToBill) {
//                parent.addToBill(name, price, qty);
//            }
//            if (parent && parent.closeSelectItemPopup) {
//                parent.closeSelectItemPopup();
//            }
//        }
    </script>
    
    <script>
    function addItemToBill(name, price) {
        const qty = parseInt(document.getElementById("qtyInput").value) || 1;

        // Call parent (sales.jsp) function
        if (parent && parent.addToBill) {
            parent.addToBill(name, price, qty);
        }

        // Close popup
        if (parent && parent.closeSelectItemPopup) {
            parent.closeSelectItemPopup();
        }
    }
</script>
</body>
</html>