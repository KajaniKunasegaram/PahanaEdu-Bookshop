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
public abstract class LoginHandler {
    protected LoginHandler next;

    public void setNext(LoginHandler next) {
        this.next = next;
    }

    public abstract boolean handle(UserModel user, HttpServletRequest request);
}
