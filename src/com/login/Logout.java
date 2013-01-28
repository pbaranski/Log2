package com.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: A
 * Date: 13.01.13
 * Time: 17:40
 * To change this template use File | Settings | File Templates.
 */
public class Logout extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    // zabija mnie to twoje oprogramywanie osobno posta osobno geta :D A co jak logout postem przyjdzie?
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("currentSessionUser", null);
        session.invalidate();
        response.sendRedirect("/");
    }
}
