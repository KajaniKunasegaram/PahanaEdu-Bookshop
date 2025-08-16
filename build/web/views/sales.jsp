<%-- 
    Document   : sales
    Created on : Jul 20, 2025, 11:03:16 PM
    Author     : kajani.k
--%>
<%@page import="models.CategoryModel"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popupStyle.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/salesStyle.css">
        <title>Sales</title>
      
    </head>
    <body>
        <div class="container">
            <div class="order-section">
                <input type="text" class="search-bar" placeholder="Search items here.....">
                            
 <!--<div class="scroll-container" id="categoryScroll">-->
    <c:forEach var="cat" items="${categories}">
        <button type="submit" class="category-item" name="categoryId" value="${cat.id}">
            ${cat.category_name}
        </button>
    </c:forEach>
<!--</div>-->
<!--                <div class="category-box">
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
                </div>-->

                            
                
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
