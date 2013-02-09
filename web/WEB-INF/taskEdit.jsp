<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">Task list</h1>

    <h2 style="text-align:center;">Hello ${currentSessionUser.username}</h2>

    <h2 style="text-align:center;">Project: ${projectName}</h2>

    <h3 style="text-align:center;">Wind of change - edit some task.</h3>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input type="submit" value="Go back to TasList" ONCLICK="window.location.href='/taskList.og'"/>
</div>
<form name="actionForm4" action="taskEditSave.og" onsubmit="return validateForm3()">
    <table>
        <tr>
            <td>

                <input type="hidden" name="idt" value="${task.idt}">

                name: <input type="text" name="name" value="${task.name}"><br/>
            </td>
            <td id="errorName" style="display:none; color: #FF00FF">wrong input format</td>
        </tr>
        <tr>
            <td>
                priority: <input type="text" name="priority" value="${task.priority}"><br/>
            </td>
            <td id="errorPrior" style="display:none; color: #FF00FF">wrong input format</td>
        </tr>
        <tr>
            <td>
                timeToDo: <input type="text" name="timeToDo" value="${task.timeToDo}"><br/>
            </td>
            <td id="errorTimeT" style="display:none; color: #FF00FF">wrong input format</td>
        </tr>
        <tr>
            <td>
                description: <input type="text" name="description" value="${task.description}"><br/>
            </td>
            <td id="errorDesc" style="display:none; color: #FF00FF">wrong input format</td>
        </tr>
        <tr>
            <td>
                <c:if test='${isAdmin != null}'>
                projectId: <input type="text" name="projectId" value="${task.projectId}"><br/>
            </td>
            <td id="errorProjI" style="display:none; color: #FF00FF">wrong input format</td>
        </tr>
        <tr>
            <td>
                userId: <input type="text" name="userId" value="${task.userId}"><br/>
            </td>
            <td id="errorUserI" style="display:none; color: #FF00FF">wrong input format</td>
        </tr>
        <tr>
            <td>
                </c:if>
                <input type="submit" value="Submit"/>
        </tr>
    </table>
</form>
</form>

</body>
<script>
    function validateForm3() {
        var result = true;
        var letterNumber = /^[0-9a-zA-Z. ]+$/;
        var numbers = /^[0-9]+$/;
        var numbersD = /^[0-9.]+$/;
        var name = document.forms["actionForm4"]["name"].value;
        var desc = document.forms["actionForm4"]["description"].value;
        var timeT = document.forms["actionForm4"]["timeToDo"].value;
        var prior = document.forms["actionForm4"]["priority"].value;
        var projI = document.forms["actionForm4"]["projectId"].value;
        var userI = document.forms["actionForm4"]["userId"].value;

        if (!name.match(letterNumber) || name.length > 20) {
            document.getElementById('errorName').style.display = "block";
            result = false;
        } else document.getElementById('errorName').style.display = "none";

        if (!desc.match(letterNumber) || desc.length > 120) {
            document.getElementById('errorDesc').style.display = "block";
            result = false;
        } else document.getElementById('errorDesc').style.display = "none";

        if (!timeT.match(numbersD) || timeT.length > 20) {
            document.getElementById('errorTimeT').style.display = "block";
            result = false;
        } else document.getElementById('errorTimeT').style.display = "none";

        if (!prior.match(letterNumber) || prior.length > 120) {
            document.getElementById('errorPrior').style.display = "block";
            result = false;
        } else document.getElementById('errorPrior').style.display = "none";

        if (!projI.match(letterNumber) || projI.length > 5) {
            document.getElementById('errorProjI').style.display = "block";
            result = false;
        } else document.getElementById('errorProjI').style.display = "none";

        if (!userI.match(letterNumber) || userI.length > 5) {
            document.getElementById('errorUserI').style.display = "block";
            result = false;
        } else document.getElementById('errorUserI').style.display = "none";

        return result;
    }
</script>
</html>