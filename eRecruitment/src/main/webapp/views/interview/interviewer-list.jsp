<%-- 
    Document   : interviewer-list
    Created on : Oct 31, 2022, 7:47:08 AM
    Author     : MINH TRI
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <%InterviewDTO interview = (InterviewDTO) session.getAttribute("interview");%>
        <%ArrayList<UserDTO> interviewerList = (ArrayList<UserDTO>) session.getAttribute("listInterviewer");%>

        <div>

            <c:choose>
                <c:when test= "<%=(interviewerList != null)%>">
                    <c:choose>
                        <c:when test="<%= (interviewerList.size() == 0)%>">
                            <p>Không có người phỏng vấn khả dụng.</p>
                        </c:when>  
                        <c:otherwise>
                            <h3>Danh sách người phỏng vấn</h3>
                            <div>
                                <c:forEach items="<%=interviewerList%>" var="i">
                                    <div>
                                        <div>
                                            <img class="ava_img" src= "${user.getAvatarURL() != null ? user.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                        </div>
                                        <div>
                                            
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </c:when>    
                <c:otherwise>
                    <p>Không có người phỏng vấn khả dụng.</p>
                </c:otherwise>
            </c:choose>

            <!--test-->
            <p style="color:yellow" >${interviewID}</p>
            <!--test-->
        </div>


    </body>
</html>
