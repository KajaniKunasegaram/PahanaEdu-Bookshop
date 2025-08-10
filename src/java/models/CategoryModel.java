/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author HP
 */
public class CategoryModel {
    private int id;
    private String category_name;
    private String description;

    // Empty constructor
    public CategoryModel() {}

    // Getters
    public int getId() { return id; }
    public String getName() { return category_name; }
    public String getDescription() { return description; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setName(String category_name) { this.category_name = category_name; }
    public void setDescription(String description) { this.description = description; }
}
