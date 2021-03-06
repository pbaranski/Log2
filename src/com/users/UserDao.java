package com.users;

import com.login.LoginBean;
import com.mysql.jdbc.util.ResultSetUtil;
import db.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    Connection con = DBConnect.getConnection();

    public List<LoginBean> getUserList(int idu, boolean isAdmin) {
        List<LoginBean> userList = new ArrayList<>();


        try {
            PreparedStatement pstmt;

           if(isAdmin)pstmt = con.prepareStatement("SELECT * from tasak.users");
            else{
               pstmt = con.prepareStatement("SELECT * from tasak.users WHERE tasak.users.idu = ?");
               pstmt.setInt(1, idu);
           }
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                LoginBean user = new LoginBean();
                user.setLastName(rs.getString("lastName"));
                user.setIdu(rs.getInt("idu"));
                user.setUserName(rs.getString("uname"));
                user.setFirstName(rs.getString("firstName"));
                user.setIsAdmin(rs.getBoolean("isAdmin"));
                userList.add(user);
            }

        } catch (SQLException ec) {
            ec.printStackTrace();
        }
        return userList;
    }

    public List distinctProjectsUsers(int idUser, int idAdmin) {
        List<Integer> projects = new ArrayList<>();
        try (
                PreparedStatement pstmt = con.prepareStatement("SELECT tasak.users_has_projects.users_idu, tasak.users_has_projects.projects_idp FROM tasak.users_has_projects WHERE tasak.users_has_projects.users_idu = ? AND tasak.users_has_projects.projects_idp NOT IN (SELECT tasak.users_has_projects.projects_idp FROM tasak.users_has_projects WHERE tasak.users_has_projects.users_idu = ?)")) {
            pstmt.setInt(1, idUser);
            pstmt.setInt(2, idAdmin);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                projects.add(rs.getInt("projects_idp"));
            }
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
        System.out.println(projects);
        return projects;
    }

    public void deleteUserProjects(int idUser) {
        try (PreparedStatement pstmt = con.prepareStatement("DELETE FROM tasak.users_has_projects WHERE tasak.users_has_projects.users_idu = ?")) {
            pstmt.setInt(1, idUser);
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void updateUserTasks(int idUser, int idAdmin) {
        try (PreparedStatement pstmt = con.prepareStatement("UPDATE tasak.task SET tasak.task.user_idu = ? WHERE tasak.task.user_idu = ?")) {
            pstmt.setInt(2, idUser);
            pstmt.setInt(1, idAdmin);
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void deleteUser(int idUser, int idAdmin) {
        updateUserTasks(idUser, idAdmin);
        deleteUserProjects(idUser);
        try (PreparedStatement pstmt = con.prepareStatement("DELETE FROM tasak.users WHERE tasak.users.idu = ?")) {
            pstmt.setInt(1, idUser);
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public void saveAddUser(LoginBean userAdd) {
        try {
            PreparedStatement pstmt = con.prepareStatement(
                    "INSERT INTO users(firstName, lastName, uname, password, isAdmin) VALUES(?,?,?,?,?)");
            pstmt.setString(1, userAdd.getFirstName());
            pstmt.setString(2, userAdd.getLastName());
            pstmt.setString(3, userAdd.getUsername());
            pstmt.setString(4, userAdd.getPassword());
            pstmt.setBoolean(5, userAdd.isAdmin());


            pstmt.executeUpdate();

        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }

    public LoginBean getUser(int idu) {
        LoginBean user = new LoginBean();
        try {
            PreparedStatement pstmt = con.prepareStatement("SELECT * FROM users WHERE users.idu = ?");
            pstmt.setInt(1, idu);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                user.setLastName(rs.getString("lastName"));
                user.setIdu(rs.getInt("idu"));
                user.setUserName(rs.getString("uname"));
                user.setFirstName(rs.getString("firstName"));
                user.setIsAdmin(rs.getBoolean("isAdmin"));
            }
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
        return user;
    }

    public boolean comparePassword(String pass, int idu) {
        try {
            PreparedStatement pstmt = con.prepareStatement("SELECT users.password FROM users where users.idu = ? AND users.password = ?");
            pstmt.setInt(1, idu);
            pstmt.setString(2, pass);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateUser(LoginBean userEdit) {
        try {
            PreparedStatement pstmt = con.prepareStatement("update users set uname=?, firstName = ?, lastName = ?, password = ?, isAdmin=? where idu=?");
            pstmt.setString(1, userEdit.getUsername());
            pstmt.setString(2, userEdit.getFirstName());
            pstmt.setString(3, userEdit.getLastName());
            pstmt.setString(4, userEdit.getPassword());
            pstmt.setBoolean(5, userEdit.getIsAdmin());
            pstmt.setInt(6, userEdit.getIdu());
            pstmt.executeUpdate();
        } catch (SQLException ec) {
            ec.printStackTrace();
        }
    }
}