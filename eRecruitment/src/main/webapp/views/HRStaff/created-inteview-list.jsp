<%-- 
    Document   : interview-list-HRStaff
    Created on : Nov 2, 2022, 5:26:48 PM
    Author     : MINH TRI
--%>

<%@page import="javax.servlet.jsp.jstl.core.LoopTagStatus"%>
<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang = "vi">
    <head>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <%ArrayList<InterviewDTO> createdInterviewList = (ArrayList<InterviewDTO>) request.getAttribute("createdInterviewList");%>
        <%ArrayList<String> listInterviewStatus = (ArrayList<String>) request.getAttribute("listInterviewStatus");%>
        <%ArrayList<String> listInterviewStage = (ArrayList<String>) request.getAttribute("listInterviewStage");%>
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
            <div>
                <c:choose>
                    <c:when test= "<%=(createdInterviewList != null)%>">
                        <c:choose>
                            <c:when test="<%= (createdInterviewList.size() == 0)%>">
                                <p>Bạn chưa tạo cuộc phỏng vấn nào.</p>
                            </c:when>  
                            <c:otherwise>
                                <h3>Các cuộc phỏng vấn đã tạo</h3>
                                <div class="border border-1 m-5 p-4 shadow">
                                    <c:forEach items="${createdInterviewList}" var="c" varStatus="loop">
                                        <div>

                                            <c:forEach items="${listInterviewStatus}" begin="${loop.index}" end="${loop.index}" step="1" var="status">
                                                <p>${status}<p>
                                                </c:forEach>

                                                <c:forEach items="${listInterviewStage}" begin="${loop.index}" end="${loop.index}" step="1" var="stage">
                                                <p>${stage}<p>
                                                </c:forEach>
                                            <div style = "background: #ccc;">
                                                <p>Mô tả</p>
                                                <p>${c.getDescription()}</p>
                                            </div>
                                            <p>${c.getTime()}</p>
                                            <p>${c.getPostID()}</p>
                                            <form action="interview" method="post" >
                                                <input type="hidden" name="action" value="interviewDetail">
                                                <input type="hidden" name="postID" value="${c.getPostID()}">
                                                <input type="hidden" name="interviewID" value="${c.getInterviewID()}">
                                                <input type="submit" value="Chỉnh sửa">
                                            </form>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </c:when>    
                    <c:otherwise>
                        <p>Bạn chưa tạo cuộc phỏng vấn nào.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>



    </body>
</html>
