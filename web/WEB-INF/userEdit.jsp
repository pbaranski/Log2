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
    <form accept-charset="ISO-8859-15" name="actionForm6" action="userEditSave.user"
          onsubmit="return validateForm6(true)" method="POST" method="post">
        <input type="hidden" name="idu" value="${user.idu}">
        <table class="table">
            <tr>
                <td>User first name:</td>
                <td><input type="text" name="firstName" value="${user.firstName}"><br/></td>
                <td id="errorFirstName" style="display:none; color: #FF00FF">wrong input format</td>
            </tr>
            <tr>
                <td>User last name:</td>
                <td><input type="text" name="lastName" value="${user.lastName}"><br/></td>
                <td id="errorLastName" style="display:none; color: #FF00FF">wrong input format</td>
            </tr>
            <tr>
                <td>Old password:</td>
                <td><input type="text" name="oldPassword"><br/></td>
                <td id="errorOldPassword" style="display:none; color: #FF00FF">wrong input format</td>
                <td id="errorPassword2" style="color: red">${errorMsg}</td>
            </tr>
            <tr>
                <td>New password:</td>
                <td><input type="text" name="newPassword"><br/></td>
                <td id="errorNewPassword" style="display:none; color: #FF00FF">wrong input format</td>
            </tr>
            <tr>
                <td>Repeat new password:</td>
                <td><input type="text" name="newPassword2"><br/></td>
                <td id="errorNewPassword2" style="display:none; color: #FF00FF">wrong input format</td>
                <td id="errorNewPassword3" style="display:none; color: #FF00FF">password doesn't match</td>
            </tr>


            <c:if test='${currentSessionUser.isAdmin==true}'>
                <tr>
                    <td>Username:</td>
                    <td><input type="text" name="uname" value="${user.username}"><br/></td>
                    <td id="errorUname" style="display:none; color: #FF00FF">wrong input format</td>
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
    function validateForm6(admin) {
        var result = true;
        var letterNumber = /^[0-9a-zA-Z ęśążółćżń.,. ]+$/;
        var numbers = /^[0-9]+$/;
        var numbersD = /^[0-9.]+$/;
        var firstName = document.forms["actionForm6"]["firstName"].value;
        var lastName = document.forms["actionForm6"]["lastName"].value;
        var oldPassword = document.forms["actionForm6"]["oldPassword"].value;
        var newPassword = document.forms["actionForm6"]["newPassword"].value;
        var newPassword2 = document.forms["actionForm6"]["newPassword2"].value;


        if (!firstName.match(letterNumber) || firstName.length > 20) {
            document.getElementById('errorFirstName').style.display = "block";
            result = false;
        } else document.getElementById('errorFirstName').style.display = "none";

        if (!lastName.match(letterNumber) || lastName.length > 120) {
            document.getElementById('errorLastName').style.display = "block";
            result = false;
        } else document.getElementById('errorLastName').style.display = "none";

        if (!oldPassword.match(letterNumber) || oldPassword.length > 20) {
            document.getElementById('errorOldPassword').style.display = "block";
            result = false;
        } else document.getElementById('errorOldPassword').style.display = "none";
        if (newPassword === newPassword2) {
            document.getElementById('errorNewPassword3').style.display = "none";
            if (!newPassword.match(letterNumber) || newPassword.length > 120) {
                document.getElementById('errorNewPassword').style.display = "block";
                result = false;
            } else document.getElementById('errorNewPassword').style.display = "none";
            if (!newPassword2.match(letterNumber) || newPassword2.length > 120) {
                document.getElementById('errorNewPassword2').style.display = "block";
                result = false;
            } else document.getElementById('errorNewPassword2').style.display = "none";
        } else {
            document.getElementById('errorNewPassword').style.display = "none";
            document.getElementById('errorNewPassword2').style.display = "none";
            document.getElementById('errorNewPassword3').style.display = "block";
            result = false;
        }

        if (admin) {
            var uname = document.forms["actionForm6"]["uname"].value;
            if (!uname.match(letterNumber) || uname.length > 5) {
                document.getElementById('errorUname').style.display = "block";
                result = false;
            } else document.getElementById('errorUname').style.display = "none";

        }
        return result;
    }
</script>
</html>