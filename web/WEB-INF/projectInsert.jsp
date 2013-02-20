<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body>
<div>
    <h1 style="text-align:center;">Task list</h1>
    <h4 style="text-align:center;">Hello ${currentSessionUser.username}, Start new Project</h4>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input class="btn" type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
</div>
<div style="width: 50%; margin: 0 auto;">
    <div>

        <form accept-charset="ISO-8859-15" name="actionForm3" action="projectInsertSave.pro" onsubmit="return validateForm()" method="post">
            <table class="table">
                <tr>
                    <td>Name:</td>
                    <td><input type="text" name="name"></td>
                    <td id="errorName" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>Description:</td>
                    <td><input type="text" name="description"></td>
                    <td id="errorDesc" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>User:</td>
                    <td><select name="user_idu">
                        <c:forEach items='${notInProjectUserList}' var='user'>
                            <option value="${user.idu}">${user.idu}, ${user.username}</option>
                        </c:forEach>
                    </select></td>
                </tr>
                <td id="errorUser" style="display:none; color: #FF00FF">wrong input format</td>
                </tr>
                <tr>
                    <td>

                        <input class="btn  btn-info" type="submit" value="Submit"/>
                    <td>
                </tr>
            </table>
        </form>
    </div>


    <div class="muted">Users details</div>
    <table class="table-striped">
        <tr>
            <th>ID</th><th></th>
            <th>Nick</th><th></th>
            <th>Name</th><th></th>
            <th>Surname</th><th></th>
        </tr>
        <c:forEach items='${notInProjectUserList}' var='user'>
            <tr>
                <td>${user.idu}</td>
                <td></td>
                <td>${user.username}</td>
                <td></td>
                <td>${user.firstName}</td>
                <td></td>
                <td>${user.lastName}</td>
                <td></td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
<script>
    function validateForm() {
        var result = true;
        var letterNumber = /^[0-9a-zA-Z ęśążółćżń.,. ]+$/;
        var numbers = /^[0-9]+$/;
        var name = document.forms["actionForm3"]["name"].value;
        var desc = document.forms["actionForm3"]["description"].value;
        var user = document.forms["actionForm3"]["user_idu"].value;

        if (!name.match(letterNumber) || name.length > 20) {
            document.getElementById('errorName').style.display = "block";
            result = false;
        } else document.getElementById('errorName').style.display = "none";

        if (!desc.match(letterNumber) || desc.length > 120) {
            document.getElementById('errorDesc').style.display = "block";
            result = false;
        } else document.getElementById('errorDesc').style.display = "none";

        if (!user.match(numbers) || user.length > 3) {
            document.getElementById('errorUser').style.display = "block";
            result = false;
        } else document.getElementById('errorUser').style.display = "none";

        return result;
    }
</script>
</html>