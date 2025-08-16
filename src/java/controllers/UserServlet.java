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
import services.UserService;

/**
 *
 * @author HP
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    
     private UserService userService = new UserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        UserModel user = new UserModel();
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));
        user.setPhone(request.getParameter("phone"));
        user.setMail(request.getParameter("email"));
        user.setStatus(request.getParameter("status"));
        user.setRole(request.getParameter("role"));
        user.setAddress(request.getParameter("address"));

        try {
            if ("add".equals(action)) {
                userService.addUser(user);
            } else if ("update".equals(action)) {
                user.setId(Integer.parseInt(request.getParameter("id")));
                userService.updateUser(user);
            }

            response.sendRedirect("UserServlet"); // Redirect after add/update
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        String searchQuery = request.getParameter("search"); // Search text

        try {
            if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                userService.deleteUser(id);
                response.sendRedirect("UserServlet");
            } else {
                List<UserModel> users = userService.getAllUsers();

                // Search filtering
                if(searchQuery != null && !searchQuery.trim().isEmpty()) {
                    List<UserModel> filteredUsers = new ArrayList<>();
                    for(UserModel u : users) {
                        if(u.getUsername().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           u.getPhone().contains(searchQuery) ||
                           u.getMail().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           u.getAddress().toLowerCase().contains(searchQuery.toLowerCase()) ||
                           u.getStatus().toLowerCase().contains(searchQuery.toLowerCase()))
                        {
                            filteredUsers.add(u);
                        }
                    }
                    users = filteredUsers;
                }

                request.setAttribute("users", users);
                request.setAttribute("totalUsers", users.size());
                request.setAttribute("currentPage", 1);
                request.setAttribute("totalPages", 1);

                request.getRequestDispatcher("/views/users.jsp").forward(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
}

