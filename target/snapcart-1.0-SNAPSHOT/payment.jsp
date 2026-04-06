<%@ page import="com.cart.snapcart.entities.Order" %>
<%@ page import="com.cart.snapcart.entities.User" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
    Order order = (Order) session.getAttribute("currentOrder");
    if (order == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<html>
<head>
    <title>Complete Payment</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
</head>
<body onload="startDummyPayment(<%= order.getOrderId() %>)">

<h2>Redirecting to payment gateway...</h2>

<form id="paymentForm" method="post" action="DummyPaymentServlet">
    <input type="hidden" name="razorpay_payment_id" id="razorpay_payment_id" />
    <input type="hidden" name="orderId" id="order_id_hidden" value="<%= order.getOrderId() %>" />
</form>

<script>
    function startDummyPayment(orderId) {
        const options = {
            "key": "rzp_test_dummyKey",
            "amount": 50000,
            "currency": "INR",
            "name": "SnapCart",
            "description": "Dummy Razorpay Checkout",
            "handler": function (response) {
                document.getElementById("razorpay_payment_id").value = response.razorpay_payment_id;
                document.getElementById("paymentForm").submit();
            }
        };
        const rzp = new Razorpay(options);
        rzp.open();
    }
</script>
</body>
</html>
