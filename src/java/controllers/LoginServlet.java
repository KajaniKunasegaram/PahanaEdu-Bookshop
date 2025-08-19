package controllers;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import DAO.UserDAO;
import handlers.LoginHandler;
import handlers.PasswordHandler;
import handlers.StatusHandler;
import handlers.UsernameHandler;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.UserModel;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        UserModel user = dao.getUserByUsernameOrEmail(username);

        // Setup chain
        LoginHandler usernameHandler = new UsernameHandler();
        LoginHandler passwordHandler = new PasswordHandler(password);
        LoginHandler statusHandler = new StatusHandler();

        usernameHandler.setNext(passwordHandler);
        passwordHandler.setNext(statusHandler);

        if (usernameHandler.handle(user, request)) {
            request.getSession().setAttribute("loggedUser", user);
            response.sendRedirect("views/home.jsp");
        } else {
                request.setAttribute("error", "Invalid username or password");

//            request.setAttribute("error", request.getAttribute("errorMsg"));
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

