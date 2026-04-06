<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.cart.snapcart.entities.Order" %>
<%@ page import="com.cart.snapcart.entities.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ include file="components/common_css_js.jsp" %>

<%
    Order order = (Order) request.getAttribute("order");
    if (order == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<OrderItem> items = order.getOrderItems();
    int total = 0;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Confirmation</title>
    <style>
        .card {
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-radius: 10px;
        }
        .card-body {
            padding: 20px;
        }
        .table td, .table th {
            vertical-align: middle;
        }
    </style>
</head>
<body>

<%@ include file="components/navbar.jsp" %>

<div class="container mt-5">
    <div class="card">
        <div class="card-body">

            <h3 class="text-center text-success mb-4">Thank you for your order!</h3>
            <p class="text-center text-muted">Your order has been placed successfully. Below are your order details.</p>

            <hr/>

            <h5>Order Summary (Order ID: <%= order.getOrderId() %>)</h5>

            <table class="table mt-3">
                <thead class="thead-light">
                    <tr>
                        <th>Product</th>
                        <th>Price per Unit</th>
                        <th>Quantity</th>
                        <th>Total Price</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    for (OrderItem item : items) {
                        total += item.getTotalPrice();
                %>
                    <tr>
                        <td><%= item.getProduct().getpName() %></td>
                        <td>₹ <%= item.getPricePerUnit() %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>₹ <%= item.getTotalPrice() %></td>
                    </tr>
                <%
                    }
                %>
                <tr class="font-weight-bold">
                    <td colspan="3" class="text-right">Total Amount:</td>
                    <td>₹ <%= total %></td>
                </tr>
                </tbody>
            </table>

            <div class="text-center mt-4">
                <a href="index.jsp" class="btn btn-outline-success">Continue Shopping</a>
            </div>

        </div>
    </div>
</div>

<%@ include file="components/common_modals.jsp" %>

</body>
</html>
