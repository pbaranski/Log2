package com.login;

import com.login.LoginBean;
import db.DBConnect;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class LoginDAO
{
    static Connection con = null;
    static ResultSet rs = null;
    public static LoginBean login(LoginBean bean)
    {
        Statement stmt = null;
        String username = bean.getUsername();
        String password = bean.getPassword();
        String searchQuery = "select * from users where uname='" + username + "' AND password='" + password + "'";

        if(!DBConnect.isConnected()){
            DBConnect.setLocation("jdbc:mysql://127.0.0.1/tasak");
            DBConnect.setLogin("root");
            DBConnect.setPassword("");
            DBConnect.connect();
        }


        try
        {
//connecting to the DB
            con = DBConnect.getConnection();
            stmt= con.createStatement();
            rs = stmt.executeQuery(searchQuery);
            boolean userExists = rs.next();

            if (!userExists)
            {

               String errorLogin  = "Username/Password entered is Incorrect or User does not Exists.";
                System.out.println(errorLogin);
                bean.setValid(false);

            }
            else if (userExists)
            {
                int idu =  rs.getInt("idu");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                System.out.println("Welcome " + firstName);
                bean.setIdu(idu);
                bean.setFirstName(firstName);
                bean.setLastName(lastName);
                bean.setValid(true);
            }

        }
        catch (Exception ex)
        {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
        }
        return bean;
    }
}