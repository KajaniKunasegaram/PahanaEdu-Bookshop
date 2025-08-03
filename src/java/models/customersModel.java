/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author HP
 */
public class customersModel {
        private String accountNo;
    private String name;
    private String address;
    private String phoneNo;
    private String email;    
    private boolean status;

    public customersModel(String accountNo, String name, String address, String phoneNo, String email, boolean status) {
        this.accountNo = accountNo;
        this.name = name;
        this.address = address;
        this.phoneNo = phoneNo;
        this.email = email;
        this.status = status;
    }

    public String getAccountNo() { return accountNo; }
    public String getName() { return name; }
    public String getAddress() { return address; }
    public String getPhoneNo() { return phoneNo; }
    public String getEMail() { return email; }
    public boolean getStatus() { return status; }
}

    
