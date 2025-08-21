/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package handlers;

import jakarta.servlet.http.HttpServletRequest;
import models.UserModel;

public class UsernameHandler extends LoginHandler {
    @Override
    public boolean handle(UserModel user, HttpServletRequest request) {
        if (user == null) {
            request.setAttribute("errorMsg", "Username or email not found");
            return false;
        }
        return next == null || next.handle(user, request);
    }
}
