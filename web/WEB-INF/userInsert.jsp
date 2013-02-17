<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">User list</h1>
    <h4 style="text-align:center;">Hello ${currentSessionUser.username}</h4>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input class="btn" type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
</div>
<div style="width: 50%; margin: 0 auto;">
<div>
    <c:if test='${isAdmin == true}'>
    <form name="actionForm7" action="saveAddUser.user" onsubmit="return validateForm3(true)" method="POST">
            <table class="table">
                <tr>
                    <th>Details</th>
                    <th>Insert Data</th>
                    <th></th>
                </tr>
                <tr>
                    <td>First name :</td>
                    <td>
                        <input type="text" name="userFirstName"><br/>
                    </td>
                    <td id="errorFName" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>Last name :</td>
                    <td>
                        <input type="text" name="userLastName"><br/>
                    </td>
                    <td id="errorLName" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>Username :</td>
                    <td>
                        <input type="text" name="userName"><br/>
                    </td>
                    <td id="errorName" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>Password :</td>
                    <td>
                        <input type="text" name="userPassword"><br/>
                    </td>
                    <td id="errorPassword" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>

                <tr>
                    <td>Is Admin:</td>
                    <td>
                        <select name="userIsAdmin">
                            <option value="true">true</option>
                            <option value="false">false</option>
                        </select>


                        <br/>
                    </td>
                    <td id="errorPrior" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td></td>
                    <td><input class="btn btn-info" type="submit" value="Update"/></td>
                </tr>
            </table>
        </form>
   </c:if>
</div>
</div>

</body>
<script>

    function validateForm3(admin) {
        var admin = admin;
        var result = true;
        var letterNumber = /^[0-9a-zA-Z. ]+$/;
        var numbers = /^[0-9]+$/;
        var numbersD = /^[0-9.]+$/;
        var firstName = document.forms["actionForm7"]["userFirstName"].value;
        var lastName = document.forms["actionForm7"]["userLastName"].value;
        var uname = document.forms["actionForm7"]["userName"].value;
        var password = document.forms["actionForm7"]["userPassword"].value;

        if (!firstName.match(letterNumber) || firstName.length > 20) {
            document.getElementById('errorFName').style.display = "block";
            result = false;
        } else document.getElementById('errorFName').style.display = "none";

        if (!lastName.match(letterNumber) || lastName.length > 50) {
            document.getElementById('errorLName').style.display = "block";
            result = false;
        } else document.getElementById('errorLName').style.display = "none";

        if (!uname.match(letterNumber) || uname.length > 20) {
            document.getElementById('errorName').style.display = "block";
            result = false;
        } else document.getElementById('errorName').style.display = "none";

        if (!password.match(letterNumber) || pasword.length > 12 || password.length < 4 ) {
            document.getElementById('errorPassword').style.display = "block";
            result = false;
        } else document.getElementById('errorPassword').style.display = "none";


        return result;
    }
</script>
</html>