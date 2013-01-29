<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<table>
    <tr>
      <th>Name</th><th>Priority</th><th>Time to spend</th><th>Description</th><th>User id</th>
    </tr>
    <c:forEach items='${taskList}' var='task'>
      <tr>
      <td>${task.name}</td>
      <td>${task.priority}</td>
      <td>${task.timeToDo}</td>
      <td>${task.description}</td>
      <td>${task.projectId}</td>
      <td><input type="submit" value="edit" ONCLICK="window.location.href='taskEdit.og?idt=${task.idt}'"/></td>
      <td><input type="submit" value="delete" ONCLICK="window.location.href='taskDel.og?idt=${task.idt}'"/></td>
      </tr>
    </c:forEach>

    <c:if test='${taskList != null}'>
        <input type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
        <input type="submit" value="Add new task" ONCLICK="window.location.href='taskInsert.og?idt=${task.idt}'"/>
        <div>
            <jsp:include page="../logout.jsp" />
        </div>

        <c:if test='${hasNext == "true" }'>
            <div>
            <input type="submit" value="next" ONCLICK="window.location.href='taskList.og?page=${page+1}'"/>
             </div>
        </c:if>

        <c:if test='${page > 1}'>
            <div>
            <input type="submit" value="back" ONCLICK="window.location.href='taskList.og?page=${page-1}'"/>
             </div>
        </c:if>

    </c:if>
</table>

    ${currentSessionUser.lastName}
     ${numOfPages}
<div>
    <c:forEach var='p' begin='1' end="${numOfPages}">
        <td><input type="submit" value='${p}' ONCLICK="window.location.href='taskList.og?page=${p}'"/></td>
    </c:forEach>
    </div>
</body>
</html>