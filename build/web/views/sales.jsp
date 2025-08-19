<%-- 
    Document   : sales
    Created on : Jul 20, 2025, 11:03:16 PM
    Author     : kajani.k
--%>
<%@ page import="models.*" %>
<%@ page import="java.util.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/popupStyle.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/salesStyle.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>


    <title>Sales</title>
    <style>
        /* Bill row styling */
        .bill-row {display: flex;justify-content: space-between;align-items: center;padding: 8px 5px;border-bottom: 1px solid #ccc;}
        .bill-name { flex: 2; }
        .qty-controls { flex: 1; display: flex; justify-content: center; align-items: center; gap: 5px; }
        .bill-total { flex: 1; text-align: right; margin-right: 10px;}
        .delete-btn{color:red;background: transparent;border: transparent;}
        .add{background-color: #008080; border: none; height: 30px; width: 40px;
             padding: 5px; color: white; font-size: 16px; border-radius: 5px;}
        .payment{display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;}
    </style>
</head>
<body>
    <div class="container">
        <div class="order-section">
            <input type="text" class="search-bar" id="searchBar" placeholder="Search here.....">

            <div class="category-box">
                <button class="scroll-btn" onclick="scrollLeft()">&lt;</button>

                <div class="scroll-container" id="categoryScroll">
                    <button class="category-item active" onclick="filterStock('all')">All</button>
                    <%
                        CategoryCollection collection = (CategoryCollection) request.getAttribute("categoryCollection");
                        if(collection != null) {
                            CategoryIterator it = collection.iterator();
                            while(it.hasNext()) {
                                CategoryModel cat = it.next();
                    %>
                    <button class="category-item" onclick="filterStock('<%= cat.getId() %>')"><%= cat.getName() %></button>
                    <%      }
                        }
                    %>
                </div>

                <button class="scroll-btn" onclick="scrollRight()">&gt;</button>
            </div>

            <div class="items-grid">
                <% 
                    List<models.StockModel> stockList = (List<models.StockModel>) request.getAttribute("stockList");
                    if (stockList != null && !stockList.isEmpty()) {
                        for (models.StockModel stock : stockList) { 
                %>
                <button class="item-card" onclick="openSelectItemPopup(<%= stock.getId() %>,
                            '<%= stock.getImagePath() %>',
                            '<%= stock.getTitle() %>',
                            '<%= stock.getPrice() %>')">
                    <img src="uploads/<%= stock.getImagePath() %>" alt="<%= stock.getTitle() %>">
                    <div class="item-name"><%= stock.getTitle() %></div>
                    <div class="item-price"><%= stock.getPrice() %></div>
                </button>
                <% 
                        }
                    } else { 
                %>
                <div style="grid-column: 1 / -1; display: flex; justify-content: center; align-items: center; height: 200px; font-size: 26px; font-weight: bold; color: red;">
                    <i class="fas fa-exclamation-triangle" style="margin-right: 10px;"></i>
                    No stock available!
                </div>
                <% } %>
            </div>
        </div>

        <div class="order-view">
            <!-- Bill Items -->
            <div class="bill-row" style="font-weight:bold;border: none;background: transparent;">
                <div class="bill-name">Item</div>
                <div class="qty-controls">Qty</div>
                <div class="bill-total">Price</div>
                <div style="margin-left:35px;"></div> <!-- for delete button column -->
            </div>
            <div class="bill" id="billList"></div>

            <!-- Final total -->
            <div class="fixed-pay">
                <div class="final-total">
                    <h4>Total</h4>
                    <h4 id="grandTotal"> 0.00</h4>
                </div>

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
            <iframe id="popup-frame" class="frame"></iframe>
        </div>
    </div>

    <div id="customerPopup" class="add-popup-overlay" style="display:none; justify-content:center; align-items:center;">
        <div class="add-popup-content" style="width: 450px; height: 400px;">
            <div class="add-popup-header">
                <h2>Select Customer</h2>
                <button class="add-popup_close" onclick="closeCustomerPopup()">X</button>
            </div>        
            <div style="padding: 20px; display: flex; flex-direction: column; gap: 12px;" >
                <label for="customerSelect">Customer:</label>
                <div class="payment">
                    <select style="padding: 8px;border: 1px solid #ccc; border-radius: 6px;font-size: 14px;
                            outline: none;transition: border-color 0.3s ease, box-shadow 0.3s ease;"
                            id="customerSelect" style="width:100%; padding:5px;">
                        <option value="">-- Select Customer --</option>
                    </select>
                     <button class="add" onclick="openAddCustomerPopup()">+</button>
                </div>
                
                <div class="payment">
                    <label>Amount</label>
                    <input type="number" id="totalAmount" style="width: 20%; padding: 5px;" readonly/>
                </div>
                
                <div class="payment">
                    <label>Pay</label>
                    <input type="number" id="payAmount" style="width: 20%; padding: 5px;" oninput="calculateBalance()"/>
                </div>
                <span id="payMessage" style="color: red; font-size: 12px; margin-left: 10px;"></span>
       
                
                 <div class="payment">
                    <label>Balance</label>
                    <input type="number" id="balanceAmount" style="width: 20%; padding: 5px;" readonly/>
                </div>
                
                <button class="add" onclick="confirmPayment()">OK</button>
            </div>
        </div>
    </div>
     

    <div id="addCustomerPopup" class="add-popup-overlay">
        <div class="add-popup-content" >
            <div class="add-popup-header">
                <h2 id="popup-title">Add New Customer</h2>
                <button class="add-popup_close" onclick="closeAddCustomerPopup()">X</button>
            </div>
            <iframe id="contentFrame" style="width:100%; height:400px; border:none;" src="views/popups/addCustomer.jsp"></iframe>
        </div>
    </div>

    <div id="finalBillPopup" class="add-popup-overlay" style="display:none; justify-content:center; align-items:center;">
        <div class="add-popup-content" style="width:500px; max-height: 80%; overflow-y:auto;">
            <div class="add-popup-header">
                <h2>Final Bill</h2>
                <button class="add-popup_close" onclick="closeFinalBillPopup()">X</button>
            </div>
            <div id="finalBillContent" style="padding:10px;"></div>
        </div>
    </div>
            
    <script>
        function scrollLeft() {
            const scrollContainer = document.getElementById("categoryScroll");
            scrollContainer.scrollBy({ left: -130, behavior: "smooth" });
        }
        function scrollRight() {
            const scrollContainer = document.getElementById("categoryScroll");
            scrollContainer.scrollBy({ left: 130, behavior: "smooth" });
        }

        function filterStock(categoryId) {
            document.querySelectorAll('.category-item').forEach(btn => btn.classList.remove('active'));
            if(categoryId === 'all') {
                document.querySelector('.category-item[onclick="filterStock(\'all\')"]').classList.add('active');
            } else event.target.classList.add('active');

            let url = 'SalesServlet';
            if(categoryId !== 'all') url += '?categoryId=' + categoryId;
            window.location.href = url;
        }

        function openSelectItemPopup(id, image, title, price) {
            document.getElementById("addBillPopup").style.display = "flex";
            document.getElementById("popup-frame").src =
                "views/popups/addBill.jsp?id=" + id +
                "&name=" + encodeURIComponent(title) +
                "&price=" + price +
                "&image=" + encodeURIComponent(image);
        }

        function closeSelectItemPopup() {
            document.getElementById("addBillPopup").style.display = "none";
        }

        function openAddCustomerPopup()
        {     
            document.getElementById("popup-title").innerText = "Add New Customer";
            document.getElementById("addCustomerPopup").style.display = "flex";

        }

        function closeAddCustomerPopup() {
            document.getElementById("addCustomerPopup").style.display = "none";
            location.reload();
        }

        function calculateBalance() {
            const total = parseFloat(document.getElementById("totalAmount").value) || 0;
            const pay = parseFloat(document.getElementById("payAmount").value) || 0;
            const balanceInput = document.getElementById("balanceAmount");
            const message = document.getElementById("payMessage");

            if (pay < total) {
               balanceInput.value =0;
                message.textContent = "Pay amount is less than total amount!";
            } else if(pay > total) {
                balanceInput.value = (pay - total).toFixed(2); // extra paid amount
                message.textContent = ""; // clear message if pay is enough
            }
        }
        
        let billItems = [];

        function addToBill(name, price, qty) {
            price = parseFloat(price);
            qty = parseInt(qty) || 1;
            const total = price * qty;

            // Check if item exists → update quantity
            const existing = billItems.find(item => item.name === name);
            if(existing) {
                existing.qty += qty;
                existing.total = existing.qty * existing.price;
            } else {
                billItems.push({ name, qty, price, total });
            }

            renderBill();
        }

        function renderBill() {
            const billList = document.getElementById("billList");
            billList.innerHTML = "";

            let grandTotal = 0;

            billItems.forEach((item, index) => {
                grandTotal += item.total;

                // Create row container
                const row = document.createElement("div");
                row.className = "bill-row";

                // Name div
                const nameDiv = document.createElement("div");
                nameDiv.className = "bill-name";
                nameDiv.textContent = item.name;

                // Quantity controls
                const qtyDiv = document.createElement("div");
                qtyDiv.className = "qty-controls";

                const btnMinus = document.createElement("button");
                btnMinus.textContent = "−";
                btnMinus.addEventListener("click", () => changeQty(index, -1));

                const spanQty = document.createElement("span");
                spanQty.id = `qty-${index}`;
                spanQty.textContent = item.qty;

                const btnPlus = document.createElement("button");
                btnPlus.textContent = "+";
                btnPlus.addEventListener("click", () => changeQty(index, 1));

                qtyDiv.appendChild(btnMinus);
                qtyDiv.appendChild(spanQty);
                qtyDiv.appendChild(btnPlus);

                // Total div
                const totalDiv = document.createElement("div");
                totalDiv.className = "bill-total";
                totalDiv.textContent = item.total.toFixed(2);

                // Delete button
                const deleteBtn = document.createElement("button");
                deleteBtn.className = "delete-btn";
                deleteBtn.textContent = "✖";
                deleteBtn.addEventListener("click", () => deleteItem(index));

                // Append all to row
                row.appendChild(nameDiv);
                row.appendChild(qtyDiv);
                row.appendChild(totalDiv);
                row.appendChild(deleteBtn);

                // Append row to bill
                billList.appendChild(row);
            });

            // Update grand total
            document.getElementById("grandTotal").textContent =  grandTotal.toFixed(2);
        }

        function changeQty(index, delta) {
            billItems[index].qty += delta;
            if(billItems[index].qty < 1) billItems[index].qty = 1;
            billItems[index].total = billItems[index].qty * billItems[index].price;
            renderBill();
        }

        function deleteItem(index) {
            billItems.splice(index, 1);
            renderBill();
        }


        function proceedToPayment() {
             document.getElementById("customerPopup").style.display = "flex";

            const select = document.getElementById("customerSelect");
            select.innerHTML = '<option value="">-- Select Customer --</option>'; // clear previous

            fetch('CustomerServlet?action=getAll')
                .then(res => res.json())
                .then(customers => {
                    console.log("Fetched customers:", customers); // 👈 This will print in browser console

                    customers.forEach(c => {
                        const option = document.createElement("option");
                        option.value = c.id;
                        option.textContent = c.name;
                        select.appendChild(option);
                    });
                })
                .catch(err => console.error("Error fetching customers:", err));
        
            const grandTotal = document.getElementById("grandTotal").textContent.replace("", "").trim();
            document.getElementById("totalAmount").value = grandTotal;
        }

        function closeCustomerPopup() {
            document.getElementById("customerPopup").style.display = "none";
        }

        function confirmPayment() {
            const customerId = document.getElementById("customerSelect").value;
            if (!customerId) {
                alert("Please select a customer!");
                return;
            }

            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();

            let y = 15; // starting Y position
            const pageWidth = doc.internal.pageSize.getWidth();
            const logoUrl = "https://cdn-icons-png.flaticon.com/512/29/29302.png";

            // Add smaller centered logo
            doc.addImage(logoUrl, "PNG", pageWidth / 2 - 10, y, 20, 20);
            y += 30;

            // Bookshop info
            doc.setFontSize(14);
            doc.text("Pahana Edu", pageWidth / 2, y, { align: "center" });
            y += 7;

            // Customer info
            const customerName = document.getElementById("customerSelect").selectedOptions[0].text;
            const phoneNumber = "123-456-7890"; // Replace with dynamic phone if available
            doc.setFontSize(12);
            doc.text("Customer: " + customerName, pageWidth / 2, y, { align: "center" });
            y += 7;
            doc.text("Phone: " + phoneNumber, pageWidth / 2, y, { align: "center" });
            y += 15; // space after header

            // Column titles
            doc.setFontSize(12);
            doc.text("Item", 20, y);
            doc.text("Qty", 90, y);
            doc.text("Price", 130, y, { align: "right" });
            doc.text("Total", 170, y, { align: "right" });
            y += 5;

            // Dotted line under columns
            doc.setLineWidth(0.1);
            doc.setDrawColor(0);
            doc.line(20, y, 190, y);
            y += 5;

            // Bill items
            billItems.forEach(item => {
                doc.text(item.name, 20, y);
                doc.text(item.qty.toString(), 90, y);
                doc.text(item.price.toFixed(2), 130, y, { align: "right" });
                doc.text(item.total.toFixed(2), 170, y, { align: "right" });
                y += 7;

                // dotted line between items
                let dashLength = 2;
                for (let i = 20; i < 190; i += dashLength * 2) {
                    doc.line(i, y, i + dashLength, y);
                }
                y += 5;
            });

            // Grand totals section (labels left, values right)
            const grandTotal = billItems.reduce((sum, item) => sum + item.total, 0);
            const payAmount = parseFloat(document.getElementById("payAmount").value) || 0;
            const balanceAmount = parseFloat(document.getElementById("balanceAmount").value) || 0;

            y += 5;
            const labelsX = 20;
            const valuesX = pageWidth - 20;

            doc.setFontSize(12);
            doc.text("Total", labelsX, y);
            doc.text(grandTotal.toFixed(2), valuesX, y, { align: "right" });
            y += 7;

            doc.text("Payment", labelsX, y);
            doc.text(payAmount.toFixed(2), valuesX, y, { align: "right" });
            y += 7;

            doc.text("Balance", labelsX, y);
            doc.text(balanceAmount.toFixed(2), valuesX, y, { align: "right" });
            y += 10;

            let dashXStart = labelsX;
        let dashXEnd = valuesX;
        let dashY = y + 2; // slightly below the text
        let dashLength = 2;
        for (let i = dashXStart; i < dashXEnd; i += dashLength * 2) {
            doc.line(i, dashY, i + dashLength, dashY);
        }
        y += 15;


            // Footer message centered
            doc.setFontSize(12);
            doc.text("Thank you for choosing us!", pageWidth / 2, y, { align: "center" });

            // Open PDF in new tab
            doc.output("dataurlnewwindow");
        }


    </script>


    <script>
        fetch('CustomerServlet')
            .then(res => res.json()) 
            .then(customers => {
                const datalist = document.getElementById("customerList");
                datalist.innerHTML = ""; 
                customers.forEach(c => {
                    const option = document.createElement("option");
                    option.value = c.name; // display name in dropdown
                    datalist.appendChild(option);
                });
            })
            .catch(err => console.error("Error fetching customers:", err));
    </script>

</body>
</html>
