<%-- 
    Document   : addBill
    Created on : Jul 26, 2025, 10:47:48 AM
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add bill</title>
        <style>
/*            .container{
                display: flex;
            }
            
            .image{
               flex: 1; 
            }
            
            .section{
                flex:1;
            }*/
            

            .popup-image {
              width: 100%;
              height: 180px;
              object-fit: cover;
              border-radius: 8px;
            }

            .popup-details {
                flex: 1;
                display: flex;
                flex-direction: column;
                gap: 10px;
            }

            .popup-name {
                font-size: 18px;
                font-weight: bold;
                text-align: center;
            }

            .popup-price {
                color: #008080;
                font-size: 16px;
            }

            .quantity-controls {
                /*display: flex;*/
                align-items: right;
                gap: 10px;
            }

            .qty-btn {
                /*padding: 6px 10px;*/
                font-size: 18px;
                background-color: #008080;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            #qtyInput {
                width: 40px;
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
                align-self: center;
                width: 100%;
            }

            .add-btn:hover {
                background-color: #006666;
            }
            
            h4{
                margin-top: 10px;
                margin-bottom: 10px;
            }
            
            .button-wrapper {
                text-align: center;
            }
/*             Optional: fade animation 
            @keyframes fadeIn {
                from {opacity: 0; transform: scale(0.9);}
                to {opacity: 1; transform: scale(1);}
            }*/
        </style>
    </head>
    <body>
        
        <div class="container">
            <!--<div class="image">-->
                <img src="${pageContext.request.contextPath}/images/book.jpg" class="popup-image" alt="Book Image" />
            <!--</div>-->
            
            <div class="section">
                <div class="popup-name">Book Name Here</div>
               
                <div style="display: flex;margin-top: 5px;">
                    <div style="flex: 1; text-align: left;" >
                        <h4>Price</h4> 
                        <h4>Quantity</h4>
                        <h4>Total</h4>
                    </div>
                    
                    <div style="flex: 1;text-align: right;">
                        <h4 id="price">500.00</h4>
                        <div class="quantity-controls">
                            <button class="qty-btn" onclick="decreaseQty()">−</button>
                            <input type="text" id="qtyInput" value="1" />
                            <button class="qty-btn" onclick="increaseQty()">+</button>
                        </div>
                        <h4 id="total">500.00</h4>
                    </div>
                </div>
                <div class="button-wrapper">
                    <button class="add-btn">Add to Bill</button>
                </div>
                <!--<button class="add-btn">Add to Bill</button>-->
            </div>
        </div>
            
            
        <script>
            
            function increaseQty()
            {
                const qtyInput = document.getElementById("qtyInput");
                qtyInput.value = parseInt(qtyInput.value)+1;
                findTotal();
            }
            
            function decreaseQty()
            {
                const qtyInput = document.getElementById("qtyInput");
                if((qtyInput.value)>1)
                {
                    qtyInput.value = parseInt(qtyInput.value)-1;
                }
                findTotal();
            }
            
            function findTotal()
            {
                const qty = document.getElementById("qtyInput").value;
                const price = document.getElementById("price").textContent;
                const total = document.getElementById("total");
                
                const finalTotal = qty * price;
                total.textContent = finalTotal.toFixed(2);
            }
            
        </script>
    </body>
</html>
