package com.login;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * @see javax.servlet.http.HttpServlet#HttpServlet()
     */
    public CheckServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            check(request, response);
            // System.out.println("In Check Servlet");
            // HttpSession session = request.getSession(true);
            // session.setAttribute("currentSessionUser", user);
               response.sendRedirect("/log");
            // request.setAttribute("err", "");
            //  request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        } catch (Throwable exc) {
            System.out.println(exc);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        check(request, response);

    }

    private void check(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String uri = request.getRequestURI().toString();
//        if (uri.length()>3 ){
//                HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("currentSessionUser") == null) {
//            request.setAttribute(uri, uri);
//            response.sendRedirect("/log");
//        }
 //   }
}

}

