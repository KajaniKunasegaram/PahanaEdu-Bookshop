/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author HP
 */
public class UserModel {
    
    private int id;
    private String username;
    private String password;
    private String address;
    private String phone;
    private String email;
    private String role;
    private String status;
    
    public int getId(){return id;}
    public String getUsername(){return username;}
    public String getPassword(){return password;}
    public String getAddress(){return address;}
    public String getPhone(){return phone;}
    public String getMail(){return email;}
    public String getRole(){return role;}
    public String getStatus(){return status;}
    
    public void setId(int id){this.id=id;}
    public void setUsername(String username){this.username=username;}
    public void setPassword(String password){this.password=password;}
    public void setAddress(String address){this.address=address;}
    public void setPhone(String phone){this.phone=phone;}
    public void setMail(String email){this.email=email;}
    public void setRole(String role){this.role=role;}
    public void setStatus(String status){this.status=status;}

    
    
}
