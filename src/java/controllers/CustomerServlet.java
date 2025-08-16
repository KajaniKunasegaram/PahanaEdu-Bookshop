/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.sql.*;


import DBAccess.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import models.CustomerModel;

/**
 *
 * @author HP
 */



@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet
{

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if("add".equals(action))
        {
            addCustomer(request,response);
        }
        else if("update".equals(action))
        {
            updateCustomer(request,response);
        }
        
    }
   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String action = request.getParameter("action");
        if("delete".equals(action))
        {
            deleteCustomer(request,response);
        }
        else
        {
            String search = request.getParameter("search");
            if (search != null && !search.trim().isEmpty()) {
                List<CustomerModel> searchResults = searchCustomers(search.trim());
                request.setAttribute("customers", searchResults);
                request.setAttribute("totalCustomers", searchResults.size());
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", 1);
            } else {
                int page = 1;
                int recordsPerPage = 10;

                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }

                List<CustomerModel> customerList = getAllCustomers((page - 1) * recordsPerPage, recordsPerPage);
                int totalCustomers = getCustomerCount();
                int totalPages = (int) Math.ceil(totalCustomers * 1.0 / recordsPerPage);

                request.setAttribute("customers", customerList);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPages);
                request.setAttribute("totalCustomers", totalCustomers);
            }

            request.getRequestDispatcher("/views/customers.jsp").forward(request, response);
        }
    }
    
    private void addCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        try
        {
            Connection connection = DBConnection.getInstance().getConnection();
            System.out.println("✅ Connection successful");
            String query ="INSERT INTO tblcustomer (account_no, name, phone, address) VALUES (?, ?, ?, ?)";
            PreparedStatement pst = connection.prepareStatement(query);
            
            pst.setString(1, request.getParameter("account_no"));
            pst.setString(2, request.getParameter("name"));
            pst.setString(3, request.getParameter("phone"));
            pst.setString(4, request.getParameter("address"));
            
            int rowInserted = pst.executeUpdate();

            if (rowInserted > 0) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("window.parent.location.reload();");
                out.println("alert('✅ Customer added successfully!');");

                out.println("window.parent.closeAddCustomerPopup();");
                out.println("window.parent.document.getElementById('contentFrame').src = window.parent.document.getElementById('contentFrame').src;");
                out.println("</script>");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("alert('❌ Failed to add customer');");
                out.println("window.history.back();");
                out.println("</script>");
            }
            
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    
     private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException
    {
        try
        {
            Connection connection = DBConnection.getInstance().getConnection();
            String query ="UPDATE tblcustomer SET name=?, phone=?, address=? WHERE account_no=?";
            
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setString(1, request.getParameter("name"));
            pst.setString(2, request.getParameter("phone"));
            pst.setString(3, request.getParameter("address"));
            pst.setString(4, request.getParameter("account_no"));
            
            int success = pst.executeUpdate();
            if (success > 0) {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("window.parent.location.reload();");
                out.println("alert('✅ Customer updated successfully!');");

                out.println("window.parent.closeAddCustomerPopup();");
                out.println("window.parent.document.getElementById('contentFrame').src = window.parent.document.getElementById('contentFrame').src;");
                out.println("</script>");
            } else {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("alert('❌ Failed to update Customer');");
                out.println("window.history.back();");
                out.println("</script>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
     
     
    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException
    {
        try
        {
            Connection connection = DBConnection.getInstance().getConnection();
            String query = "DELETE FROM tblcustomer WHERE id=?";
            
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setInt(1, Integer.parseInt(request.getParameter("id")));
            
            int success = pst.executeUpdate();
            if(success>0)
            {
                response.setContentType("text/html");
                PrintWriter out = response.getWriter();
                out.println("<script>");
                out.println("window.parent.location.reload();");
                out.println("alert('✅ customer deleted successfully!');");
                out.println("</script>");
            }
        }
        catch(Exception ex)
        {
            ex.printStackTrace();  
            
        }
    }
    
    private List<CustomerModel> getAllCustomers(int offset, int noOfRecords) {
        List<CustomerModel> Customers = new ArrayList<>();

        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String query = "SELECT * FROM tblcustomer ORDER BY id DESC LIMIT ? , ?";
            PreparedStatement pst = connection.prepareStatement(query);
            pst.setInt(1, offset);
            pst.setInt(2, noOfRecords);
            ResultSet result = pst.executeQuery();

            while (result.next()) {
                CustomerModel customer = new CustomerModel();
                customer.setId(result.getInt("id"));
                customer.setAccountNo(result.getString("account_no"));
                customer.setName(result.getString("name"));
                customer.setPhone(result.getString("phone"));
                customer.setAddress(result.getString("address"));
                Customers.add(customer);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return Customers;
    }
    
    private int getCustomerCount() {
        int count = 0;
        try {
            Connection connection = DBConnection.getInstance().getConnection();
            String query = "SELECT COUNT(*) FROM tblcustomer ";
            PreparedStatement pst = connection.prepareStatement(query);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    private List<CustomerModel> searchCustomers(String keyword) {
        List<CustomerModel> Customers = new ArrayList<>();
            try {
                
                 Connection connection = DBConnection.getInstance().getConnection();
            String query = "SELECT * FROM tblcustomer WHERE name LIKE "
                    + "? OR phone LIKE ? OR address LIKE ? OR account_no LIKE ?";
            PreparedStatement pst = connection.prepareStatement(query);
            String searchValue = "%" + keyword + "%";
            pst.setString(1, searchValue);
            pst.setString(2, searchValue);
            pst.setString(3, searchValue);
            pst.setString(4, searchValue);
            
            ResultSet result = pst.executeQuery();
            while (result.next()) {
                CustomerModel customer = new CustomerModel();
                customer.setName(result.getString("name"));
                customer.setAccountNo(result.getString("account_no"));
                customer.setPhone(result.getString("phone"));
                customer.setAddress(result.getString("address"));
                Customers.add(customer);
            }
            
                
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            return Customers;
    }


}