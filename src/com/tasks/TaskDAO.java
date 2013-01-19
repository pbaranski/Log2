package com.tasks;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import com.login.LoginBean;
import db.DBConnect;

/**
 * Klasa do obsługi tabeli samochody
 * Parametry połączenia są w sta�ych CONNECTION_STRING, LOGIN i PASSWORD
 * 
 * @author Pawe� Kasprowski
 *
 */
public class TaskDAO {
	//sekcja inicjalizacyjna dla pol statyccznych
	/**
	 * Zwraca list� wszystkich samochod�w
	 * @return
	 */
	LoginBean user = new LoginBean();
    public List<Task> getTasks() {
		List<Task> lista = new ArrayList<Task>();
		try{
			Connection con = DBConnect.getConnection();
		//wywolujemy zapytanie 	
			ResultSet rs = con.createStatement()
			.executeQuery("select * from task");
			// chodzimy po kolekcji - pierwsze next ustawia sie na pierwszym wierszu
			while(rs.next()) {
				Task task = new Task();
				//numer kolumny lub nazwe kolumny
				task.setIdt(rs.getInt("idt"));
				// pobierz dana z kolumny o nazwie name
				task.setName(rs.getString("name"));
				task.setPriority(rs.getString("priority"));
				try{
				task.setTimeToDo(rs.getDouble("timeToDo"));
				}catch(NumberFormatException e){
					task.setTimeToDo(300.0);
				}
				task.setDescription(rs.getString("description"));
				
				lista.add(task);
			}
		}catch(SQLException ec) {ec.printStackTrace();}
		return lista;
	}

	/**
	 * Zwraca task o podanym idt
	 * @param idt
	 * @return
	 */
	public Task getTask(int idt) {
		Task task = new Task();
		try{
			Connection con = DBConnect.getConnection();
			ResultSet rs = con.createStatement()
			.executeQuery("select * from task where idt="+idt);
			if(rs.next()) {
				task.setIdt(rs.getInt("idt"));
				task.setName(rs.getString("name"));
				task.setPriority(rs.getString("priority"));

				task.setTimeToDo(rs.getDouble("timeToDo"));
				task.setDescription(rs.getString("description"));
			}
		}catch(SQLException ec) {ec.printStackTrace();}
		return task;
	}

	/**
	 * Wstawia do bazy task o podanym idt
	 * @param task
	 */
	public void insertTask(Task task) {
		try{
			Connection con = DBConnect.getConnection();
			PreparedStatement pstmt = con.prepareStatement(
					"insert into task(name,priority,timeToTake) values(?,?,?,?)");
			pstmt.setString(1, task.getName());
			pstmt.setString(2, task.getPriority());

			try{
			pstmt.setDouble(4, task.getTimeToDo());
			
			}catch(NumberFormatException e){
				pstmt.setDouble(4, 22.0);
			}
			pstmt.executeUpdate();
		}
		catch(SQLException ec) {ec.printStackTrace();}  
	}
	
	/**
	 * Aktualizuje w bazie podany jako parametr task (bierze pod uwage idt)
	 * @param task
	 */
	public void updateTask(Task task) {
		try{
			Connection con = DBConnect.getConnection();
			con.createStatement().executeUpdate(
					"update task " +
					" set name='"+task.getName()+"',"+
					" priority='"+task.getPriority()+"',"+
					" dateTimeToDo='"+task.getTimeToDo()+"'"+
					" where idt="+task.getIdt());


		}
		catch(SQLException ec) {ec.printStackTrace();}
	}

	/**
	 * Usuwa podany task
	 * @param task
	 */
	public void deleteTask(Task task) {
		deleteTask(task.getIdt());
	}
	/**
	 * Usuwa z bazy task o podanym idt
	 * @param idt
	 */
	public void deleteTask(int idt) {
		try{
			Connection con = DBConnect.getConnection();
			con.createStatement().executeUpdate(
					"delete from task where idt="+idt);
		}
		catch(SQLException ec) {ec.printStackTrace();}
		
	}
}

