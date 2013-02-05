<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div>
    <h1 style="text-align:center;">Task list</h1>

    <h2 style="text-align:center;">Hello ${currentSessionUser.username}</h2>

</div>

<div>
    <jsp:include page="../logout.jsp"/>
</div>


<div>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
        </tr>
        <c:forEach items='${projectList}' var='project'>
            <tr>

                <td>${project.idp}</td>
                <td>${project.name}</td>
                <td>${project.description}</td>

                <td><input type="submit" value="Go to project"
                           ONCLICK="window.location.href='taskList.og?idp=${project.idp}'"/></td>

                <c:if test='${isAdmin != null}'>
                    <td><input type="submit" value="edit"
                               ONCLICK="window.location.href='projectEdit.pro?idp=${project.idp}'"/></td>
                    <td><input type="submit" value="delete"
                               ONCLICK="window.location.href='projectDel.pro?idp=${project.idp}'"/></td>
                </c:if>
            </tr>
        </c:forEach>
    </table>
</div>

<div>
    <c:if test='${isAdmin != null}'>
        <input type="submit" value="Add new project"
               ONCLICK="window.location.href='projectInsert.pro?idp=${project.idp}'"/>
    </c:if>
</div>

<div>
    <c:if test='${hasNext == "true" }'>
        <input type="submit" value="next" ONCLICK="window.location.href='projectList.pro?page=${page+1}'"/>
    </c:if>

    <c:forEach var='p' begin='1' end="${numOfPages}">
        <td><input type="submit" value='${p}' ONCLICK="window.location.href='projectList.pro?page=${p}'"/></td>
    </c:forEach>

    <c:if test='${page > 1}'>
        <input type="submit" value="back" ONCLICK="window.location.href='projectList.pro?page=${page-1}'"/>
    </c:if>

</div>

</body>
</html>