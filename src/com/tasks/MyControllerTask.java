package com.tasks;

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
        if(session == null || session.getAttribute("currentSessionUser")==null)response.sendRedirect("/index.jsp");
        else{


        if(!DBConnect.isConnected()){
			DBConnect.setLocation("jdbc:mysql://127.0.0.1/tasak");
			DBConnect.setLogin("root");
			DBConnect.setPassword("");
			DBConnect.connect();
		}




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



		// obsługa akcji carDel - usunięcie samochodu
		if (actionName.equals("taskDel")) {
			// pobranie identyfikatora samochodu
			int id = Integer.parseInt(request.getParameter("idt"));
			// usuniecie z bazy
			taskDAO.deleteTask(id);
			// i zaznaczenie widoku do odświeżenia
			refresh_view = true;
		}

		// obsługa akcji carInsert - wstawianie samochodu
		if (actionName.equals("taskInsert")) {

			// ustawienie przekierowania na stronę jsp

			destinationPage = "/taskInsert.jsp";
		}

		// obsługa akcji carInsert - zapis danych nowego samochodu
		if (actionName.equals("taskInsertSave")) {

			Task task = new Task();
			try {
				// pobranie danych samochodu
				task.setName(request.getParameter("name"));
				task.setPriority(request.getParameter("priority"));

				task.setTimeToDo(Double.parseDouble(request.getParameter("timeToDo")));

				// wstawienie do bazy

				taskDAO.insertTask(task);
				// i zaznaczenie widoku do odświeżenia
				refresh_view = true;

			} catch (NumberFormatException e) {
				task.setName(request.getParameter("name"));
				task.setPriority(request.getParameter("priority"));

				task.setTimeToDo(200.0);

				// wstawienie do bazy

				taskDAO.insertTask(task);
				// i zaznaczenie widoku do odświeżenia
				refresh_view = true;
			}
		}

		// obsługa akcji TaskEdit - edycja samochodu
		if (actionName.equals("taskEdit")) {
			// pobranie identyfikatora samochodu
			int id = Integer.parseInt(request.getParameter("idt"));
			// pobranie samochodu
			Task task = taskDAO.getTask(id);
			// wstawienie samochodu do request
			request.setAttribute("task", task);
			// ustawienie przekierowania na stronę jsp
			destinationPage = "/taskEdit.jsp";
		}

		// obsługa akcji TaskInsert - zapis danych nowego samochodu
		if (actionName.equals("taskEditSave")) {
			Task task = new Task();
			// pobranie danych samochodu
			task.setIdt(Integer.parseInt(request.getParameter("idt")));
			task.setName(request.getParameter("name"));
			task.setPriority(request.getParameter("priority"));


			task.setTimeToDo(Double.parseDouble(request.getParameter("timeToDo")));
			// wstawienie do bazy
			taskDAO.updateTask(task);
			// i zaznaczenie widoku do odświeżenia
			refresh_view = true;
		}

		// obsługa akcji TaskList - przezentacja listy samochodów
		if (actionName.equals("taskList") || refresh_view) {
			// wydobycie z bazy listy samochodów
			List<Task> taskList = taskDAO.getTasks();
			// wstawienie listy do request
			// rzadanie bedzie przekazane przez jsp - czyli doklejanie
			// wstawilismy do rzadania liste samochodow
			request.setAttribute("taskList", taskList);

			// ustawienie przekierowania na stronę jsp
			destinationPage = "/taskList.jsp";
		}

		// przekierowanie do wybranej strony jsp
		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(destinationPage);
		dispatcher.forward(request, response);

	    }

    }
}
