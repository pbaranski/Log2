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
 * Klasa do obsługi tabeli tasks
 * Parametry połączenia są w stalych CONNECTION_STRING, LOGIN i PASSWORD
 *	Niby kaj? Tu w komencie masz napisane to o czym ja juz 3 raz pisze przeczytaj go sobie ze 2 razy :D
 */
public class TaskDAO {
	//sekcja inicjalizacyjna dla pol statyccznych


	public int countRows(){
        Connection con = DBConnect.getConnection();
        int countRows = 0;
        try {
            ResultSet rs = con.createStatement().executeQuery("select count(*) from task");
            while(rs.next()) {
            countRows = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Błąd w obliczeniu count");
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return countRows;
    }
	// a ten nowy user tu po co?	
    LoginBean user = new LoginBean();
    public List<Task> getTasks(int startRow, int numberOfRecords) {
		List<Task> lista = new ArrayList<Task>();

        try{
			Connection con = DBConnect.getConnection();
		//wywolujemy zapytanie
            // TODO do zapytania trzeba wrzucic filtrowanie po id albo admin
	// prepare statment to po pierwsze!!!
            ResultSet rs = con.createStatement().executeQuery("select * from task limit " + startRow + ", " + numberOfRecords);


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
                task.setUserId(rs.getInt("user_idu"));
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
            //TODO filtrowanie po user || admin !!!!Prepare statment!!!!
			ResultSet rs = con.createStatement()
			.executeQuery("select * from task where idt="+idt);
			if(rs.next()) {
				task.setIdt(rs.getInt("idt"));
				task.setName(rs.getString("name"));
				task.setPriority(rs.getString("priority"));

				task.setTimeToDo(rs.getDouble("timeToDo"));
				task.setDescription(rs.getString("description"));
                task.setUserId(rs.getInt("user_idu"));
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
			// Wiesz co nie!!
			PreparedStatement pstmt = con.prepareStatement(
					"insert into task(name,priority,timeToDo,description,user_idu) values(?,?,?,?,?)");
			pstmt.setString(1, task.getName());
			pstmt.setString(2, task.getPriority());

			try{
			pstmt.setDouble(3, task.getTimeToDo());
			
			}catch(NumberFormatException e){
				pstmt.setDouble(3, 22.0);
			}
            pstmt.setString(4, task.getDescription());
         //TODO czy to nie z usera czyli z mojego bina caly czas powinienem brac id???
	// czy to pytanie retoryczne? Po to masz te sesje zeby wiedziec kto pyta 
            pstmt.setInt(5, task.getUserId());
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
			// co zapytanie to comment masakra.
			con.createStatement().executeUpdate(
					"update tasak.task " +
					" set name='"+task.getName()+"',"+
					" priority='"+task.getPriority()+"',"+
					" timeToDo='"+task.getTimeToDo()+"',"+
					" description='"+task.getDescription()+"',"+
					" user_idu='"+task.getUserId()+"'"+
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

