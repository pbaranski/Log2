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

    public int countRows(int userId,boolean isAdmin) {
        Connection con = DBConnect.getConnection();
        int countRows = 0;
        //TODO no zapytanko jeszcze po idu muszą iść
        try {

            ResultSet rs;
            if(!isAdmin)rs = con.createStatement().executeQuery("SELECT COUNT(*) FROM users_has_projects WHERE users_idu = " + userId);
            else rs = con.createStatement().executeQuery("SELECT COUNT(*) FROM projects");
            while (rs.next()) {
                countRows = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Błąd w obliczeniu count");
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        return countRows;
    }

    public List<Project> getProject(int startRow, int numberOfRecords, int idUser, boolean isAdmin) {
        List<Project> list = new ArrayList<Project>();

        try {
            Connection con = DBConnect.getConnection();
            // TODO do zapytania trzeba wrzucic filtrowanie po id albo admin
            PreparedStatement pstmt;
            if (isAdmin) {
                pstmt = con.prepareStatement("SELECT * FROM projects limit ?, ?");
                pstmt.setInt(1, startRow);
                pstmt.setInt(2, numberOfRecords);
            } else {
                pstmt = con.prepareStatement("SELECT idp, NAME, description FROM projects INNER JOIN users_has_projects  ON  (?) = users_has_projects.users_idu WHERE projects.idp = users_has_projects.projects_idp limit ?, ?");
                pstmt.setInt(1, idUser);
                pstmt.setInt(2, startRow);
                pstmt.setInt(3, numberOfRecords);
            }

            ResultSet rs = pstmt.executeQuery();
            // ResultSet rs = con.createStatement().executeQuery("select * from projects limit " + startRow + ", " + numberOfRecords);

            while (rs.next()) {
                Project project = new Project();

                project.setIdp(rs.getInt("idp"));
                project.setName(rs.getString("name"));
                project.setDescription(rs.getString("description"));
                list.add(project);
            }
        } catch (SQLException ec) {
            ec.printStackTrace();
        }

        return list;
    }

    public Project getProject(int idp) {
        Project project = new Project();
        try {
            Connection con = DBConnect.getConnection();
            //TODO filtrowanie po user || admin
            ResultSet rs = con.createStatement()
                    .executeQuery("SELECT * FROM projects WHERE idp=" + idp);
            if (rs.next()) {
                project.setIdp(rs.getInt("idp"));
                project.setName(rs.getString("name"));
                project.setDescription(rs.getString("description"));

            }
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
        return project;
    }

    public String getProjectName(int idp) {
        Project project = new Project();
        try {
            Connection con = DBConnect.getConnection();
            ResultSet rs = con.createStatement()
                    .executeQuery("SELECT * FROM projects WHERE idp=" + idp);
            if (rs.next()) {
                project.setName(rs.getString("name"));
            }
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
        return project.getName();
    }

    public int getProjectLastId() {
        Project project = new Project();
        try {
            Connection con = DBConnect.getConnection();
            ResultSet rs = con.createStatement()
                    .executeQuery("SELECT MAX(idp) FROM projects");
            if (rs.next()) {
                return rs.getInt("max(idp)");
            }
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
        return 1;
    }

    public void insertProject(Project project, int user_idu) {
        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement pstmt = con.prepareStatement(
                    "INSERT INTO projects(NAME,description) VALUES(?,?)");
            pstmt.setString(1, project.getName());
            pstmt.setString(2, project.getDescription());
            insertUserToProject(user_idu, getProjectLastId());
            pstmt.executeUpdate();

        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void insertUserToProject(int user_idu, int project_idp) {
        try {
            Connection con = DBConnect.getConnection();

            PreparedStatement pstmt = con.prepareStatement(
                    "INSERT INTO users_has_projects(users_idu, projects_idp) VALUES(?,?)");
            pstmt.setInt(1, user_idu);
            pstmt.setInt(2, project_idp);
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void updateProject(Project project) {
        try {
            Connection con = DBConnect.getConnection();
            con.createStatement().executeUpdate(
                    "UPDATE tasak.projects " +
                            " SET tasak.projects.name='" + project.getName() + "'," +
                            " tasak.projects.description='" + project.getDescription() + "' " +
                            " WHERE tasak.projects.idp=" + project.getIdp());
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void deleteProject(Project project) {
        deleteProject(project.getIdp());
    }

    public void deleteProject(int idp) {
        try {
            Connection con = DBConnect.getConnection();
            con.createStatement().executeUpdate(
                    "DELETE FROM users_has_projects WHERE users_has_projects.projects_idp = " + idp);


            con.createStatement().executeUpdate(
                    "DELETE FROM task WHERE task.project_idp = " + idp);

            con.createStatement().executeUpdate(
                    "DELETE FROM projects WHERE projects.idp = " + idp);


        } catch (SQLException ec) {
            ec.printStackTrace();
        }

    }

    public List<LoginBean> getProjectUserList(int idp) {
        List<LoginBean> projectUserList = new ArrayList<>();

        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement pstmt = con.prepareStatement("SELECT users_idu, firstName, lastName, uname FROM tasak.users INNER JOIN tasak.users_has_projects  ON  tasak.users.idu = tasak.users_has_projects.users_idu WHERE  tasak.users_has_projects.projects_idp = ?");
            pstmt.setInt(1, idp);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                LoginBean user = new LoginBean();
                user.setLastName(rs.getString("lastName"));
                user.setIdu(rs.getInt("users_idu"));
                user.setUserName(rs.getString("uname"));
                user.setFirstName(rs.getString("firstName"));
                user.setIdp(idp);
                projectUserList.add(user);
            }

        } catch (SQLException ec) {
            ec.printStackTrace();
        }

        return projectUserList;  //To change body of created methods use File | Settings | File Templates.
    }
    public List<LoginBean> getNotInProjectUserList(int idp) {
        List<LoginBean> projectUserList = new ArrayList<>();

        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement pstmt = con.prepareStatement("SELECT * from tasak.users  WHERE tasak.users.idu NOT IN (SELECT tasak.users_has_projects.users_idu from tasak.users_has_projects where tasak.users_has_projects.projects_idp = ?)");
            pstmt.setInt(1, idp);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                LoginBean user = new LoginBean();
                user.setLastName(rs.getString("lastName"));
                user.setIdu(rs.getInt("idu"));
                user.setUserName(rs.getString("uname"));
                user.setFirstName(rs.getString("firstName"));
                user.setIdp(idp);
                projectUserList.add(user);
            }

        } catch (SQLException ec) {
            ec.printStackTrace();
        }

        return projectUserList;  //To change body of created methods use File | Settings | File Templates.
    }

    public void removeUser(int idu, int idp) {
        try {
            Connection con = DBConnect.getConnection();
            con.createStatement().executeUpdate(
                    "DELETE FROM users_has_projects WHERE users_idu=" + idu + " AND projects_idp=" + idp);
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void addUser(int idu, int idp) {
        try {
            Connection con = DBConnect.getConnection();
            PreparedStatement pstmt = con.prepareStatement(
                    "INSERT INTO users_has_projects(users_idu, projects_idp) VALUES(?,?)");
            pstmt.setInt(1, idu);
            pstmt.setInt(2, idp);
            pstmt.executeUpdate();

        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }
}

