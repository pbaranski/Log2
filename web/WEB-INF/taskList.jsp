<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<div>
    <h1 style="text-align:center;">Task Manager</h1>
    <h4 style="text-align:center;">Hello ${currentSessionUser.username} , Project: ${projectName}</h4>
</div>
<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input class="btn" type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
</div>
<div style="width: 50%; margin: 0 auto;">
    <div>
        <input class="btn" type="submit" value="Add new task"
               ONCLICK="window.location.href='taskInsert.og?idp=${idp}&idt=${task.idt}'"/><br/>
    </div>
    <div>
        <table class="table table-striped">
            <tr>
                <th>Project</th>
                <th>Name</th>
                <th>Priority</th>
                <th>Time to spend</th>
                <th>Description</th>
                <th>User id</th><th></th><th></th>
            </tr>
            <c:forEach items='${taskList}' var='task'>
                <tr>
                    <td>${task.projectId}</td>
                    <td>${task.name}</td>
                    <td>${task.priority}</td>
                    <td>${task.timeToDo}</td>
                    <td>${task.description}</td>
                    <td>${task.userId}</td>
                    <td><input class="btn btn-warning" type="submit" value="edit"
                               ONCLICK="window.location.href='taskEdit.og?idp=${idp}&idt=${task.idt}'"/></td>
                    <td><input class="btn btn-danger" type="submit" value="delete"
                               ONCLICK="window.location.href='taskDel.og?idp=${idp}&idt=${task.idt}'"/></td>
                </tr>
            </c:forEach>

        </table>
    </div>

    <div>
        <c:if test='${page > 1}'>
            <input class="btn" type="submit" value="<<" ONCLICK="window.location.href='taskList.og?idp=${idp}&page=${page-1}'"/>
        </c:if>

        <c:forEach var='p' begin='1' end="${numOfPages}">
            <c:if test="${p==page}">
                <td><input class="btn btn-info" type="submit" style="color: #ffffff" value='${p}'
                           ONCLICK="window.location.href='taskList.og?idp=${idp}&page=${p}'"/></td>
            </c:if>
            <c:if test="${p!=page}">
                <td><input class="btn" type="submit" value='${p}'
                           ONCLICK="window.location.href='taskList.og?idp=${idp}&page=${p}'"/></td>
            </c:if>

        </c:forEach>

        <c:if test='${hasNext == "true" }'>
            <input class="btn" type="submit" value=">>" ONCLICK="window.location.href='taskList.og?idp=${idp}&page=${page+1}'"/>
        </c:if>
    </div>
</div>
</body>
</html>