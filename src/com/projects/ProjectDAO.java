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

	public int countRows(int userId){
        Connection con = DBConnect.getConnection();
        int countRows = 0;
       //TODO no zapytanko jeszcze po idu muszą iść
        try {
            ResultSet rs = con.createStatement().executeQuery("SELECT COUNT(*) FROM users_has_projects WHERE users_idu = " + userId);
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

    public List<Project> getProject(int startRow, int numberOfRecords, int idUser) {
		List<Project> list = new ArrayList<Project>();

        try{
			Connection con = DBConnect.getConnection();
            // TODO do zapytania trzeba wrzucic filtrowanie po id albo admin
             PreparedStatement pstmt = con.prepareStatement("SELECT idp, NAME, description FROM projects INNER JOIN users_has_projects  ON  (?) = users_has_projects.users_idu WHERE projects.idp = users_has_projects.projects_idp limit ?, ?");
            pstmt.setInt(1, idUser);
            pstmt.setInt(2, startRow);
            pstmt.setInt(3, numberOfRecords);
            ResultSet rs = pstmt.executeQuery();
            // ResultSet rs = con.createStatement().executeQuery("select * from projects limit " + startRow + ", " + numberOfRecords);

            while(rs.next()) {
				Project project = new Project();

                project.setIdp(rs.getInt("idp"));
				project.setName(rs.getString("name"));
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
			.executeQuery("select * from project where idp="+idp);
			if(rs.next()) {
				project.setIdp(rs.getInt("idp"));
				project.setName(rs.getString("name"));
				project.setDescription(rs.getString("description"));

			}
		}catch(SQLException ec) {ec.printStackTrace();}
		return project;
	}

	public void insertProject(Project project) {
		try{
			Connection con = DBConnect.getConnection();
			PreparedStatement pstmt = con.prepareStatement(
					"insert into project(name,description) values(?,?)");
			pstmt.setString(1, project.getName());
			pstmt.setString(2, project.getDescription());
         //TODO czy to nie z usera czyli z mojego bina caly czas powinienem brac id???
			pstmt.executeUpdate();

		}
		catch(SQLException ec) {ec.printStackTrace();}  
	}
	
	public void updateProject(Project project) {
		try{
			Connection con = DBConnect.getConnection();
			con.createStatement().executeUpdate(
					"update project " +
					" set name='"+project.getName()+"',"+
					" description='"+project.getDescription()+"',"+
					" where idp="+project.getIdp());
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

