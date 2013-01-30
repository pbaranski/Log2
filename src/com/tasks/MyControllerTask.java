package com.tasks;

import com.login.LoginBean;
import com.projects.Project;
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
        if(session == null || session.getAttribute("currentSessionUser")==null)response.sendRedirect("/login.jsp");
        else{
            LoginBean user = (LoginBean) session.getAttribute("currentSessionUser");

        if(!DBConnect.isConnected()){
			DBConnect.setLocation("jdbc:mysql://127.0.0.1/tasak");
			DBConnect.setLogin("root");
			DBConnect.setPassword("");
			DBConnect.connect();
		}

          int idp = 1;
            try {

                idp = Integer.parseInt(request.getParameter("idp"));
                session.setAttribute("idp", idp);
            } catch (NumberFormatException e) {
                System.out.println("idp atribute not atached");
            }
            idp = (int) session.getAttribute("idp");


        // przygotowanie dostępu do danych
		TaskDAO taskDAO = new TaskDAO();
		boolean refresh_view = false;

		// rozpakowanie nazwy akcji
		String uri = request.getRequestURI();
		String actionName = uri.substring(uri.lastIndexOf("/") + 1,
				uri.lastIndexOf("."));

		// nieznana akcja - przekieruj na error.jsp
		String error = "[" + actionName + "] is not a valid action.";
		request.setAttribute("errorMessage", error);
		String destinationPage = "/error.jsp";



		// obsługa akcji carDel - usunięcie taska
		if (actionName.equals("taskDel")) {
			// pobranie identyfikatora taskat
			int id = Integer.parseInt(request.getParameter("idt"));
			// usuniecie z bazy
			taskDAO.deleteTask(id);
			// i zaznaczenie widoku do odświeżenia
			refresh_view = true;
		}

		// obsługa akcji taskInsert - wstawianie taska
		if (actionName.equals("taskInsert")) {

			// ustawienie przekierowania na stronę jsp

			destinationPage = "/WEB-INF/taskInsert.jsp";
		}

		// obsługa akcji taskInsert - zapis danych nowego taska
		if (actionName.equals("taskInsertSave")) {

			Task task = new Task();
			try {
				// pobranie danych taska
				task.setName(request.getParameter("name"));
				task.setPriority(request.getParameter("priority"));
				task.setTimeToDo(Double.parseDouble(request.getParameter("timeToDo")));
				task.setDescription(request.getParameter("description"));
				//TODO dla zwyklego usera - shit jeszcze w jsp trzeba zrobic
				//task.setProjectId(idp);
                //task.setUserId(user.getIdu);
				task.setProjectId(Integer.parseInt(request.getParameter("projectId")));
				task.setUserId(Integer.parseInt(request.getParameter("userId")));

				// wstawienie do bazy

				taskDAO.insertTask(task);
				// i zaznaczenie widoku do odświeżenia
				refresh_view = true;

			} catch (NumberFormatException e) {
				task.setName(request.getParameter("name"));
				task.setPriority(request.getParameter("priority"));
				task.setTimeToDo(200.0);
                task.setDescription(request.getParameter("description"));
                task.setProjectId(idp);
                task.setUserId(user.getIdu());

				// wstawienie do bazy

				taskDAO.insertTask(task);
				// i zaznaczenie widoku do odświeżenia
				refresh_view = true;
			}
		}

		// obsługa akcji TaskEdit - edycja taska
		if (actionName.equals("taskEdit")) {
			// pobranie identyfikatora taska
			int id = Integer.parseInt(request.getParameter("idt"));
			// pobranie taska
			Task task = taskDAO.getTask(id);
			// wstawienie taska do request
			request.setAttribute("task", task);
			// ustawienie przekierowania na stronę jsp
			destinationPage = "/WEB-INF/taskEdit.jsp";
		}

		// obsługa akcji TaskInsert - zapis danych nowego taska
		if (actionName.equals("taskEditSave")) {

            Task task = new Task();
			// pobranie danych taska
			task.setIdt(Integer.parseInt(request.getParameter("idt")));
			task.setName(request.getParameter("name"));
			task.setPriority(request.getParameter("priority"));
			task.setTimeToDo(Double.parseDouble(request.getParameter("timeToDo")));
            task.setDescription(request.getParameter("description"));
           //TODO admin moze ale user nie i @#$ bo nie bedzie mi taskow po projektach rozsiewał :)
            //task.setUserId(user.getIdu);

            task.setProjectId(Integer.parseInt(request.getParameter("projectId")));
            task.setUserId(Integer.parseInt(request.getParameter("userId")));
			// wstawienie do bazy
			taskDAO.updateTask(task);
			// i zaznaczenie widoku do odświeżenia
			refresh_view = true;
		}

		// obsługa akcji TaskList - przezentacja listy taskow
		if (actionName.contains("taskList") || refresh_view) {
			// wydobycie z bazy listy taskow
            String extractNumber = null;
           // int idp = (int) session.getAttribute("idp");


            int paginationNum = 5;
            int page = 1;
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                System.out.println("Page atribute not atached");
            }

            //ilosc kolumn
            int countRows = taskDAO.countRows(idp, user.getIdu());
            //pierwszy rekord na stronie
            int start = page * paginationNum - paginationNum;
            //sprawdzenie czy dać przycisk nextPage

            if(start + paginationNum < countRows)request.setAttribute("hasNext", "true");
            else request.setAttribute("hasNext", "false");


            request.setAttribute("page", page);
            request.setAttribute("numOfPages", countRows/(paginationNum+1) + 1);

            List<Task> taskList = taskDAO.getTasks(start, paginationNum, idp, user.getIdu());
			// wstawienie listy do request
			// rzadanie bedzie przekazane przez jsp - czyli doklejanie
			// wstawilismy do rzadania liste taskow
			request.setAttribute("taskList", taskList);

             request.setAttribute("projectName",new ProjectDAO().getProjectName(idp));

			// ustawienie przekierowania na stronę jsp
			destinationPage = "/WEB-INF/taskList.jsp";
		}

		// przekierowanie do wybranej strony jsp
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(destinationPage);
		dispatcher.forward(request, response);

	    }

    }
}
