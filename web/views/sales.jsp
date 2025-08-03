<%-- 
    Document   : sales
    Created on : Jul 20, 2025, 11:03:16 PM
    Author     : kajani.k
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popupStyle.css">
        <title>Sales</title>
        <style>
            
            .container{
                display: flex;
                height: 96vh;
                overflow-y: hidden;
            }
            
            .order-section{
                flex: 2;
                /*background-color: #f0f0f0;*/
                padding-right: 10px;
                border-right: 1px solid #ccc;
            }
            
            /*search section*/
            .search-bar {
                width: 100%;
                padding: 10px 10px;
                font-size: 14px;
                box-sizing: border-box;
                border-radius: 10px;
                border: 1px solid #ccc;
                background-color: #fff;
                outline: none;
                transition: all 0.3s ease;
            }

            .search-bar:focus {
                border: 1px solid #008080;
                /*box-shadow: 0 0 8px rgba(0, 123, 255, 0.3);*/
            }
            
            /*categgories style*/
            .category-box {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }

            .scroll-btn {
                background-color: #008080;
                color: white;
                border: none;
                padding: 10px 15px;
                font-size: 18px;
                cursor: pointer;
                border-radius: 5px;
                margin: 0 5px;
            }

            .scroll-container {
                display: flex;
                overflow: hidden;
                width: 700px; /* 5 items × 110px */
            }

            .category-item {
                min-width: 120px;
                margin-right: 10px;
                background-color: #e0e0e0;
                padding: 12px;
                text-align: center;
                border-radius: 8px;
                cursor: pointer;
                transition: background-color 0.3s;
                flex-shrink: 0;
                border: none;
            }

            .category-item:hover {
                background-color: #d0d0d0;
            }

            
            /*item section*/
            .items-grid{
                display: grid;
                grid-template-columns: repeat(5,1fr);
                gap: 20px;
                margin-top: 20px;
            }
            
            .item-card {
                background-color: #fff;
                /*border-radius: 10px;*/
                border: 1px solid #008080;
                /*box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);*/
                padding: 10px;
                text-align: center;
            }

            .item-card img {
                width: 100%;
                max-height: 120px;
                object-fit: cover;
                /*border-radius: 8px;*/
            }

            .item-name {
                font-weight: bold;
                margin-top: 10px;
            }

            .item-price {
                background-color: #008080;
                color: white;
                padding: 5px;
                margin-top: 5px;
                margin-left:  -10px;
                margin-right: -10px;
                margin-bottom: -10px;

            }
            
            
            
            
            
            
            /*bill section*/

            .order-view {
                flex: 1;
                display: flex;
                flex-direction: column;
                height: 96vh;
                border: 1px solid #ccc;
                background: #f9f9f9;
                padding: 10px;
                box-sizing: border-box;
                overflow: hidden;
            }

            .bill {
                flex: 1;
                overflow-y: auto;
                padding-right: 8px;
            }

            .fixed-pay {
                background: #fff;
                border-top: 1px solid #ddd;
                height: 16%;               
            }

            /* Optional scroll bar styling */
            .bill::-webkit-scrollbar {
                width: 6px;
            }
            .bill::-webkit-scrollbar-thumb {
                background-color: rgba(0, 0, 0, 0.2);
                border-radius: 10px;
            }           

            .bill-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: #ffffff;
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-bottom: 5px;
                box-shadow: 0 3px 3px -2px rgba(0, 0, 0, 0.1);

            }

            .bill-name {
                flex: 2;
                /*font-weight: 600;*/
                color: #333;
            }

            .qty-controls {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
                margin-left: 5px;
            }

            .qty-controls button {
                background-color: #008080;
                color: #fff;
                border: none;
                border-radius: 4px;
                padding: 4px 8px;
                font-size: 16px;
                cursor: pointer;
                width: 25px;
                height: 25px;
            }

            .qty-controls span {
                /*font-weight: bold;*/
                min-width: 20px;
                text-align: center;
                display: inline-block;
            }

            .bill-total {
                flex: 1;
                text-align: right;
                /*font-weight: 600;*/
                color: #222;
                margin-left: 5px;
            }

            .delete-btn{
                flex: 0.5;
                color: crimson;
                background: transparent;
                border: transparent;
                text-align: right;
            }

            .final-total {
                font-size: 18px;
                font-weight: bold;
                display: flex;
                justify-content: space-between;
            }

            h4{
                margin: 10px;
            }
            .payment-section {
                text-align: center;
                margin-top: -5px;
            }

            .payment-section button {
                background-color: #008080;
                color: white;
                padding: 10px 24px;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                font-weight: bold;
                /*cursor: pointer;*/
                transition: background-color 0.3s ease;
            }

            .payment-section button:hover {
                background-color: #006666;
            }

            
            
        </style>
    </head>
    <body>
        <div class="container">
            <div class="order-section">
                <input type="text" class="search-bar" placeholder="Search items here.....">
                
                <div class="category-box">
                    <button class="scroll-btn" onclick="scrollLeft()">&lt;</button>

                    <div class="scroll-container" id="categoryScroll">
                      <button class="category-item">Fruits</button>
                      <button class="category-item">Vegetables</button>
                      <button class="category-item">Drinks</button>
                      <button class="category-item">Snacks</button>
                      <button class="category-item">Bakery</button>
                      <button class="category-item">Dairy</button>
                      <button class="category-item">Frozen</button>
                      <button class="category-item">Canned</button>
                      <button class="category-item">Grains</button>
                      <button class="category-item">Condiments</button>
                    </div>

                    <button class="scroll-btn" onclick="scrollRight()">&gt;</button>
                </div>
                
                <div class="items-grid">
                    <button class="item-card" onclick="openSelectItemPopup()">
                        <img  src="${pageContext.request.contextPath}/images/book.jpg" alt="book">
                        <div class="item-name">Book 1</div>
                        <div class="item-price">500.00</div>
                    </button>
                    
                    <button class="item-card" onclick="openSelectItemPopup()">
                        <img  src="${pageContext.request.contextPath}/images/book.jpg" alt="book">
                        <div class="item-name">Book </div>
                        <div class="item-price">500.00</div>
                    </button>
                    
                    <button class="item-card" onclick="openSelectItemPopup()">
                        <img  src="${pageContext.request.contextPath}/images/book.jpg" alt="book">
                        <div class="item-name">Book</div>
                        <div class="item-price">500.00</div>
                    </button>
                        
                    <button class="item-card" onclick="openSelectItemPopup()">
                        <img  src="${pageContext.request.contextPath}/images/book.jpg" alt="book">
                        <div class="item-name">Book </div>
                        <div class="item-price">500.00</div>
                    </button>                       
                    
                </div>
            </div>
            
            <div class="order-view">
                 
                <!-- Bill Items (5 products) -->
                <div class="bill">                   
                
                    <div class="bill-row">
                        <div class="bill-name">Tamil Book</div>
                            <div class="qty-controls">
                                <button onclick="decreaseQty(0)">−</button>
                                <span>1</span>
                                <button onclick="increaseQty(0)">+</button>
                            </div>
                            <div class="bill-total">£ 450.00</div>
                        <button onclick="deleteItem(0)" class="delete-btn">✖</button>

                    </div>

                    <div class="bill-row">
                        <div class="bill-name">English Grammar</div>
                        <div class="qty-controls">
                            <button onclick="decreaseQty(1)">−</button>
                            <span>2</span>
                            <button onclick="increaseQty(1)">+</button>
                        </div>
                        <div class="bill-total">£ 9.00</div>
                        <button onclick="deleteItem(0)" class="delete-btn">✖</button>
                    </div>

                    <div class="bill-row">
                        <div class="bill-name">Science Guide </div>
                        <div class="qty-controls">
                            <button onclick="decreaseQty(2)">−</button>
                            <span>1</span>
                            <button onclick="increaseQty(2)">+</button>
                        </div>
                        <div class="bill-total">£ 520.00</div>
                        <button onclick="deleteItem(0)" class="delete-btn">✖</button>
                    </div>

                    <div class="bill-row">
                        <div class="bill-name">Maths Workbook</div>
                        <div class="qty-controls">
                            <button onclick="decreaseQty(3)">−</button>
                            <span>3</span>
                            <button onclick="increaseQty(3)">+</button>
                        </div>
                        <div class="bill-total">£ 750.00</div>
                        <button onclick="deleteItem(0)" class="delete-btn">✖</button>
                    </div>

                    <div class="bill-row">
                        <div class="bill-name">History Notes</div>
                        <div class="qty-controls">
                            <button onclick="decreaseQty(4)">−</button>
                            <span>1</span>
                            <button onclick="increaseQty(4)">+</button>
                        </div>
                        <div class="bill-total">£ 380.00</div>
                        <button onclick="deleteItem(0)" class="delete-btn">✖</button>
                    </div>
                    
                    <div class="bill-row">
                        <div class="bill-name">History Notes</div>
                        <div class="qty-controls">
                            <button onclick="decreaseQty(4)">−</button>
                            <span>1</span>
                            <button onclick="increaseQty(4)">+</button>
                        </div>
                        <div class="bill-total">£ 380.00</div>
                        <button onclick="deleteItem(0)" class="delete-btn">✖</button>
                    </div>
                    
                    <div class="bill-row">
                        <div class="bill-name">History Notes</div>
                        <div class="qty-controls">
                            <button onclick="decreaseQty(4)">−</button>
                            <span>1</span>
                            <button onclick="increaseQty(4)">+</button>
                        </div>
                        <div class="bill-total">£ 380.00</div>
                        <button onclick="deleteItem(0)" class="delete-btn">✖</button>
                    </div>
                </div>
                <!-- Final total -->
                <div class="fixed-pay">
                    <div class="final-total">
                        <h4>Total</h4>
                        <h4>£ 30000.00</h4>
                    </div>

                    <!-- Payment Button -->
                    <div class="payment-section">
                        <button onclick="proceedToPayment()">Proceed to Payment</button>
                    </div>
                </div>
                
            </div>
                        
        </div>
        
        <div id="addBillPopup" class="add-popup-overlay">
            <div class="add-popup-content" style="width: 300px; height: 430px;">
                <div class="add-popup-header">
                    <h2></h2>
                    <button class="add-popup_close" onclick="closeSelectItemPopup()">X</button>
                </div>
                <iframe src="popups/addBill.jsp" class="frame" ></iframe>
            </div>
        </div>
        
        <script>
            const scrollContainer = document.getElementById("categoryScroll");
            const itemWidth = 130; // item (100px) + margin (10px)
            const visibleCount = 1;

            function scrollLeft() {
              scrollContainer.scrollBy({ left: -itemWidth * visibleCount, behavior: "smooth" });
            }

            function scrollRight() {
              scrollContainer.scrollBy({ left: itemWidth * visibleCount, behavior: "smooth" });
            }
                 
    
    
            function openSelectItemPopup()
            {
                document.getElementById("addBillPopup").style.display="flex";
            }
            function closeSelectItemPopup()
            {
                document.getElementById("addBillPopup").style.display="none";
            }
        </script>
        
        
        <script>
            
            function increaseQty()
            {
                
            }
            
            function decreaseQty()
            {
                
            }
            
        </script>
    </body>
</html>
