<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<form action="taskEditSave.og">
<input type="hidden" name="idt" value="${task.idt}">
name: <input type="text" name="name" value="${task.name}"><br/>
priority: <input type="text" name="priority" value="${task.priority}"><br/>
timeToDo: <input type="text" name="timeToDo" value="${task.timeToDo}"><br/>
description: <input type="text" name="description" value="${task.description}"><br/>
projectId: <input type="text" name="projectId" value="${task.projectId}"><br/>
userId: <input type="text" name="userId" value="${task.userId}"><br/>

<input type="submit"/>
</form>
<div>
    <jsp:include page="../logout.jsp" />
</div>
</body>
</html>