/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author HP
 */
public class StockModel {
    private int id;
    private String title;
    private String category_name;
    private int quantity;
    private int total_qty;
    private double price;
    private String image_path;


    public int getId()
    {
        return id;
    }
    
    public void setId(int id)
    {
        this.id = id;
    }
    
    public String getTitle() 
    {
        return title;
    }

    public void setTitle(String title) 
    {
        this.title = title;
    }

    public String getCategoryName() 
    {
        return category_name;
    }

    public void setCategoryName(String category_name) 
    {
        this.category_name = category_name;
    }

    public int getQuantity() 
    {
        return quantity;
    }

    public void setQuantity(int quantity) 
    {
        this.quantity = quantity;
    }

    public int getTotalQuantity() 
    {
        return total_qty;
    }

    public void setTotalQuantity(int total_qty) 
    {
        this.total_qty = total_qty;
    }

    public double getPrice() 
    {
        return price;
    }

    public void setPrice(double price) 
    {
        this.price = price;
    }
    
    public String getImagePath()
    {
        return image_path;
    }
    
    public void setImagePath(String image_path)
    {
        this.image_path = image_path;
    }
}
