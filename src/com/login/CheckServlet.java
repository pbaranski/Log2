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
        // TODO Auto-generated constructor stub
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
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
        // TODO Auto-generated method stub


}

}

