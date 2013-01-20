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

<c:if test='${showLogout==null}'>

<form name="actionForm" action="com.login.LoginServlet" method ="GET">
    <table>
        <tr><td>Enter your Username: </td><td><input type="text" name="uname"/></td></tr>
        <tr><td>Enter your Password: </td><td><input type="password" name="password"/></td></tr>
        <tr><td colspan="2" align="center"><input type="submit" value="submit"> </td></tr>
    </table>
</form>


<div>
${errorMsg}
TOBD na czerwono
</div>


</c:if>
<c:if test='${showLogout!=null}'>

<div>
  Witaj ${showLogout}
    Wyloguj się albo pocinaj do listy
    TOBD przycisk do listy
    <div>
        <jsp:include page="logout.jsp" />
    </div>

</div>

</c:if>


<div>

    DEBUG INFO

<jsp:useBean id="person" scope="session" class="com.log2.BeanTest" />
<jsp:setProperty name="person" property="name" value="Bodzio"></jsp:setProperty>


<jsp:useBean id="beanx" scope="session" class="com.log2.BeanTest2" />
<jsp:setProperty name="beanx" property="xxx" value="jakies nazwy"></jsp:setProperty>


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


<%--
req_session_attribute_printer.jsp
Author:<a href="mailto:get.anurag at gmail do com">Anurag Kumar Jain</a>
Date: July 25, 2007
--%>

<script type="text/javascript">
    function showHideAttributes(spanId){
        if(document.getElementById(spanId).style.display=='block'){
            document.getElementById(spanId).style.display='none';
        }else if(document.getElementById(spanId).style.display=='none'){
            document.getElementById(spanId).style.display='block';

        }
    }
</script>
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