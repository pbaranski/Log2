<%--
  Created by IntelliJ IDEA.
  User: A
  Date: 13.01.13
  Time: 17:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Logout</title>
</head>
<body>
<c:if test='${sessionScope != null}'>
    <form name="actionForm" action="go.out" method ="GET">
        <input type="submit" value="Logout">
    </form>
</c:if>


</body>
</html>