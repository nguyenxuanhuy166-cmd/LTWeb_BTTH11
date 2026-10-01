package com.bookstore.models;

public class CartItem_24110224 {
    private Book_24110224 book;
    private int quantity;

    public CartItem_24110224() {
    }

    public CartItem_24110224(Book_24110224 book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }

    public Book_24110224 getBook() {
        return book;
    }

    public void setBook(Book_24110224 book) {
        this.book = book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() {
        return this.book.getPrice() * this.quantity;
    }
}
