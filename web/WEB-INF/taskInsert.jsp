<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">Task list</h1>

    <h2 style="text-align:center;">Hello ${currentSessionUser.username}</h2>
    <h2 style="text-align:center;"> Project: ${projectName}</h2>
    <h3 style="text-align:center;"> Let's make more work - add new task!</h3>

</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input type="submit" value="Go back to TasList" ONCLICK="window.location.href='/taskList.og'"/>
</div>
<div>
    <form action="taskInsertSave.og">
        name: <input type="text" name="name"><br/>
        priority: <input type="text" name="priority"><br/>
        timeToDo: <input type="text" name="timeToDo"><br/>
        description: <input type="text" name="description"><br/>
        <c:if test='${isAdmin != null}'>
            project id: <input type="text" name="projectId" value="${idp}"><br/>
            user id: <input type="text" name="userId" value=${idu}><br/>
        </c:if>
        <input type="submit"/>
    </form>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
</body>
</html>