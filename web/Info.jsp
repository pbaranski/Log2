
<html>
<head>
    <title>INFO</title>
</head>
<body>


<div>
    <jsp:useBean id="p" scope="request" class="com.login.LoginBean" />
    <jsp:getProperty name="p" property="lastName" />

</div>

<div>


    DEBUG INFO

    <jsp:useBean id="person" scope="session" class="com.log2.BeanTest" />
    <jsp:setProperty name="person" property="name" value="Bodzio"></jsp:setProperty>


    <jsp:useBean id="beanx" scope="session" class="com.log2.BeanTest2" />
    <jsp:setProperty name="beanx" property="xxx" value="jakies nazwy"></jsp:setProperty>


    <div>
        BEAN TEST Nazwa bean'u person
    </div>
    <div>
        <jsp:getProperty name="person" property="name" />
    </div>


    <div>
        BEN TEST Nazwa beanu beanx
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
<%@ page language="java" contentType="text/html; "%>
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