<%-- 
    Document   : interview-modify
    Created on : Oct 24, 2022, 4:02:04 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.interview.ParticipantDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "vi">
    <head>
        <meta charset="utf-8" />
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>

        <title><c:if test="${not empty user}"><%=user.getFirstName()%> <%=user.getLastName()%></c:if></title>
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
            <!--css/style-dltemp.css-->
        </head>
        <body>

            <div class="container-xxl bg-white p-0"> 

            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>


            <section>
                <c:choose>
                    <c:when test = "${user.userRole == 1}">
                        <c:if test="${not empty interview}"> 
                            <div class="d-flex flex-column justify-content-center align-middle m-4 p-5 border border-2 shadow">
                                <div class="d-flex flex-column">
                                    <div class="d-flex flex-row m-2">
                                        <div class="col-10"> 
                                            <h4>Mô tả bài đăng ${postDescription}</h4>
                                        </div>
                                        <p>Result: ${result}</p>
                                    </div>
                                    <div class="d-flex flex-column m-2">
                                        <p>Tên vòng phỏng vấn: ${stageName}<p>

                                        <div style= "background: #ccc;">
                                            <p>Mô tả</p>
                                            <p>${interview.description}</p>
                                        </div>

                                        <div class="col-12">
                                            <p>Hình thức: ${formatName}</p>
                                        </div>

                                        <div>
                                            <p>Thời gian: ${time}</p>
                                        </div>
                                        <c:choose> 
                                            <c:when test = "${formatName == 'Offline'}">
                                                <div class="col-12">
                                                    <p>Địa chỉ: ${interview.address}</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="col-12">
                                                    <p>Link: ${interview.link}</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="col-12">
                                            <p>Người tạo: ${booker.firstName} ${booker.lastName}<p>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column m-2  border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <label class="col-2">Người phỏng vấn</label>
                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="${not empty listInterviewer}">
                                                <c:forEach items="${listInterviewer}" var="i">
                                                    <div class="d-flex flex-row justify-content-between align-center border border-2 m-1 bg-light">
                                                        <div class="col-6 d-flex flex-row text-center">
                                                            <div class="col-3 d-flex justify-content-center">
                                                                <img class="img-thumbnail m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>
                                                            <div class="col-9 text-start align-center m-auto">
                                                                <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <h2>Chỉ ứng viên mới có thể xem trang này</h2>
                    </c:otherwise>
                </c:choose>
            </section>


        </div>
    </body>
</html>
