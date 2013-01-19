<html>
<head>
    <title>Login Success</title>
</head>
<body>
User Logged Successfully

<jsp:useBean id="person" scope="session" class="com.log2.BeanTest" />
<jsp:setProperty name="person" property="name" value="Bodzio"></jsp:setProperty>
<FORM>
    <INPUT Type="BUTTON" VALUE="Info" ONCLICK="window.location.href='http://localhost:8080/Info.jsp'" />
    <INPUT Type="BUTTON" VALUE="Info" ONCLICK="window.location.href='http://localhost:8080/taskList.og'" />
</FORM>
</body>
</html>