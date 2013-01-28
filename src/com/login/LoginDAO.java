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
        //nie string tylko prepared query czy jakos tak!!!! bo Ci ktos moze wstrzyknac do username np: ( kamil AND 1=1) i co zrobisz?
        String searchQuery = "select * from users where uname='" + username + "' AND password='" + password + "'";
        // poza ja bym dal select password from users where uname = username
        // a potem if (password = haslo pobrane z bazy)
        // na cholere sie laczysz z baza jak w metodzie getConnection samo sprawdza i sie laczy.
        if(!DBConnect.isConnected()){
            // to ma byc w klasie DBConnect wczytane z configa 
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
            // niepotrzebna linia 
            boolean userExists = rs.next();
            // ma byc if (rs.next());
            if (!userExists)
            {

               String errorLogin  = "Username/Password entered is Incorrect or User does not Exists.";
                System.out.println(errorLogin);
                bean.setValid(false);

            }
            // robisz elsifa jakby bool mial 3 wartosc wiadomo ze jak nie jest false to jest true
            else if (userExists)
            {
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                System.out.println("Welcome " + firstName);
                bean.setFirstName(firstName);
                bean.setLastName(lastName);
                bean.setValid(true);
            }

        }
        catch (Exception ex)
        {
            System.out.println("Log In failed: An Exception has occurred! " + ex);
            // jak wiesz ze masz blad to nie zwracaj tego beana tylko null
        }
        return bean;
    }
}
