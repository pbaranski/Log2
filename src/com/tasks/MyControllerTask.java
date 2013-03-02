package com.tasks;

import com.login.LoginBean;
import com.projects.ProjectDAO;
import db.DBConnect;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


public class MyControllerTask extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        processRequest(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request,
                                HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentSessionUser") == null) response.sendRedirect("/");
        else {
            LoginBean user = (LoginBean) session.getAttribute("currentSessionUser");


                DBConnect.connect();


            int idp = 1;
            try {
                idp = Integer.parseInt(request.getParameter("idp"));
                session.setAttribute("idp", idp);
            } catch (NumberFormatException e) {
                System.out.println("idp atribute not atached");
            }
            TaskDAO taskDAO = new TaskDAO();
            idp = (int) session.getAttribute("idp");
            boolean refresh_view = false;

            String uri = request.getRequestURI();
            String actionName = uri.substring(uri.lastIndexOf("/") + 1,
                    uri.lastIndexOf("."));
            String error = "[" + actionName + "] is not a valid action.";
            request.setAttribute("errorMessage", error);
            String destinationPage = "/error.jsp";

            if (actionName.equals("taskDel")) {
                int id = Integer.parseInt(request.getParameter("idt"));
                taskDAO.deleteTask(id);
                refresh_view = true;
            }

            if (actionName.equals("taskInsert")) {
                request.setAttribute("projectName", new ProjectDAO().getProjectName(idp));
                request.setAttribute("idu",user.getIdu());
                if (user.isAdmin()) request.setAttribute("isAdmin", "true");
                destinationPage = "/WEB-INF/taskInsert.jsp";
            }

            if (actionName.equals("taskInsertSave")) {
                Task task = new Task();
                    task.setName(request.getParameter("name"));
                    task.setPriority(request.getParameter("priority"));
                    task.setTimeToDo(Double.parseDouble(request.getParameter("timeToDo")));
                    task.setDescription(request.getParameter("description"));
                    if (!user.isAdmin()) {
                        task.setUserId(user.getIdu());
                        task.setProjectId(idp);
                    } else {
                        task.setProjectId(Integer.parseInt(request.getParameter("projectId")));
                        task.setUserId(Integer.parseInt(request.getParameter("userId")));
                    }
                    taskDAO.insertTask(task);
                    refresh_view = true;
            }

            if (actionName.equals("taskEdit")) {
                int id = Integer.parseInt(request.getParameter("idt"));
                Task task = taskDAO.getTask(id);
                if (user.isAdmin()) request.setAttribute("isAdmin", "true");
                request.setAttribute("task", task);
                request.setAttribute("projectName", new ProjectDAO().getProjectName(idp));
                destinationPage = "/WEB-INF/taskEdit.jsp";
            }

            if (actionName.equals("taskEditSave")) {
                Task task = new Task();
                task.setIdt(Integer.parseInt(request.getParameter("idt")));
                task.setName(request.getParameter("name"));
                task.setPriority(request.getParameter("priority"));
                task.setTimeToDo(Double.parseDouble(request.getParameter("timeToDo")));
                task.setDescription(request.getParameter("description"));

                if (!user.isAdmin()) {
                    task.setUserId(user.getIdu());
                    task.setProjectId((int) session.getAttribute("idp"));
                } else {
                    task.setProjectId(Integer.parseInt(request.getParameter("projectId")));
                    task.setUserId(Integer.parseInt(request.getParameter("userId")));
                }
                taskDAO.updateTask(task);
                refresh_view = true;
            }

            if (actionName.contains("taskList") || refresh_view) {
                int paginationNum = 5;
                int page = 1;
                try {
                    page = Integer.parseInt(request.getParameter("page"));
                } catch (NumberFormatException e) {
                    System.out.println("Page atribute not atached");
                }
                int countRows = taskDAO.countRows(idp, user.getIdu(), user.isAdmin());
                int start = page * paginationNum - paginationNum;
                if (start + paginationNum < countRows) request.setAttribute("hasNext", "true");
                else request.setAttribute("hasNext", "false");
                int numOfPages = (countRows-1)/(paginationNum)+1;

                request.setAttribute("page", page);
                request.setAttribute("numOfPages", numOfPages);

                List<Task> taskList = taskDAO.getTasks(start, paginationNum, idp, user.getIdu(), user.isAdmin());
                request.setAttribute("taskList", taskList);
                request.setAttribute("projectName", new ProjectDAO().getProjectName(idp));
                destinationPage = "/WEB-INF/taskList.jsp";
            }

            RequestDispatcher dispatcher = getServletContext()
                    .getRequestDispatcher(destinationPage);
            dispatcher.forward(request, response);

        }

    }
}
