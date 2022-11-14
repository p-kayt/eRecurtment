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
        <meta charset="utf-8" />
        <title>Danh sách các cuộc phỏng vấn đã tạo</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="" name="keywords" />
        <meta content="" name="description" />

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap"
            rel="stylesheet"
            />

        <!-- Icon Font Stylesheet -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
            rel="stylesheet"
            />

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet" />
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet" />

        <!-- Template Stylesheet -->
        <link href="css/style-dltemp.css" rel="stylesheet" />
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
                    <c:when test = "${user.userRole == 2 || user.userRole == 3}">
                        <c:choose>
                            <c:when test= "${not empty candidate}">
                                <div class="d-flex flex-column m-2 p-2  border border-1">
                                    <div>
                                        <p>Chi tiết đánh giá ứng viên</p>
                                    </div>
                                    <p>Ứng viên</p>
                                    <div >
                                        <div>
                                            <div >
                                                <img class="ava_img" src= "${candidate.getAvatarURL() != null ? candidate.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                            </div>
                                            <div>
                                                <p>${candidate.getFirstName()} ${candidate.getLastName()}</p>
                                            </div>
                                            <div \>
                                                <a href = "job?action=view-candidate-cv&userID=${candidate.userID}" target="_blank">Xem CV</a>
                                            </div>
                                        </div>
                                    </div>

                                    <p>Đánh giá </p>
                                    <div>

                                        <c:forEach items="${listInterviewer}" var="i" varStatus="loop">

                                            <div >
                                                <img class="img-thumbnail m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                            </div>
                                            <div >
                                                <p>${i.getFirstName()} ${i.getLastName()}</p>
                                            </div>
                                            <div >
                                                <c:forEach items="${evaluation}" begin="${loop.index}" end="${loop.index}" step="1" var="e"> 
                                                    <c:choose>
                                                        <c:when test = "${e == null}">
                                                            <p>Chưa có đánh giá</p>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <p>Đánh giá</p>
                                                            <textarea cols="50" rows="4" disabled>${e.evaluationDescription}</textarea>
                                                            <p>Điểm: ${e.score}</p>
                                                        </c:otherwise>
                                                    </c:choose>    

                                                </c:forEach>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:when>    
                            <c:otherwise>
                                <p>Hiện tại chưa có ứng viên nào.</p>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <h2>Bạn không được phép truy cập trang web này</h2>
                    </c:otherwise>
                </c:choose>
            </section>
            <jsp:include page="../footer/footer.jsp" />
        </div>


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!--Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
