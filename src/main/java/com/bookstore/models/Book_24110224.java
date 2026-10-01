package com.bookstore.models;

import java.sql.Date;
import java.util.List;

public class Book_24110224 {
    private int bookId;
    private int isbn;
    private String title;
    private String publisher;
    private double price;
    private String description;
    private Date publishDate;
    private String coverImage;
    private int quantity;
    
    // For display
    private List<Author_24110224> authors;
    private int reviewCount;

    // Constructors, Getters, Setters
    public Book_24110224() {}

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public int getIsbn() { return isbn; }
    public void setIsbn(int isbn) { this.isbn = isbn; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Date getPublishDate() { return publishDate; }
    public void setPublishDate(Date publishDate) { this.publishDate = publishDate; }

    public String getCoverImage() { return coverImage; }
    public void setCoverImage(String coverImage) { this.coverImage = coverImage; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public List<Author_24110224> getAuthors() { return authors; }
    public void setAuthors(List<Author_24110224> authors) { this.authors = authors; }

    public int getReviewCount() { return reviewCount; }
    public void setReviewCount(int reviewCount) { this.reviewCount = reviewCount; }
    
    public String getAuthorNames() {
        if (authors == null || authors.isEmpty()) return "";
        StringBuilder names = new StringBuilder();
        for (int i = 0; i < authors.size(); i++) {
            names.append(authors.get(i).getAuthorName());
            if (i < authors.size() - 1) names.append(", ");
        }
        return names.toString();
    }
}


