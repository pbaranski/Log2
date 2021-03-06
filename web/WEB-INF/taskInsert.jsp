<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">Task Manager</h1>

    <h4 style="text-align:center;">Hello ${currentSessionUser.username} , Project: ${projectName}, New Task</h4>

</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input type="submit" value="Go back to TasList" ONCLICK="window.location.href='/taskList.og'"/>
</div>
<div style="width: 50%; margin: 0 auto;">
<div>
    <c:if test='${isAdmin != null}'>
    <form accept-charset="ISO-8859-15" name="actionForm4" action="taskInsertSave.og" onsubmit="return validateForm3(true)" method="post">
        </c:if>
        <c:if test='${isAdmin == null}'>
        <form accept-charset="ISO-8859-15" name="actionForm4" action="taskInsertSave.og" onsubmit="return validateForm3(false)" method="post">
            </c:if>

            <table class="table">
                <tr>
                    <th>Details</th>
                    <th>Insert Data</th>
                    <th></th>
                </tr>
                <tr>
                    <td>Name:</td>
                    <td>
                        <input type="text" name="name"><br/>
                    </td>
                    <td id="errorName" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>Priority:</td>
                    <td>
                        <select name="priority">
                            <option value="High">High</option>
                            <option value="Mid">Mid</option>
                            <option value="Low">Low</option>
                        </select>


                        <br/>
                    </td>
                    <td id="errorPrior" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>Time to do in hours:</td>
                    <td>
                        <input type="text" name="timeToDo"><br/>
                    </td>
                    <td id="errorTimeT" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>Description:</td>
                    <td>
                        <input type="text" name="description"><br/>
                    </td>
                    <td id="errorDesc" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <c:if test='${isAdmin != null}'>


                    <td>Project id:</td>
                    <td>
                        <input type="text" name="projectId" value="${idp}"><br/>
                    </td>
                    <td id="errorProjI" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>User id:</td>
                    <td>
                        <input type="text" name="userId" value=${idu}><br/>
                    </td>
                    <td id="errorUserI" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    </c:if>
                    <td>
                        <input class="btn btn-info" type="submit" value="Submit"/></td>
                </tr>
            </table>
        </form>
</div>
</div>

</body>
<script>

    function validateForm3(admin) {
        var admin = admin;
        var result = true;
        var letterNumber = /^[0-9a-zA-Z ęśążółćżń.,. ]+$/;
        var numbers = /^[0-9]+$/;
        var numbersD = /^[0-9.]+$/;
        var name = document.forms["actionForm4"]["name"].value;
        var desc = document.forms["actionForm4"]["description"].value;
        var timeT = document.forms["actionForm4"]["timeToDo"].value;
        var prior = document.forms["actionForm4"]["priority"].value;

        if (!name.match(letterNumber) || name.length > 20) {
            document.getElementById('errorName').style.display = "block";
            result = false;
        } else document.getElementById('errorName').style.display = "none";

        if (!desc.match(letterNumber) || desc.length > 50) {
            document.getElementById('errorDesc').style.display = "block";
            result = false;
        } else document.getElementById('errorDesc').style.display = "none";

        if (!timeT.match(numbersD) || timeT.length > 20) {
            document.getElementById('errorTimeT').style.display = "block";
            result = false;
        } else document.getElementById('errorTimeT').style.display = "none";

        if (!prior.match(letterNumber) || prior.length > 6) {
            document.getElementById('errorPrior').style.display = "block";
            result = false;
        } else document.getElementById('errorPrior').style.display = "none";

        if (admin) {

            var projI = document.forms["actionForm4"]["projectId"].value;
            var userI = document.forms["actionForm4"]["userId"].value;

            if (!projI.match(letterNumber) || projI.length > 5) {
                document.getElementById('errorProjI').style.display = "block";
                result = false;
            } else document.getElementById('errorProjI').style.display = "none";

            if (!userI.match(letterNumber) || userI.length > 5) {
                document.getElementById('errorUserI').style.display = "block";
                result = false;
            } else document.getElementById('errorUserI').style.display = "none";
        }
        return result;
    }
</script>
</html>