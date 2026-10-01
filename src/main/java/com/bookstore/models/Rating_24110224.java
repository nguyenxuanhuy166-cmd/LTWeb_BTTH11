package com.bookstore.models;

public class Rating_24110224 {
    private int userId;
    private int bookId;
    private int rating;
    private String reviewText;
    
    private String userFullname; // For display

    public Rating_24110224() {}

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }

    public String getUserFullname() { return userFullname; }
    public void setUserFullname(String userFullname) { this.userFullname = userFullname; }
}


