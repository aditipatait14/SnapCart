package com.cart.snapcart.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class FactoryProvider {
    private static SessionFactory factory;

    public static SessionFactory getFactory() {
        if (factory == null) {
            try {
                factory = new Configuration().configure().buildSessionFactory();
            } catch (Throwable ex) {
                System.err.println("SessionFactory creation failed: " + ex);
                throw new ExceptionInInitializerError(ex);
            }
        }
        return factory;
    }
}
