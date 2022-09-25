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
        <meta charset="UTF-8">   
        <title>JSP Page</title>

        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/style_cv.css" type="text/css">
    </head>
    <body>
        <jsp:include page="../cv/cv-read.jsp" />
    <c:if test="${requestScope.var} empty"><h1>Hello World!</h1></c:if>
    <h1>Hi World!</h1>
</body>
</html>
