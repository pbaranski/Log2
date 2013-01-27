<%--
  Login page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=windows-1256">
    <title>Login Page</title> </head>
<body>


<h1 style="text-align:center;">Task list</h1>

<div style="width: 50%; margin: 0 auto;">
<c:choose>

<c:when test='${not empty currentSessionUser}'>

    <div>
        Witaj ${showLogout}
        Wyloguj się albo pocinaj do listy
        TOBD przycisk do listy
        <div>
            <jsp:include page="../logout.jsp" />
        </div>

    </div>

</c:when>

    <c:otherwise>

        <form name="actionForm" action="/log" onsubmit="return validateForm()"  method ="POST">
            <table>
                <tr>
                    <td>Enter your Username: </td><td><input type="text" name="uname"/></td>
                    <td id="errorName"  style="display:none; color: #FF00FF" >wrong input format</td>
                </tr>
                <tr>
                    <td>Enter your Password: </td><td><input type="password" name="password"/></td>
                    <td id="errorPass"  style="display:none; color: #FF00FF" >wrong input format</td>
                </tr>
                <tr>
                    <td ></td>
                    <td><input type="submit" value="Submit"> </td>
                </tr>
                <tr>
                    <td></td>
                    <td style=" color: #9900FF" > ${errorInfo}</td>
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