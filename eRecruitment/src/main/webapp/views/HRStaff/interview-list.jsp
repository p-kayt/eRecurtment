<%-- 
    Document   : interview-list-HRStaff
    Created on : Nov 2, 2022, 5:26:48 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang = "vi">
    <head>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>

        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Danh sách các cuộc phỏng vấn đã tạo</title>

    </head>
    <body>
        <c:if test="${empty user}">
            <jsp:include page="../header/header_loginbtn.jsp" />
        </c:if>

        <c:if test="${not empty user}">
            <jsp:include page="../header/header_logoutbtn.jsp" />
        </c:if>

        <section>
            <c:choose>
                <c:when test = "${user.userRole == 2 || user.userRole == 3}">
                    <div>
                        <c:choose>
                            <c:when test= "${not empty InterviewList}">
                                <c:choose>
                                    <c:when test="${(InterviewList.size() == 0)}">
                                        <p>Chưa có cuộc phỏng vấn nào.</p>
                                    </c:when>  
                                    <c:otherwise>
                                        <h3>Danh sách các cuộc phỏng vấn</h3>
                                        <div class="border border-1 m-5 p-4 shadow">
                                            <c:forEach items="${InterviewList}" var="p" varStatus="loop">
                                                <div>

                                                    <c:forEach items="${listInterviewStatus}" begin="${loop.index}" end="${loop.index}" step="1" var="status">
                                                        <p>${status}<p>
                                                        </c:forEach>

                                                        <c:forEach items="${listInterviewStage}" begin="${loop.index}" end="${loop.index}" step="1" var="stage">
                                                        <p>${stage}<p>
                                                        </c:forEach>
                                                    <div style = "background: #ccc;">
                                                        <p>Mô tả</p>
                                                        <p>${p.getDescription()}</p>
                                                    </div>
                                                    <p>${p.getTime()}</p>
                                                    <p>This is post detail  ${p.getPostID()}</p>
                                                    <form action="interview" method="post" >

                                                        <input type="hidden" name="postID" value="${p.getPostID()}">
                                                        <input type="hidden" name="interviewID" value="${p.getInterviewID()}">

                                                        <c:choose>
                                                            <c:when test = "${(p.bookerID == userID)}">
                                                                <input type="hidden" name="action" value="interviewDetail">
                                                                <input type="submit" value="Chỉnh sửa">
                                                            </c:when>

                                                            <c:otherwise>
                                                                <input type="hidden" name="action" value="viewInterviewDetail">
                                                                <p>PS: Chưa làm phan hiển thị interview (view only)</p>
                                                                <input type="submit" value="Chi tiết">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </form>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </c:when>    
                            <c:otherwise>
                                <p>Chưa có cuộc phỏng vấn nào.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                <c:otherwise>
                    <h2>Bạn không có quyền truy cập trang này</h2>
                </c:otherwise>
            </c:choose>
        </section>




    </body>
</html>
