/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package handlers;

import jakarta.servlet.http.HttpServletRequest;
import models.UserModel;

/**
 *
 * @author HP
 */
public class PasswordHandler extends LoginHandler {
    private String inputPassword;

    public PasswordHandler(String inputPassword) {
        this.inputPassword = inputPassword;
    }

    @Override
    public boolean handle(UserModel user, HttpServletRequest request) {
        if (!user.getPassword().equals(inputPassword)) {
            request.setAttribute("errorMsg", "Incorrect password");
            return false;
        }
        return next == null || next.handle(user, request);
    }
}