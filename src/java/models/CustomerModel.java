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

    public CustomerModel() {}

    public int getId(){return id;}
    public String getAccountNo() { return account_no; }
    public String getName() { return name; }
    public String getPhone() { return phone; }
    public String getAddress() { return address; }
    
    // Setters
    public void setId(int id){this.id=id;}
    public void setAccountNo(String account_no) { this.account_no = account_no; }
    public void setName(String name) { this.name = name; }
    public void setPhone(String phone) { this.phone = phone; }
    public void setAddress(String address) { this.address = address; }
    
 
}
