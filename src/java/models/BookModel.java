/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author HP
 */
public class BookModel {

  private int id;
    private String title;
    private String author;
    private double price;
    private int category_id;
    private String category_name; 
    private String image_path;

    public BookModel() {}

    // Getters
    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getAuthor() { return author; }
    public double getPrice() { return price; }
    public int getCategoryId() { return category_id; }
    public String getCategoryName() { return category_name; }
    public String getImagePath() { return image_path; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setTitle(String title) { this.title = title; }
    public void setAuthor(String author) { this.author = author; }
    public void setPrice(double price) { this.price = price; }
    public void setCategoryId(int category_id) { this.category_id = category_id; }
    public void setCategoryName(String category_name) { this.category_name = category_name; }
    public void setImagePath(String image_path) { this.image_path = image_path; }
}
