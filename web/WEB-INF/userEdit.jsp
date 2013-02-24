<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">Task Manager</h1>
    <h4 style="text-align:center;">Hello ${currentSessionUser.username}, Edit: ${user.username}</h4>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input class="btn" type="submit" value="Go back to users" ONCLICK="window.location.href='/userList.user'"/>
</div>
<div style="width: 50%; margin: 0 auto;">

    <c:if test='${user != null}'>
    <form accept-charset="ISO-8859-15" name="actionForm2" action="userEditSave.user" onsubmit="return validateForm()" method="POST" method="post">
        <input type="hidden" name="idu" value="${user.idu}">
        <table class="table">
            <tr>
                <td>User first name:</td>
                <td><input type="text" name="firstName" value="${user.firstName}"><br/></td>
                <td id="errorFirstName"  style="display:none; color: #FF00FF" >wrong input format</td>
            </tr>
            <tr>
                <td>User last name:</td>
                <td><input type="text" name="lastName" value="${user.lastName}"><br/></td>
                <td id="errorLastName"  style="display:none; color: #FF00FF" >wrong input format</td>
            </tr>
            <tr>
                <td>Old password:</td>
                <td><input type="text" name="oldPassword" ><br/></td>
                <td id="errorPassword"  style="display:none; color: #FF00FF" >wrong input format</td>
                <td id="errorPassword2" style="color: red">${errorMsg}</td>
            </tr>
            <tr>
                <td>New password:</td>
                <td><input type="text" name="newPassword"><br/></td>
                <td id="errorNewPassword"  style="display:none; color: #FF00FF" >wrong input format</td>
            </tr>
            <tr>
                <td>Repeat new password:</td>
                <td><input type="text" name="newPassword2"><br/></td>
                <td id="errorNewPassword2"  style="display:none; color: #FF00FF" >wrong input format</td>
            </tr>


            <c:if test='${currentSessionUser.isAdmin==true}'>
                <tr>
                    <td>Username:</td>
                    <td><input type="text" name="uname" value="${user.username}"><br/></td>
                    <td id="errorDesc"  style="display:none; color: #FF00FF" >wrong input format</td>
                </tr>
                <tr>
                    <td>Is Admin:</td>
                    <td>
                        <select name="userIsAdmin">
                            <c:if test='${user.isAdmin==true}'>
                            <option value="true">true</option>
                            <option value="false">false</option>
                            </c:if>
                            <c:if test='${user.isAdmin==false}'>
                                <option value="true">false</option>
                                <option value="false">true</option>
                            </c:if>
                        </select>


                        <br/>
                    </td>
                    <td id="errorPrior" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
            </c:if>

            <c:if test='${currentSessionUser.isAdmin==false}'>
                <input type="hidden" name="uname" value="${user.username}">
                <input type="hidden" name="isAdmin" value="${user.isAdmin}">

            </c:if>
            <tr>
                <td></td>
                <td><input class="btn btn-info" type="submit" value="Update"/></td>
            </tr>
        </table>

</c:if>
</div>
</body>
<script>
    function validateForm()
    {
        var result = true;
        var letterNumber = /^[0-9a-zA-Z ęśążółćżń.,. ]+$/;
        var name=document.forms["actionForm2"]["name"].value;
        var desc=document.forms["actionForm2"]["description"].value;

        if (!name.match(letterNumber) || name.length>20 )
        {
            document.getElementById('errorName').style.display = "block";
            result =  false;
        } else document.getElementById('errorName').style.display = "none";

        if (!desc.match(letterNumber)|| desc.length>120 )
        {
            document.getElementById('errorDesc').style.display = "block";
            result = false;
        } else document.getElementById('errorDesc').style.display = "none";

        return result;
    }
</script>
</html>