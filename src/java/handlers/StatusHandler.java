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
public class StatusHandler extends LoginHandler {
    @Override
    public boolean handle(UserModel user, HttpServletRequest request) {
        if (!"active".equalsIgnoreCase(user.getStatus())) {
            request.setAttribute("errorMsg", "User is inactive");
            return false;
        }
        return next == null || next.handle(user, request);
    }
}
