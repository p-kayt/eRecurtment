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
                    <p>${i.description}: <span style="color: green">Đậu</span></p>
                </c:if>
            </c:if>
            <c:if test="${i.id == requestScope.application.stageID}">                
                <c:if test="${requestScope.application.statusID == 1}">
                    <p>${i.description}: <span style="color: greenyellow">Đang diễn ra</span></p>
                </c:if>
                <c:if test="${requestScope.application.statusID == 2}">
                    <p>${i.description}: <span style="color: gray">Đã huỷ</span></p>
                </c:if>
                <c:if test="${requestScope.application.statusID == 3}">
                    <p>${i.description}: <span style="color: red">Rớt</span></p>
                </c:if>
                <c:if test="${requestScope.application.statusID == 4}">
                    <p>${i.description}: <span style="color: green">Đậu</span></p>
                </c:if>
                <%check = true;%>
            </c:if>
            <c:if test="${i.id != requestScope.application.stageID}">
                <c:if test="<%=check%>">
                    <p>${i.description}: <span style="color: gray">Chưa diễn ra</span></p>
                </c:if>
            </c:if>
        </c:forEach>



        <c:if test="${requestScope.application.statusID == 1}">
            <form action="application" method="get" onsubmit="cancelAlert()">
                <input name="action" value="cancel-application" style="display: none"></input>
                <input name="appID" value="${requestScope.application.id}" style="display: none"></input>
                <button class="btn btn-danger" type="submit">Huỷ ứng tuyển</button>
            </form>
        </c:if>
        <jsp:include page="../../footer/footer.jsp" />
    </body>
    
    <!--Javascript -->
        <script src="js/main.js"></script>
        <script>
            function cancelAlert() {
                alert("Bạn đã huỷ ứng tuyển thành công, hãy xem lại trong tab đã huỷ!");
            }

        </script>
</html>
