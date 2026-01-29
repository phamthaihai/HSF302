package com.example.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class Cart {

    private List<CartItem> items = new ArrayList<>();

    public List<CartItem> getItems() {
        return items;
    }

    public void addCourse(Course course) {

        items.add(new CartItem(course));
    }
    public boolean isEmpty() {
        return items == null || items.isEmpty();
    }
    public BigDecimal getTotalAmount() {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : items) {
            total = total.add(item.getTotalPrice());
        }
        return total;
    }

    public void clear() {
        items.clear();
    }
}
