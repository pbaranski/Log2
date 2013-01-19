<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<table>
    <tr>
      <th>Name</th><th>Priority</th><th>Time to spend</th><th>Description</th>
    </tr>
    <c:forEach items='${taskList}' var='task'>
      <tr>
      <td>${task.name}</td>
      <td>${task.priority}</td>
      <td>${task.timeToDo}</td>
      <td>${task.description}</td>
      <td><input type="submit" value="edit" ONCLICK="window.location.href='taskEdit.og?idt=${task.idt}'"/></td>
      <td><input type="submit" value="delete" ONCLICK="window.location.href='taskDel.og?idt=${task.idt}'"/></td>
      </tr>
    </c:forEach>
    <c:if test='${taskList != null}'>
        <input type="submit" value="Add new task" ONCLICK="window.location.href='taskInsert.og?idt=${task.idt}'"/>
        <div>
            <jsp:include page="logout.jsp" />
        </div>
    </c:if>
</table>

</body>
</html>