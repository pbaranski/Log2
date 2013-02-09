package com.tasks;


import db.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Klasa do obsługi tabeli tasks
 * Parametry połączenia są w stalych CONNECTION_STRING, LOGIN i PASSWORD
 */
public class TaskDAO {
    //sekcja inicjalizacyjna dla pol statyccznych


    public int countRows(int idp, int idu,boolean isAdmin) {
        Connection con = DBConnect.getConnection();
        int countRows = 0;
        try {
            ResultSet rs;
            if(!isAdmin)
                rs = con.createStatement().executeQuery("SELECT COUNT(*) FROM task WHERE project_idp =" + idp + " and task.user_idu = " + idu);
            else rs = con.createStatement().executeQuery("SELECT COUNT(*) FROM task WHERE project_idp =" + idp);
            while (rs.next()) {
                countRows = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Błąd w obliczeniu count");
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return countRows;
    }

    // LoginBean user = new LoginBean();
    public List<Task> getTasks(int startRow, int numberOfRecords, int idp, int idu, boolean isAdmin) {
        List<Task> lista = new ArrayList<Task>();

        try {
            Connection con = DBConnect.getConnection();
            //wywolujemy zapytanie
            // TODO do zapytania trzeba wrzucic filtrowanie po id albo admin
            PreparedStatement pstmt;
            if (isAdmin) {
                pstmt = con.prepareStatement("SELECT * FROM task WHERE task.project_idp = ? limit ?, ? ");
                pstmt.setInt(1, idp);
                pstmt.setInt(2, startRow);
                pstmt.setInt(3, numberOfRecords);

            } else {
                pstmt = con.prepareStatement("SELECT * FROM task WHERE task.project_idp = ? and task.user_idu = ? limit ?, ? ");

            //      = con.createStatement().executeQuery();
            pstmt.setInt(1, idp);
            pstmt.setInt(2, idu);
            pstmt.setInt(3, startRow);
            pstmt.setInt(4, numberOfRecords);
            }
                ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                //numer kolumny lub nazwe kolumny
                task.setIdt(rs.getInt("idt"));
                // pobierz dana z kolumny o nazwie name
                task.setName(rs.getString("name"));
                task.setPriority(rs.getString("priority"));
                try {
                    task.setTimeToDo(rs.getDouble("timeToDo"));
                } catch (NumberFormatException e) {
                    task.setTimeToDo(300.0);
                }
                task.setDescription(rs.getString("description"));
                task.setProjectId(rs.getInt("project_idp"));
                task.setUserId(rs.getInt("user_idu"));
                lista.add(task);
            }
        } catch (SQLException ec) {
            ec.printStackTrace();
        }

        return lista;
    }

    /**
     * Zwraca task o podanym idt
     *
     * @param idt
     * @return
     */
    public Task getTask(int idt) {
        Task task = new Task();
        try {
            Connection con = DBConnect.getConnection();
            //TODO filtrowanie po user || admin
            ResultSet rs = con.createStatement()
                    .executeQuery("select * from task where idt=" + idt);
            if (rs.next()) {
                task.setIdt(rs.getInt("idt"));
                task.setName(rs.getString("name"));
                task.setPriority(rs.getString("priority"));

                task.setTimeToDo(rs.getDouble("timeToDo"));
                task.setDescription(rs.getString("description"));
                task.setProjectId(rs.getInt("project_idp"));
                task.setUserId(rs.getInt("user_idu"));
            }
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
        return task;
    }

    /**
     * Wstawia do bazy task o podanym idt
     *
     * @param task
     */
    public void insertTask(Task task) {
        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement pstmt = con.prepareStatement(
                    "insert into task(name,priority,timeToDo,description,project_idp,user_idu) values(?,?,?,?,?,?)");
            pstmt.setString(1, task.getName());
            pstmt.setString(2, task.getPriority());

            try {
                pstmt.setDouble(3, task.getTimeToDo());

            } catch (NumberFormatException e) {
                pstmt.setDouble(3, 22.0);
            }
            pstmt.setString(4, task.getDescription());
            //TODO czy to nie z usera czyli z mojego bina caly czas powinienem brac id???

            pstmt.setInt(5, task.getProjectId());
            pstmt.setInt(6, task.getUserId());
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    /**
     * Aktualizuje w bazie podany jako parametr task (bierze pod uwage idt)
     *
     * @param task
     */
    public void updateTask(Task task) {
        try {
            Connection con = DBConnect.getConnection();
            con.createStatement().executeUpdate(
                    "update task " +
                            " set name='" + task.getName() + "'," +
                            " priority='" + task.getPriority() + "'," +
                            " timeToDo='" + task.getTimeToDo() + "'," +
                            " description='" + task.getDescription() + "'," +
                            " project_idp='" + task.getProjectId() + "'," +
                            " user_idu='" + task.getUserId() + "'" +
                            " where idt=" + task.getIdt());


        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    /**
     * Usuwa podany task
     *
     * @param task
     */
    public void deleteTask(Task task) {
        deleteTask(task.getIdt());
    }

    /**
     * Usuwa z bazy task o podanym idt
     *
     * @param idt
     */
    public void deleteTask(int idt) {
        try {
            Connection con = DBConnect.getConnection();
            con.createStatement().executeUpdate(
                    "delete from task where idt=" + idt);
        } catch (SQLException ec) {
            ec.printStackTrace();
        }

    }
}

