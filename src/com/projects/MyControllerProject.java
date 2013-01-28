package com.projects;

import db.DBConnect;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;


public class MyControllerProject extends HttpServlet {
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
        if(session == null || session.getAttribute("currentSessionUser")==null)response.sendRedirect("/login.jsp");
        else{


        if(!DBConnect.isConnected()){
			DBConnect.setLocation("jdbc:mysql://127.0.0.1/tasak");
			DBConnect.setLogin("root");
			DBConnect.setPassword("");
			DBConnect.connect();
		}

		ProjectDAO projectDAO = new ProjectDAO();
		boolean refresh_view = false;

		String uri = request.getRequestURI();
		String actionName = uri.substring(uri.lastIndexOf("/") + 1,
				uri.lastIndexOf("."));

		String error = "[" + actionName + "] is not a valid action.";
		request.setAttribute("errorMessage", error);
		String destinationPage = "/error.jsp";

		if (actionName.equals("ProjectDel")) {
			int id = Integer.parseInt(request.getParameter("idt"));
			projectDAO.deleteProject(id);
			refresh_view = true;
		}
		if (actionName.equals("projectInsert")) {
			destinationPage = "/WEB-INF/projectInsert.jsp";
		}
		if (actionName.equals("projectInsertSave")) {

			Project project = new Project();
			try {
				project.setName(request.getParameter("name"));
				project.setDescription(request.getParameter("description"));
				project.setUserId(Integer.parseInt(request.getParameter("userId")));
				projectDAO.insertProject(project);
				refresh_view = true;

			} catch (NumberFormatException e) {
                project.setName(request.getParameter("name"));
                project.setDescription(request.getParameter("description"));
                project.setUserId(1);
                projectDAO.insertProject(project);
                refresh_view = true;
			}
		}

		if (actionName.equals("projectEdit")) {
			int id = Integer.parseInt(request.getParameter("idt"));
			Project project = projectDAO.getProject(id);
			request.setAttribute("project", project);
			destinationPage = "/WEB-INF/projectEdit.jsp";
		}

		if (actionName.equals("projectEditSave")) {
			Project project = new Project();
			project.setIdp(Integer.parseInt(request.getParameter("idp")));
			project.setName(request.getParameter("name"));
			project.setDescription(request.getParameter("description"));
            project.setUserId(Integer.parseInt(request.getParameter("userId")));
			projectDAO.updateProject(project);
			refresh_view = true;
		}

		if (actionName.contains("projectList") || refresh_view) {
            int paginationNum = 5;
            int page = 1;

            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }

            int countRows = projectDAO.countRows();
            System.out.println(page);
            int start = page * (paginationNum) - paginationNum;

            if(start + paginationNum < countRows)request.setAttribute("hasNext", "true");
            else request.setAttribute("hasNext", "false");

            request.setAttribute("page", page);
            request.setAttribute("numOfPages", countRows/paginationNum+1);

            List<Project> projectList = projectDAO.getProject(start, paginationNum);
			request.setAttribute("projectList", projectList);
			destinationPage = "/WEB-INF/projectList.jsp";
		}

		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(destinationPage);
		dispatcher.forward(request, response);

	    }

    }
}