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
      <td>${task.userId}</td>
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

<jsp:useBean id="person" scope="session" class="com.log2.BeanTest" />
<jsp:useBean id="beanx" scope="session" class="com.log2.BeanTest2" />
<div>
    <div>
        Nazwa bean'u person
    </div>
    <div>
        <jsp:getProperty name="person" property="name" />
    </div>


    <div>
        Nazwa beanu beanx
    </div>
    <div>
        <jsp:getProperty name="beanx" property="xxx" />
    </div>
</div>
<a href="#" onclick="showHideAttributes('debugSpan')"> Attributes</a>
<span id='debugSpan' style='display:none'>
Session Attributes:
<% java.util.Enumeration salist = session.getAttributeNames();
    while(salist.hasMoreElements()){
        String name=(String)salist.nextElement();
        Object value = session.getAttribute(name);%>
    <div>
        <%=" "+name+"="+value%>
    </div>
<% }%>
Request Attributes:
<% java.util.Enumeration ralist = request.getAttributeNames();
    while(ralist.hasMoreElements()){
        String name=(String)ralist.nextElement();
        Object value = session.getAttribute(name);%>
      <%=" "+name+"="+value %>
<% }%>
</span>
</body>
</html>