package com.users;

import com.login.LoginBean;
import db.DBConnect;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class MyControllerUser extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        processRequest(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentSessionUser") == null) response.sendRedirect("/");
        else {
            LoginBean user = (LoginBean) session.getAttribute("currentSessionUser");
            DBConnect.connect();

            UserDao userDao = new UserDao();
            boolean refresh_view = false;

            String uri = request.getRequestURI();
            String actionName = uri.substring(uri.lastIndexOf("/") + 1, uri.lastIndexOf("."));
            String error = "[" + actionName + "] this is not valid action.";
            request.setAttribute("errorMessage", error);
            String destinationPage = "error.jsp";

            if (actionName.equals("userDel")) {
                int id = Integer.parseInt(request.getParameter("idu"));
                userDao.deleteUser(id, user.getIdu());
                refresh_view = true;
            }

            if (actionName.equals("addUser")){
                request.setAttribute("isAdmin", user.isAdmin());
                destinationPage = "/WEB-INF/userInsert.jsp";
            }

            if (actionName.contentEquals("saveAddUser")){
                LoginBean userAdd = new LoginBean();
                userAdd.setUserName(request.getParameter("userName"));
                userAdd.setLastName(request.getParameter("userLastName"));
                userAdd.setFirstName(request.getParameter("userFirstName"));
                userAdd.setPassword(request.getParameter("userPassword"));
                userAdd.setIsAdmin(request.getParameter("userIsAdmin").equals("true"));
                userDao.saveAddUser(userAdd);
                refresh_view=true;
            }

            if (actionName.contentEquals("userEdit")){
                int idu = Integer.parseInt(request.getParameter("idu"));
                LoginBean userEdit = userDao.getUser(idu);
               request.setAttribute("user", userEdit);
               request.setAttribute("isAdmin", user.isAdmin());
                destinationPage = "/WEB-INF/userEdit.jsp";
            }

            if (actionName.equals("userEditSave")) {
                LoginBean userEdit = new LoginBean();

                userEdit.setFirstName(request.getParameter("firstName"));
                userEdit.setLastName(request.getParameter("lastName"));
                userEdit.setPassword(request.getParameter("oldPassword"));
                String newPassword = request.getParameter("newPassword");

                 userEdit.setIsAdmin(request.getParameter("isAdmin").equals("true"));
                 userEdit.setUserName(request.getParameter("username"));

            //    userDao.updateUser(userEdit);
                refresh_view = true;
            }


            if (actionName.equals("userList") || refresh_view) {
                List<LoginBean> userList = userDao.getUserList(user.getIdu(), user.isAdmin());
                request.setAttribute("userList", userList);
                request.setAttribute("isAdmin", user.isAdmin());
                destinationPage = "/WEB-INF/userList.jsp";
            }
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(destinationPage);
            dispatcher.forward(request, response);

        }


    }
}
