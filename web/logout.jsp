
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%--<link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet" type="text/css">--%>
        <link rel="stylesheet" type="text/css" href="css/style.css"/>
        <title>Logout</title>
</head>
<body>
<c:if test='${sessionScope != null}'>
    <form name="actionForm" action="go.out" method ="GET">
        <input class="btn-primary" type="submit" value="Logout">
    </form>
</c:if>


</body>
</html>