
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {

        session.setAttribute("message", "You are not logged in!! Login first to access the checout page");
        response.sendRedirect("login.jsp");
        return;
    }


%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SnapCart - Checkout</title>
        <%@include file="components/common_css_js.jsp" %>
    </head>
    <body>

        <%@include  file="components/navbar.jsp"%>

        <div class="container">

            <div class="row mt-5">

                <div class="col-md-6">
                    <!--card-->
                    <div class="card">
                        <div class="card-body">

                            <h3 class="text-center mb-4">Your selected items</h3>

                            <div class="cart-body">

                            </div>

                        </div>
                    </div>
                </div>


                <!--form details-->
                <div class="col-md-6">

                    <div class="card">
                        <div class="card-body">

                            <h3 class="text-center mb-4">Your details for order</h3>

                            <form id="placeOrderForm" method="post" action="PlaceOrderServlet">
                                <div class="form-group">
                                    <label for="exampleFormControlInput1">Email address</label>
                                    <input value="<%= user.getUserEmail()%>" type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com" required>
                                </div>

                                <div class="form-group">
                                    <label for="name">Your Name:</label>
                                    <input value="<%= user.getUserName()%>" name="name" type="text" class="form-control" id="name" placeholder="Enter your name" required>
                                </div>

                                <div class="form-group">
                                    <label for="name">Contact No:</label>
                                    <input value="<%= user.getUserPhone()%>" name="name" type="text" class="form-control" id="name" placeholder="Enter your contact number" required>
                                </div>

                                <div class="form-group">
                                    <label for="add">Address:</label>
                                    <textarea class="form-control" name="address" id="exampleFormControlTextarea1" placeholder="Enter your address" rows="3" required><%= user.getUserAddress() %></textarea>

                                </div>

                                <div class="container text-center">
                                     <input type="hidden" name="cartJson" id="cartJsonInput">
                                    <button type="submit" class="btn btn-outline-success">Place Order</button>
                                    <a href="index.jsp" class="btn btn-outline-success ml-3">Continue Shopping</a>
                                </div>

                            </form> 

                        </div>

                    </div>

                </div>

            </div>

        </div>

        <%@include file="components/common_modals.jsp"  %> 
        
        <script>
    // Wait until the DOM is ready
    document.addEventListener("DOMContentLoaded", function () {

        // Ensure the cart is updated visually too
        updateCart();

        // Before submitting the form, attach cart data to hidden input
        document.getElementById("placeOrderForm").addEventListener("submit", function (e) {
            const cart = localStorage.getItem("cart");

            if (!cart || JSON.parse(cart).length === 0) {
                e.preventDefault();
                alert("Your cart is empty. Please add items before placing an order.");
                return;
            }

            document.getElementById("cartJsonInput").value = cart;
        });
    });

    // Reuse your updateCart function to render cart on this page too
    function updateCart() {
        let cart = JSON.parse(localStorage.getItem("cart") || "[]");

        if (cart.length === 0) {
            document.querySelector(".cart-body").innerHTML = "<h5>Your cart is empty.</h5>";
            return;
        }

        let html = `<table class="table"><thead><tr>
            <th>Name</th><th>Price</th><th>Qty</th><th>Total</th></tr></thead><tbody>`;

        let total = 0;

        cart.forEach(item => {
            const itemTotal = item.productPrice * item.productQuantity;
            total += itemTotal;

            html += `<tr>
                <td>${item.productName}</td>
                <td>${item.productPrice}</td>
                <td>${item.productQuantity}</td>
                <td>${itemTotal}</td>
            </tr>`;
        });

        html += `<tr><td colspan="3" class="text-right"><strong>Total:</strong></td><td><strong>${total}</strong></td></tr></tbody></table>`;

        document.querySelector(".cart-body").innerHTML = html;
    }
</script>


<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<script>
    function startDummyPayment(orderId) {
        const options = {
            "key": "rzp_test_dummyKey",
            "amount": 50000, // ₹500 in paise
            "currency": "INR",
            "name": "SnapCart",
            "description": "Dummy Payment",
            "handler": function (response) {
                document.getElementById("razorpay_payment_id").value = response.razorpay_payment_id;
                document.getElementById("order_id_hidden").value = orderId;
                document.getElementById("paymentForm").submit();
            },
            "prefill": {
                "name": "<%= user.getUserName() %>",
                "email": "<%= user.getUserEmail() %>",
                "contact": "<%= user.getUserPhone() %>"
            },
            "theme": {
                "color": "#3399cc"
            }
        };
        const rzp = new Razorpay(options);
        rzp.open();
    }
</script>

<form id="paymentForm" method="post" action="DummyPaymentServlet">
    <input type="hidden" name="razorpay_payment_id" id="razorpay_payment_id">
    <input type="hidden" name="orderId" id="order_id_hidden">
</form>

    </body>
</html>
