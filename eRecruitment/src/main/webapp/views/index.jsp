<%-- 
    Document   : index
    Created on : Sep 24, 2022, 11:22:43 AM
    Author     : Huu Minh
--%>
<%@taglib prefix="f" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <c:if test="${requestScope.var} empty"><h1>Hello World!</h1></c:if>
        <h1>Hi World!</h1>
    </body>
</html>
