package com.cart.snapcart.entities;

public class CartItem {
    private int productId;
    private String productName;
    private int productQuantity;
    private int productPrice;

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductQuantity() {
        return productQuantity;
    }

    public void setProductQuantity(int productQuantity) {
        this.productQuantity = productQuantity;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    // These are optional; used if your servlet expects these methods
    public int getQuantity() {
        return productQuantity;
    }

    public Product getProduct() {
        return null; // Only if needed elsewhere. Otherwise, remove this method.
    }
}
