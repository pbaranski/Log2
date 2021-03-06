<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">Task Manager</h1>
    <h4 style="text-align:center;">Hello ${currentSessionUser.username}, Edit: ${project.name}</h4>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input class="btn" type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
</div>
<div style="width: 50%; margin: 0 auto;">
<div>
    <c:if test='${project != null}'>
    <form accept-charset="ISO-8859-15" name="actionForm2" action="projectEditSave.pro" onsubmit="return validateForm()" method="POST" method="post">
        <input type="hidden" name="idp" value="${project.idp}">
        <table class="table">
            <tr>
                <td>Project name:</td>
                <td><input type="text" name="name" value="${project.name}"><br/></td>
                <td id="errorName"  style="display:none; color: #FF00FF" >wrong input format</td>
            </tr>
            <tr>
                <td>Project description:</td>
                <td><input type="text" name="description" value="${project.description}"><br/></td>
                <td id="errorDesc"  style="display:none; color: #FF00FF" >wrong input format</td>
            </tr>
            <tr>
                <td></td>
                <td><input class="btn btn-info" type="submit" value="Update"/></td>
            </tr>
        </table>

    </form>
    <div>
        <table class="table" >
            <tr>
                <th>Id</th>
                <th>Nick</th>
                <th>Name</th>
                <th>Surname</th>
                <th></th>
            </tr>
            <c:forEach items='${projectUserList}' var='user'>
                <tr>
                    <td>${user.idu}</td>
                    <td>${user.username}</td>
                    <td>${user.firstName}</td>
                    <td>${user.lastName}</td>
                    <td><input class="btn btn-warning" type="submit" value="remove" ONCLICK="window.location.href='projectRemoveUser.pro?idu=${user.idu}&idp=${project.idp}'"/>
                    </td>
                </tr>
            </c:forEach>


            <c:forEach items='${notInProjectUserList}' var='user'>
                <form accept-charset="ISO-8859-15" action="addUserToProject.pro">
                    <tr>
                        <td>${user.idu}</td>
                        <td>${user.username}</td>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>
                            <input type="hidden" name="idp" value="${project.idp}">
                            <input type="hidden" name="idu" value="${user.idu}">
                            <input class="btn btn-success" type="submit" value="add">

                        </td>
                    </tr>
                </form>
            </c:forEach>
            </table>
        </div>


    </c:if>
</div>
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