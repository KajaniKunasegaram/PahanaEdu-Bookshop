/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import models.customersModel;

/**
 *
 * @author HP
 */
@WebServlet("/CustomerServlet")
public class CustomerServlet extends HttpServlet {

   
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ArrayList<customersModel> customersCollections = new ArrayList<>();
       
        customersCollections.add(new customersModel("ACC001", "Sanjeewa", "Colombo 07", "0771234567", "a@gmail.com", true));
        customersCollections.add(new customersModel("ACC002", "Nimal", "Kandy", "0777654321", "b@gmail.com", false));

        request.setAttribute("customers", customersCollections);
        request.getRequestDispatcher("customers.jsp").forward(request, response);
    }
}