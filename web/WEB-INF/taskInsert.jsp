<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<form action="taskInsertSave.og">
name: <input type="text" name="name"><br/>
priority: <input type="text" name="priority"><br/>
timeToDo: <input type="text" name="timeToDo"><br/>
description: <input type="text" name="description"><br/>
user id: <input type="text" name="userId"><br/>
<input type="submit"/>
</form>
<div>
    <jsp:include page="../logout.jsp" />
</div>
</body>
</html>