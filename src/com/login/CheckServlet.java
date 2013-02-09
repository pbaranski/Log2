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
            ///<Kamil>
            ///tu daj wywolanie metody check(request,response);
            ///</Kamil>
            
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
        ///<Kamil>
        ///tu daj wywolanie metody check(request,response);
        ///</Kamil>


}
        ///<Kamil>
        ///private void check((HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ///         
        ///         1.Pobieram url wpisany przez usera;
        ///         2. Sprawdzam czy zalogowany 
        ///         3. Jak tak to przekierowuje na pobrana komende
        ///         4.Jak nie to zapamietuje komende i na login z nim.
        ///         5. sie zaloguje to zamiast na home poleci tam kaj chcial.
        ///}
        ///</Kamil>
}

