package com.login;

/**
 * Created with IntelliJ IDEA.
 * User: A
 * Date: 05.01.13
 * Time: 20:54
 * To change this template use File | Settings | File Templates.
 */


public class LoginBean {
    private int idu;
    private int idp;
    private String username;
    private String password;
    private String firstName;
    private String lastName;
    private boolean isAdmin;
    public boolean valid;

    public int getIdp() {
        return idp;
    }

    public void setIdp(int idp) {
        this.idp = idp;
    }

    public String getFirstName()
    {
        return firstName;

    }
    public void setFirstName(String newFirstName)
    {
        firstName = newFirstName;
    }
    public String getLastName()
    {
        return lastName;
    }
    public void setLastName(String newLastName)
    {
        lastName = newLastName;
    }
    public String getPassword()
    {
        return password;
    }
    public void setPassword(String newPassword)
    {
        password = newPassword;
    }
    public String getUsername()
    {
        return username;
    }
    public void setUserName(String newUsername)
    {
        username = newUsername;
    }
    public boolean isValid()
    {
        return valid;
    }
    public void setValid(boolean newValid)
    {
        valid = newValid;
    }

    public boolean isAdmin()
    {
        return isAdmin;
    }

    public void setIsAdmin(boolean newAdmin)
    {
        isAdmin = newAdmin;
    }

    public int getIdu() {
        return idu;
    }

    public void setIdu(int idu) {
        this.idu = idu;
    }
}
