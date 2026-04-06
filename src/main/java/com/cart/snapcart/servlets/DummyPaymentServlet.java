package com.cart.snapcart.servlets;

import com.cart.snapcart.entities.Order;
import com.cart.snapcart.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/DummyPaymentServlet")
public class DummyPaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String razorpayPaymentId = request.getParameter("razorpay_payment_id");

        Session session = FactoryProvider.getFactory().openSession();
        Transaction tx = session.beginTransaction();

        try {
            Order order = session.get(Order.class, orderId);

            if (order != null) {
                // Update payment and order status
                order.setPaymentStatus("Paid");
                order.setOrderStatus("Confirmed");
                order.setPaymentId(razorpayPaymentId); 
                //store razorpay_payment_id in DB
              

                session.update(order);
                tx.commit();

                // Remove from session and forward to confirmation
                request.getSession().removeAttribute("currentOrder");
                request.setAttribute("order", order);
                request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
            } else {
                response.getWriter().println("Invalid order.");
            }

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            response.getWriter().println("Payment failed. Try again.");
        } finally {
            session.close();
        }
    }
}
