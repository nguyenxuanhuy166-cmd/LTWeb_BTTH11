package com.bookstore.models;

import java.util.ArrayList;
import java.util.List;

public class Cart_24110224 {
    private List<CartItem_24110224> items;

    public Cart_24110224() {
        items = new ArrayList<>();
    }

    public List<CartItem_24110224> getItems() {
        return items;
    }

    public void addItem(CartItem_24110224 item) {
        for (CartItem_24110224 cartItem : items) {
            if (cartItem.getBook().getBookId() == item.getBook().getBookId()) {
                cartItem.setQuantity(cartItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        items.add(item);
    }

    public void removeItem(int bookId) {
        items.removeIf(item -> item.getBook().getBookId() == bookId);
    }

    public void updateQuantity(int bookId, int quantity) {
        for (CartItem_24110224 item : items) {
            if (item.getBook().getBookId() == bookId) {
                if (quantity <= 0) {
                    items.remove(item);
                } else {
                    item.setQuantity(quantity);
                }
                return;
            }
        }
    }

    public double getTotalMoney() {
        double total = 0;
        for (CartItem_24110224 item : items) {
            total += item.getTotalPrice();
        }
        return total;
    }

    public int getTotalQuantity() {
        int quantity = 0;
        for (CartItem_24110224 item : items) {
            quantity += item.getQuantity();
        }
        return quantity;
    }
    
    public void clear() {
        items.clear();
    }
}
