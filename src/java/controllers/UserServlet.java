/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import DBAccess.DBConnection;
import java.sql.*;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import models.UserModel;

/**
 *
 * @author HP
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
  
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if("add".equals(action))
        {
            addUser(request,response);
        }
        else if("update".equals(action))
        {
            updateUser(request,response);
        }
        
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String action = request.getParameter("action");
        if("delete".equals(action))
        {
            deleteUser(request,response);
        }
        else
        {
            List<UserModel> userList= getAllUsers();
            request.setAttribute("users", userList);
            request.getRequestDispatcher("/views/users.jsp").forward(request, response);
        }
    }
    
    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        try
        {
            Connection connection = DBConnection.getConnection();
            System.out.println("✅ Connection successful");
            String query = "insert into tbluser(username,password,phone,email,status,role,address)values(?,?,?,?,?,?,?)";
            PreparedStatement pst = connection.prepareStatement(query);
            
            pst.setString(1, request.getParameter("username"));
            pst.setString(2, request.getParameter("password"));
            pst.setString(3, request.getParameter("phone"));
            pst.setString(4, request.getParameter("email"));
            pst.setString(5, request.getParameter("status"));
            pst.setString(6, request.getParameter("role"));
            pst.setString(7, request.getParameter("address"));
            
            int rowInserted = pst.executeUpdate();
            
//            System.out.println("rowInserted = " + rowInserted);

            if (rowInserted > 0) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("window.parent.location.reload();");
                out.println("alert('✅ User added successfully!');");

                out.println("window.parent.closeAddUserPopup();");
                out.println("window.parent.document.getElementById('contentFrame').src = window.parent.document.getElementById('contentFrame').src;");
                out.println("</script>");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("alert('❌ Failed to add user');");
                out.println("window.history.back();");
                out.println("</script>");
            }

//            if (rowInserted > 0) {
//                System.out.println("User inserted successfully.");
//            } else {
//                System.out.println("User NOT inserted.");
//            }
       
//            response.sendRedirect(request.getContextPath() + "/views/users.jsp");
            
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    
    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException
    {
        try
        {
            Connection connection = DBConnection.getConnection();
            String query = "Update tbluser set username =? ,"
                    + " password=?, phone=?,email=?, status=?,role=?, address=? where id =?";
            
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setString(1, request.getParameter("username"));
            pst.setString(2, request.getParameter("password"));
            pst.setString(3, request.getParameter("phone"));
            pst.setString(4, request.getParameter("email"));
            pst.setString(5, request.getParameter("status"));
            pst.setString(6, request.getParameter("role"));
            pst.setString(7, request.getParameter("address"));
            pst.setInt(8, Integer.parseInt(request.getParameter("id")));
            
            int success = pst.executeUpdate();
            if(success>0)
            {
//                 PrintWriter out = response.getWriter();
//                out.println("<script>");
//                out.println("window.parent.location.reload();");
//                out.println("alert('✅ User added successfully');");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws IOException
    {
        try
        {
            Connection connection = DBConnection.getConnection();
            String query = "delete from tbluser where id =?";
            
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(request.getParameter("id")));
            
//              int success = pst.executeUpdate();
//        if (success > 0) {
//            request.getSession().setAttribute("deleteMsg", "✅ User deleted successfully!");
//        } else {
//            request.getSession().setAttribute("deleteMsg", "❌ Failed to delete user.");
//        }
//                response.sendRedirect("views/users.jsp"); // redirect to JSP

            int success = pst.executeUpdate();
            if(success>0)
            {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("window.parent.location.reload();");
                out.println("alert('✅ User deleted successfully!');");
                out.println("</script>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();  
            
        }
    }
    
    
    
    private List<UserModel> getAllUsers()
    {
        List<UserModel> Users = new ArrayList<>();
        
        try
        {
            Connection connection = DBConnection.getConnection();
            String query = "select * from tbluser";
            
            PreparedStatement pst = connection.prepareStatement(query);
            ResultSet result = pst.executeQuery();
            while(result.next())
            {
                UserModel user= new UserModel();
                
                user.setId(result.getInt("id"));
                user.setUsername(result.getString("username"));
                user.setPassword(result.getString("password"));
                user.setPhone(result.getString("phone"));
                user.setMail(result.getString("email"));
                user.setStatus(result.getString("status"));
                user.setRole(result.getString("role"));
                user.setAddress(result.getString("address"));
                
                Users.add(user);
            }
        }
        catch(Exception ex)
        {
            ex.getStackTrace();
        }
        return Users;
    }
    
    
    
}
