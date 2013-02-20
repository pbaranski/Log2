<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pl">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <%--<link href="http://twitter.github.com/bootstrap/assets/css/bootstrap.css" rel="stylesheet" type="text/css">--%>
        <link rel="stylesheet" type="text/css" href="css/style.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
    <title>Login Page</title> </head>
<body>


<h1 style="text-align:center;">Task list</h1>

<div style="width: 50%; margin: 0 auto;">
<c:choose>

<c:when test='${not empty currentSessionUser}'>

    <div>
        <p class="text-info">Witaj ${showLogout}</p>
        <div>
            <input class="btn" type="submit" value="Go back to projects" ONCLICK="window.location.href='/projectList.pro'"/>
        </div>
        <div>
            <jsp:include page="../logout.jsp" />
        </div>

    </div>

</c:when>

    <c:otherwise>

        <form accept-charset="ISO-8859-15" name="actionForm" action="start.log" onsubmit="return validateForm()"  method ="POST">
            <table>
                <tr>
                    <td><input  type="text" name="uname" placeholder="Login"/> </td>

                    <td id="errorName"  style="display:none;" class="text-error">wrong input format</td>
                </tr>
                <tr>
                    <td><input type="password" name="password" placeholder="Password"/>
                    </td>
                    <td id="errorPass"  style="display:none" class="text-error">wrong input format</td>
                </tr>
                <tr>
                    <td><input class="btn btn-primary" type="submit" value="Submit"> </td>
                </tr>
                <tr>
                    <td class="text-error" > ${errorInfo}</td>
                </tr>
            </table>
        </form>

    </c:otherwise>

</c:choose>
</div>

</body>
<script>
    function validateForm()
    {
        var result = true;
        var letterNumber = /^[0-9a-zA-Z]+$/;
        var name=document.forms["actionForm"]["uname"].value;
        var pass=document.forms["actionForm"]["password"].value;

        if (!name.match(letterNumber) || name.length>12 )
        {
            document.getElementById('errorName').style.display = "block";
            result =  false;
        } else document.getElementById('errorName').style.display = "none";

        if (!pass.match(letterNumber)|| pass.length>12 )
        {
            document.getElementById('errorPass').style.display = "block";
            result = false;
        } else document.getElementById('errorPass').style.display = "none";

        return result;
    }
</script>
</html>