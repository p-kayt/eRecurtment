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
        <meta charset="utf-8" />
        <title>JSP Page</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="" name="keywords" />
        <meta content="" name="description" />

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap"
            rel="stylesheet"
            />

        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
            rel="stylesheet"
            />

        <link href="lib/animate/animate.min.css" rel="stylesheet" />
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

        <link href="css/bootstrap.min.css" rel="stylesheet" />

        <link href="css/style-dltemp.css" rel="stylesheet" />
        <link rel="stylesheet" href="css/style_profile.css"/>
        <!---->
    </head>
    <body>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <%ArrayList<UserDTO> interviewerList = (ArrayList<UserDTO>) request.getAttribute("listInterviewer");%>

        <div class="container-xxl bg-white p-0"> 

            <c:choose>
                <c:when test = "${user.userRole == 2 || user.userRole == 3}">
                    <div>
                        <c:choose>
                            <c:when test= "<%=(interviewerList != null)%>">
                                <c:choose>
                                    <c:when test="<%= (interviewerList.size() == 0)%>">
                                        <p>Không có người phỏng vấn khả dụng.</p>
                                    </c:when>  
                                    <c:otherwise>
                                        <h3>Danh sách người phỏng vấn</h3>
                                        <div class="border border-1 m-5 p-4 shadow">
                                            <c:forEach items="<%=interviewerList%>" var="i">
                                                <div class="d-flex flex-row align-center border border-2 m-1 bg-light">
                                                    <div class="col-6 d-flex flex-row text-center">
                                                        <div class="col-3 d-flex justify-content-center">
                                                            <img class="ava_img_icon m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                        </div>
                                                        <div class="col-9 text-start align-center m-auto">
                                                            <p class="m-0">${i.getFirstName()} ${i.getLastName()}</p>
                                                        </div>
                                                    </div>
                                                    <div class="col-4"></div>
                                                    <div class="col-1 text-start align-center m-auto">
                                                        <form action="interview" method="post">
                                                            <input type="hidden" name ="action" value ="addInterviewer">
                                                            <input type="hidden" name ="interviewID" value="${interviewID}" >
                                                            <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                            <input class="btn btn-primary col-12" type="submit" value="Thêm">
                                                        </form>
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

                        <div>
                            <form action="interview" method="post">
                                <input type="hidden" name ="action" value ="interviewDetail">
                                <input type="hidden" name ="interviewID" value="${interviewID}" >
                                <input class="btn btn-primary col-12" type="submit" value="Quay về">
                            </form>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <h2>Bạn không được phép chỉnh sửa lịch phỏng vấn</h2>
                </c:otherwise>
            </c:choose>  
        </div>


    </body>
</html>
