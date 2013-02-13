<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<div>
    <h1 style="text-align:center;">Task list</h1>

    <h2 style="text-align:center;">Hello ${currentSessionUser.username} , Project: ${projectName}</h2>

</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
</div>
<div>
    <table>
        <tr>
            <th>Project</th>
            <th>Name</th>
            <th>Priority</th>
            <th>Time to spend</th>
            <th>Description</th>
            <th>User id</th>
        </tr>
        <c:forEach items='${taskList}' var='task'>
            <tr>
                <td>${task.projectId}</td>
                <td>${task.name}</td>
                <td>${task.priority}</td>
                <td>${task.timeToDo}</td>
                <td>${task.description}</td>
                <td>${task.userId}</td>
                <td><input type="submit" value="edit"
                           ONCLICK="window.location.href='taskEdit.og?idp=${idp}&idt=${task.idt}'"/></td>
                <td><input type="submit" value="delete"
                           ONCLICK="window.location.href='taskDel.og?idp=${idp}&idt=${task.idt}'"/></td>
            </tr>
        </c:forEach>

    </table>
</div>
<div>
    <input type="submit" value="Add new task"
           ONCLICK="window.location.href='taskInsert.og?idp=${idp}&idt=${task.idt}'"/>
</div>
<div>
    <c:if test='${hasNext == "true" }'>
        <input type="submit" value="next" ONCLICK="window.location.href='taskList.og?idp=${idp}&page=${page+1}'"/>
    </c:if>

    <c:forEach var='p' begin='1' end="${numOfPages}">
        <c:if test="${p==page}">
            <td><input type="submit" style="color: #dc143c" value='${p}' ONCLICK="window.location.href='taskList.og?idp=${idp}&page=${p}'"/></td>
        </c:if>
        <c:if test="${p!=page}">
            <td><input type="submit" value='${p}' ONCLICK="window.location.href='taskList.og?idp=${idp}&page=${p}'"/></td>
        </c:if>

    </c:forEach>

    <c:if test='${page > 1}'>
        <input type="submit" value="back" ONCLICK="window.location.href='taskList.og?idp=${idp}&page=${page-1}'"/>
    </c:if>
</div>
</body>
</html>