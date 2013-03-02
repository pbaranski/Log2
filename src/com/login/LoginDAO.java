package com.login;

import db.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDAO
{
    static Connection con = null;
    static ResultSet rs = null;
    public static LoginBean login(LoginBean bean)
    {

        String username = bean.getUsername();
        String password = bean.getPassword();


        DBConnect.connect();

        try
        {
            Connection con = DBConnect.getConnection();

           PreparedStatement pstmt = con.prepareStatement("select * from users where uname = ? AND password = ?");
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (!rs.next())
            {
                bean.setValid(false);
            }
            else
            {
                int idu =  rs.getInt("idu");
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                Boolean isAdmin = rs.getBoolean("isAdmin");
                System.out.println("Welcome " + firstName);
                bean.setIdu(idu);
                bean.setFirstName(firstName);
                bean.setLastName(lastName);
                bean.setValid(true);
                bean.setIsAdmin(isAdmin);
            }

        }
        catch (Exception ex)
        {
            System.out.println("Log In failed: An Exception has occurred! ");
        }
        return bean;
    }
}