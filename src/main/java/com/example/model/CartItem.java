package com.example.model;

import java.math.BigDecimal;

public class CartItem {

    private Course course;
    private int quantity;

    public CartItem(Course course) {
        this.course = course;
        this.quantity = 1;
    }

    public Course getCourse() {
        return course;
    }

    public int getQuantity() {
        return quantity;
    }

    public BigDecimal getTotalPrice() {
        return course.getPrice().multiply(BigDecimal.valueOf(quantity));
    }
}
