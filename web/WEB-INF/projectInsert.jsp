<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>

<form action="projectInsertSave.pro">
name: <input type="text" name="name"><br/>
description: <input type="text" name="description"><br/>
user: <input type="text" name="user_idu"><br/>

<input type="submit"/>
</form>
<div>
    <jsp:include page="../logout.jsp" />
</div>
</body>
</html>