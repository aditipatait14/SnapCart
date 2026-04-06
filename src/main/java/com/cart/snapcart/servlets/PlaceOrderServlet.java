package com.cart.snapcart.servlets;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.lang.reflect.Type;
import com.cart.snapcart.entities.CartItem;
import com.cart.snapcart.entities.Order;
import com.cart.snapcart.entities.OrderItem;
import com.cart.snapcart.entities.Product;
import com.cart.snapcart.entities.User;
import com.cart.snapcart.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession httpSession = request.getSession();
        User user = (User) httpSession.getAttribute("current-user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String cartJson = request.getParameter("cartJson");

        if (cartJson == null || cartJson.isEmpty()) {
            response.getWriter().println("Cart data is missing.");
            return;
        }

        // Convert JSON cart to List<CartItem>
        Gson gson = new Gson();
        Type cartType = new TypeToken<List<CartItem>>() {}.getType();
        List<CartItem> cart = gson.fromJson(cartJson, cartType);

        if (cart == null || cart.isEmpty()) {
            response.getWriter().println("Cart is empty.");
            return;
        }

        // Prepare order
        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(new Date());
        order.setOrderStatus("Pending");
        order.setPaymentStatus("Unpaid");

        List<OrderItem> orderItems = new ArrayList<>();
        int totalOrderPrice = 0;

        SessionFactory factory = FactoryProvider.getFactory();
        Session session = factory.openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();

            for (CartItem cartItem : cart) {
                Product product = session.get(Product.class, cartItem.getProductId());

                if (product == null) {
                    response.getWriter().println("Product not found with ID: " + cartItem.getProductId());
                    return;
                }

                OrderItem orderItem = new OrderItem();
                orderItem.setOrder(order);
                orderItem.setProduct(product);
                orderItem.setQuantity(cartItem.getProductQuantity());
                orderItem.setPricePerUnit(cartItem.getProductPrice());
                orderItem.setTotalPrice(cartItem.getProductQuantity() * cartItem.getProductPrice());

                totalOrderPrice += orderItem.getTotalPrice();
                orderItems.add(orderItem);
            }

            order.setOrderItems(orderItems);
            order.setTotalAmount(totalOrderPrice); // ✅ Set total

            // Save the order (and cascade save order items)
            session.save(order);
            tx.commit();
            
            request.setAttribute("order", order);
            request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            response.getWriter().println("Order could not be placed. Please try again.");
        } finally {
            session.close();
        }
    }
}
