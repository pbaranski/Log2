<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">Task list</h1>
    <h2 style="text-align:center;">Hello  ${currentSessionUser.username}</h2>
    <h2 style="text-align:center;">Project: ${projectName}</h2>
    <h3 style="text-align:center;">Wind of change - edit some task.</h3>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input type="submit" value="Go back to TasList" ONCLICK="window.location.href='/taskList.og'"/>
</div>
<form action="taskEditSave.og">
<input type="hidden" name="idt" value="${task.idt}">
name: <input type="text" name="name" value="${task.name}"><br/>
priority: <input type="text" name="priority" value="${task.priority}"><br/>
timeToDo: <input type="text" name="timeToDo" value="${task.timeToDo}"><br/>
description: <input type="text" name="description" value="${task.description}"><br/>

        <c:if test='${isAdmin != null}'>
    projectId: <input type="text" name="projectId" value="${task.projectId}"><br/>
userId: <input type="text" name="userId" value="${task.userId}"><br/>
        </c:if>

<input type="submit"/>
</form>

</body>
</html>