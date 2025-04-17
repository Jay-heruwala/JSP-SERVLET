/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author jayhe
 */
public class Book {
    
      
    private int bookID;
    private String title;
    private String author;
    private double price;
    private int qty;
    private String ISBN;
    private String publisher;
    private String editionYear;
    private String cataLogID;
    
    public Book(int bookID, String title, String author, double price, int qty, String ISBN, String publisher, String editionYear, String cataLogID) {
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.price = price;
        this.qty = qty;
        this.ISBN = ISBN;
        this.publisher = publisher;
        this.editionYear = editionYear;
        this.cataLogID = cataLogID;
    }

    public Book(String title, String author, double price, int qty, String ISBN, String publisher, String editionYear, String cataLogID) {
        this.title = title;
        this.author = author;
        this.price = price;
        this.qty = qty;
        this.ISBN = ISBN;
        this.publisher = publisher;
        this.editionYear = editionYear;
        this.cataLogID = cataLogID;
    }
    
    public Book(){}

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public String getPublisher() {
        return publisher;
    }

    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }

    public String getEditionYear() {
        return editionYear;
    }

    public void setEditionYear(String editionYear) {
        this.editionYear = editionYear;
    }

    public String getCataLogID() {
        return cataLogID;
    }

    public void setCataLogID(String cataLogID) {
        this.cataLogID = cataLogID;
    }
  
    
}
