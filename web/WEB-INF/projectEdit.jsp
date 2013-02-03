<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<form action="projectEditSave.pro">
    <input type="hidden" name="idp" value="${project.idp}">
    name: <input type="text" name="name" value="${project.name}"><br/>
    description: <input type="text" name="description" value="${project.description}"><br/>
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

<c:if test='${projectUserList != null}'>
    <input type="submit" value="Add user to project"
           ONCLICK="window.location.href='projectInsertUser.pro?idp=${project.idp}'"/>
</c:if>
<div>
    <jsp:include page="../logout.jsp" />
</div>
</body>
</html>