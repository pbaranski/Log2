<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">Task list</h1>
    <h2 style="text-align:center;">Hello ${currentSessionUser.username} in project: ${project.name}</h2>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
</div>
<div>
    <c:if test='${project != null}'>
    <form action="projectEditSave.pro">
        <input type="hidden" name="idp" value="${project.idp}">
        <table>
            <tr>
                <td>Project name:</td>
                <td><input type="text" name="name" value="${project.name}"><br/></td>
            </tr>
            <tr>
                <td>Project description:</td>
                <td><input type="text" name="description" value="${project.description}"><br/></td>
            </tr>
        </table>
        <input type="submit" value="Update"/>
    </form>
    <div>
        <table>
            <tr>
                <th>Id</th>
                <th>Nick</th>
                <th>Name</th>
                <th>Surname</th>
            </tr>
            <c:forEach items='${projectUserList}' var='user'>
                <tr>
                    <td>${user.idu}</td>
                    <td>${user.username}</td>
                    <td>${user.firstName}</td>
                    <td>${user.lastName}</td>
                    <td><input type="submit" value="remove"
                               ONCLICK="window.location.href='projectRemoveUser.pro?idu=${user.idu}&idp=${project.idp}'"/>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</div>
<div>
    <form action="addUserToProject.pro">
        <input type="hidden" name="idp" value="${project.idp}">
        User Id: <input type="text" name="idu"><br/>
        <input type="submit" value="Add user to project"/>
    </form>
    </c:if>
</div>
</body>
</html>