/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author HP
 */
public class CustomerModel {
    private int id;
    private String account_no;
    private String name;
    private String phone;
    private String address;
    private int units_consumed;

    public CustomerModel() {}

    public int getId(){return id;}
    public String getAccountNo() { return account_no; }
    public String getName() { return name; }
    public String getPhone() { return phone; }
    public String getAddress() { return address; }
    public int getUnits(){return units_consumed;}
    
    // Setters
    public void setId(int id){this.id=id;}
    public void setAccountNo(String account_no) { this.account_no = account_no; }
    public void setName(String name) { this.name = name; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setAddress(String address) { this.address = address; }
    public void setUnits(int units_consumed){this.units_consumed = units_consumed;}
 
}
