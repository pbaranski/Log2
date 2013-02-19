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
            PreparedStatement pstmt = con.prepareStatement("SELECT * from tasak.users");
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

    public List distinctProjectsUsers(int idUser, int idAdmin){
        List<Integer> projects = new ArrayList<>();
        try (
                PreparedStatement pstmt = con.prepareStatement("SELECT tasak.users_has_projects.users_idu, tasak.users_has_projects.projects_idp FROM tasak.users_has_projects WHERE tasak.users_has_projects.users_idu = ? AND tasak.users_has_projects.projects_idp NOT IN (SELECT tasak.users_has_projects.projects_idp FROM tasak.users_has_projects WHERE tasak.users_has_projects.users_idu = ?)")) {
            pstmt.setInt(1, idUser);
            pstmt.setInt(2, idAdmin);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()){
                projects.add(rs.getInt("projects_idp"));
            }
        } catch (SQLException ec){
            ec.printStackTrace();
        }
        System.out.println(projects);
        return projects;
    }

    public void deleteUserProjects(int idUser) {
        try (PreparedStatement pstmt = con.prepareStatement("DELETE FROM tasak.users_has_projects WHERE tasak.users_has_projects.users_idu = ?")) {
            pstmt.setInt(1, idUser);
            pstmt.executeUpdate();
        } catch (SQLException ec){
            ec.printStackTrace();
        }
    }

    public void updateUserTasks(int idUser, int idAdmin) {
        try (PreparedStatement pstmt = con.prepareStatement("UPDATE tasak.task SET tasak.task.user_idu = ? WHERE tasak.task.user_idu = ?")) {
            pstmt.setInt(1, idUser);
            pstmt.setInt(2, idAdmin);
            pstmt.executeUpdate();
        } catch (SQLException ec){
            ec.printStackTrace();
        }
    }

    public void deleteUser(int idUser, int isAdmin){
        updateUserTasks(idUser, isAdmin);
        deleteUserProjects(idUser);
        try (PreparedStatement pstmt = con.prepareStatement("DELETE FROM tasak.users WHERE tasak.users.idu = ?")) {
            pstmt.setInt(1, idUser);
            pstmt.executeUpdate();
        } catch (SQLException ec){
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
}