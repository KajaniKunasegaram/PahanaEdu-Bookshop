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

    
    private StockModel(Builder builder) {
        this.id = builder.id;
        this.title = builder.title;
        this.category_name = builder.category_name;
        this.quantity = builder.quantity;
        this.total_qty = builder.total_qty;
        this.price = builder.price;
        this.image_path = builder.image_path;
    }

    public static class Builder {
        private int id;
        private String title;
        private String category_name;
        private int quantity;
        private int total_qty;
        private double price;
        private String image_path;

        public Builder setId(int id) {
            this.id = id;
            return this;
        }
        public Builder setTitle(String title) {
            this.title = title;
            return this;
        }
        public Builder setCategoryName(String category_name) {
            this.category_name = category_name;
            return this;
        }
        public Builder setQuantity(int quantity) {
            this.quantity = quantity;
            return this;
        }
        public Builder setTotalQty(int total_qty) {
            this.total_qty = total_qty;
            return this;
        }
        public Builder setPrice(double price) {
            this.price = price;
            return this;
        }
        public Builder setImagePath(String image_path) {
            this.image_path = image_path;
            return this;
        }

        public StockModel build() {
            return new StockModel(this);
        }
    }

    public int getId() { return id; }
    public String getTitle() { return title; }
    public String getCategoryName() { return category_name; }
    public int getQuantity() { return quantity; }
    public int getTotalQuantity() { return total_qty; }
    public double getPrice() { return price; }
    public String getImagePath() { return image_path; }
    
//
//    public int getId()
//    {
//        return id;
//    }
//    
//    public void setId(int id)
//    {
//        this.id = id;
//    }
//    
//    public String getTitle() 
//    {
//        return title;
//    }
//
//    public void setTitle(String title) 
//    {
//        this.title = title;
//    }
//
//    public String getCategoryName() 
//    {
//        return category_name;
//    }
//
//    public void setCategoryName(String category_name) 
//    {
//        this.category_name = category_name;
//    }
//
//    public int getQuantity() 
//    {
//        return quantity;
//    }
//
//    public void setQuantity(int quantity) 
//    {
//        this.quantity = quantity;
//    }
//
//    public int getTotalQuantity() 
//    {
//        return total_qty;
//    }
//
//    public void setTotalQuantity(int total_qty) 
//    {
//        this.total_qty = total_qty;
//    }
//
//    public double getPrice() 
//    {
//        return price;
//    }
//
//    public void setPrice(double price) 
//    {
//        this.price = price;
//    }
//    
//    public String getImagePath()
//    {
//        return image_path;
//    }
//    
//    public void setImagePath(String image_path)
//    {
//        this.image_path = image_path;
//    }
}
