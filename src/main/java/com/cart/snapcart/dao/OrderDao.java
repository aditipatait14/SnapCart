package com.cart.snapcart.dao;

import com.cart.snapcart.entities.Order;
import com.cart.snapcart.entities.OrderItem;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class OrderDao {

    private SessionFactory factory;

    public OrderDao(SessionFactory factory) {
        this.factory = factory;
    }

    public boolean saveOrder(Order order) {
        Transaction tx = null;
        try (Session session = factory.openSession()) {
            tx = session.beginTransaction();
            session.save(order); // saves order and all associated orderItems
            tx.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace(); 
            if (tx != null) tx.rollback();
            return false;
        }
    }


    public List<Order> getOrdersByUserId(int userId) {
        Session session = factory.openSession();
        List<Order> orders = session.createQuery("FROM Order WHERE user.userId = :uid", Order.class)
                .setParameter("uid", userId)
                .list();
        session.close();
        return orders;
    }

    public List<Order> getAllOrders() {
        Session session = factory.openSession();
        List<Order> list = session.createQuery("FROM Order", Order.class).list();
        session.close();
        return list;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        Session session = factory.openSession();
        Transaction tx = session.beginTransaction();
        try {
            Order order = session.get(Order.class, orderId);
            order.setOrderStatus(status);
            session.update(order);
            tx.commit();
            session.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            session.close();
            return false;
        }
    }
}
