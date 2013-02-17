<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<body>
<div>
    <h1 style="text-align:center;">Task list</h1> <h4 style="text-align:center;">Hello ${currentSessionUser.username}</h4>
</div>

<div>
    <jsp:include page="../logout.jsp"/>
</div>
<div>
    <input class="btn" type="submit" value="Manage users" ONCLICK="window.location.href='userList.user'"/>
</div>
<div style="width: 50%; margin: 0 auto;">
    <div>
        <c:if test='${isAdmin != null}'>
            <input class="btn" type="submit" value="Add new project"
                   ONCLICK="window.location.href='projectInsert.pro?idp=${project.idp}'"/>
        </c:if>
    </div>
    <div>
    <table class="table table-striped">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th></th>

            <c:if test='${isAdmin != null}'>
            <th></th>
                <th></th>
                <th></th>
            </c:if>
        </tr>
        <c:forEach items='${projectList}' var='project'>
            <tr>
                <td>${project.idp}</td>
                <td>${project.name}</td>
                <td>${project.description}</td>
                <td><input class="btn btn-success" type="submit" value="Go to project" ONCLICK="window.location.href='taskList.og?idp=${project.idp}'"/></td>
                <c:if test='${isAdmin != null}'>
                    <td><input class="btn btn-warning" type="submit" value="edit" ONCLICK="window.location.href='projectEdit.pro?idp=${project.idp}'"/></td>
                    <td>
                        <form name="lol2${project.idp}" action="projectDel.pro">
                            <input type="hidden" name="idp" value="${project.idp}">
                            <td><input class="btn btn-danger" type="submit" value="delete" ONCLICK="return validateForm(${project.idp})"/></td>
                        </form>
                    </td>
                </c:if>
            </tr>
        </c:forEach>
    </table>
</div>



<div>
    <c:if test='${page > 1}'>
        <input class="btn " type="submit" value="<<" ONCLICK="window.location.href='projectList.pro?page=${page-1}'"/>
    </c:if>

    <c:forEach var='p' begin='1' end="${numOfPages}">
        <c:if test="${p==page}">
        <td><input class="btn btn-info" type="submit" style="color: #ffffff" value='${p}' ONCLICK="window.location.href='projectList.pro?page=${p}'"/></td>
        </c:if>
        <c:if test="${p!=page}">
            <td><input class="btn" type="submit" black;" value='${p}' ONCLICK="window.location.href='projectList.pro?page=${p}'"/></td>
        </c:if>

    </c:forEach>

    <c:if test='${hasNext == "true"}'>
        <input class="btn" type="submit" value=">>" ONCLICK="window.location.href='projectList.pro?page=${page+1}'"/>
    </c:if>
</div>
</div>

</body>
<script>
    function validateForm(num) {
        if (confirm("Are you sure you want to delete projects with all subtasks?")) {
            document.getElementsByName("lol2" + num).submit();
        }
        return false;
    }
</script>
</html>