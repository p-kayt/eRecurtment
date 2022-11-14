<%-- 
    Document   : application-detail
    Created on : Nov 13, 2022, 2:37:28 PM
    Author     : Huu Minh
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.application.ApplicationDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết ứng tuyển</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <jsp:include page="../../header/header_loginbtn.jsp" />
        </c:if>

        <c:if test="${not empty sessionScope.user}">
            <jsp:include page="../../header/header_logoutbtn.jsp" />
        </c:if>

        <%boolean check = false;%>
        <h2>Position: ${requestScope.post.positionName}</h2>
        <p>Apply Date: ${requestScope.application.applyDate}</p>
        <c:forEach var="i"  items="${requestScope.stageList}" varStatus="loop">

            <c:if test="${i.id != requestScope.application.stageID}">
                <c:if test="<%=!check%>">
                    <p>${i.description}: Đậu</p>
                    <p>1) <%=check%></p>
                </c:if>
            </c:if>
            <c:if test="${i.id == requestScope.application.stageID}">
                <p>${i.description}: Đang diễn ra</p>
                <%check = true;%>
                <p>2) <%=check%></p>
            </c:if>
            <c:if test="${i.id != requestScope.application.stageID}">
                <c:if test="<%=check%>">
                    <p>${i.description}: Chưa diễn ra</p>
                    <p>3) <%=check%></p>
                </c:if>
            </c:if>
        </c:forEach>

        <jsp:include page="../../footer/footer.jsp" />
    </body>
</html>
