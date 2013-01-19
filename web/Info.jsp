
<html>
<head>
    <title>INFO</title>
</head>
<body>


<jsp:useBean id="person" scope="session" class="com.log2.BeanTest" />
<jsp:getProperty name="person" property="name" />



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