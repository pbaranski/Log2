package com.tasks;


import db.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {
    Connection con = DBConnect.getConnection();

    public int countRows(int idp, int idu, boolean isAdmin) {
        int countRows = 0;
        try {
            ResultSet rs;
            PreparedStatement pstmt;
            //TODO czy tu powinienem jakoś inicjalizować te zmienne chociaż nulami???
            if (!isAdmin) {
                pstmt = con.prepareStatement("SELECT COUNT(*) FROM task WHERE project_idp =? and task.user_idu =? ");
                pstmt.setInt(1, idp);
                pstmt.setInt(2, idu);
            } else {
                pstmt = con.prepareStatement("SELECT COUNT(*) FROM task WHERE project_idp=?");
                pstmt.setInt(1, idp);
            }
            rs = pstmt.executeQuery();
            while (rs.next()) {
                countRows = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Błąd w obliczeniu count");
            e.printStackTrace();
        }
        return countRows;
    }

    public List<Task> getTasks(int startRow, int numberOfRecords, int idp, int idu, boolean isAdmin) {
        List<Task> lista = new ArrayList<Task>();

        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement pstmt;
            if (isAdmin) {
                pstmt = con.prepareStatement("SELECT * FROM task WHERE task.project_idp = ? limit ?, ? ");
                pstmt.setInt(1, idp);
                pstmt.setInt(2, startRow);
                pstmt.setInt(3, numberOfRecords);
            } else {
                pstmt = con.prepareStatement("SELECT * FROM task WHERE task.project_idp = ? and task.user_idu = ? limit ?, ? ");
                pstmt.setInt(1, idp);
                pstmt.setInt(2, idu);
                pstmt.setInt(3, startRow);
                pstmt.setInt(4, numberOfRecords);
            }
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setIdt(rs.getInt("idt"));
                task.setName(rs.getString("name"));
                task.setPriority(rs.getString("priority"));
                task.setTimeToDo(rs.getDouble("timeToDo"));
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

    public Task getTask(int idt) {
        Task task = new Task();
        try {
            ResultSet rs = con.createStatement()
                    .executeQuery("select * from task where idt=" + idt);
            //TODO czy tu też ma być pstmt?
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

    public void insertTask(Task task) {
        try {
            PreparedStatement pstmt = con.prepareStatement(
                    "insert into task(name,priority,timeToDo,description,project_idp,user_idu) values(?,?,?,?,?,?)");
            pstmt.setString(1, task.getName());
            pstmt.setString(2, task.getPriority());
            pstmt.setDouble(3, task.getTimeToDo());
            pstmt.setString(4, task.getDescription());
            pstmt.setInt(5, task.getProjectId());
            pstmt.setInt(6, task.getUserId());
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void updateTask(Task task) {
        try {
            PreparedStatement pstmt = con.prepareStatement("update task set name=?, priority=?, timeToDo=?, description=?, project_idp=?, user_idu=? where idt=?");
            pstmt.setString(1, task.getName());
            pstmt.setString(2, task.getPriority());
            pstmt.setDouble(3, task.getTimeToDo());
            pstmt.setString(4, task.getDescription());
            pstmt.setInt(5, task.getProjectId());
            pstmt.setInt(6, task.getUserId());
            pstmt.setInt(7, task.getIdt());
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void deleteTask(Task task) {
        deleteTask(task.getIdt());
    }

    public void deleteTask(int idt) {
        try {
            PreparedStatement pstmt = con.prepareStatement("delete from task where idt= ?");
            pstmt.setInt(1, idt);
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }

    }
}

