package com.projects;

import com.login.LoginBean;

import db.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProjectDAO {

	public int countRows(){
        Connection con = DBConnect.getConnection();
        int countRows = 0;
        try {
            ResultSet rs = con.createStatement().executeQuery("select count(*) from projects");
            while(rs.next()) {
            countRows = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Błąd w obliczeniu count");
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return countRows;
    }

    LoginBean user = new LoginBean();

    public List<Project> getProject(int startRow, int numberOfRecords) {
		List<Project> list = new ArrayList<Project>();

        try{
			Connection con = DBConnect.getConnection();
            // TODO do zapytania trzeba wrzucic filtrowanie po id albo admin

            ResultSet rs = con.createStatement().executeQuery("select * from project limit " + startRow + ", " + numberOfRecords);

            while(rs.next()) {
				Project project = new Project();
				project.setIdp(rs.getInt("idp"));
				project.setName(rs.getString("name"));
				project.setUserId(rs.getInt("user_idu"));
				project.setDescription(rs.getString("description"));
				list.add(project);
			}
		}catch(SQLException ec) {ec.printStackTrace();}

		return list;
	}

	public Project getProject(int idp) {
		Project project = new Project();
		try{
			Connection con = DBConnect.getConnection();
            //TODO filtrowanie po user || admin
			ResultSet rs = con.createStatement()
			.executeQuery("select * from project where idt="+idp);
			if(rs.next()) {
				project.setIdp(rs.getInt("idp"));
				project.setName(rs.getString("name"));
				project.setDescription(rs.getString("description"));
                project.setUserId(rs.getInt("user_idu"));
			}
		}catch(SQLException ec) {ec.printStackTrace();}
		return project;
	}

	public void insertProject(Project project) {
		try{
			Connection con = DBConnect.getConnection();
			PreparedStatement pstmt = con.prepareStatement(
					"insert into project(name,description,user_idu) values(?,?,?)");
			pstmt.setString(1, project.getName());
			pstmt.setString(2, project.getDescription());
            pstmt.setInt(3, project.getUserId());
         //TODO czy to nie z usera czyli z mojego bina caly czas powinienem brac id???
			pstmt.executeUpdate();
		}
		catch(SQLException ec) {ec.printStackTrace();}  
	}
	
	public void updateProject(Project project) {
		try{
			Connection con = DBConnect.getConnection();
			con.createStatement().executeUpdate(
					"update tasak.project " +
					" set name='"+project.getName()+"',"+
					" description='"+project.getDescription()+"',"+
					" user_idu='"+project.getUserId()+"'"+
					" where idt="+project.getIdp());
		}
		catch(SQLException ec) {ec.printStackTrace();}
	}

	public void deleteProject(Project project) {
		deleteProject(project.getIdp());
	}

	public void deleteProject(int idp) {
		try{
			Connection con = DBConnect.getConnection();
			con.createStatement().executeUpdate(
					"delete from project where idp="+idp);
		}
		catch(SQLException ec) {ec.printStackTrace();}
		
	}
}

