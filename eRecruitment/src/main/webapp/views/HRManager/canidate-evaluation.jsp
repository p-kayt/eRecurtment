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
        <title>Đánh giá ứng viên</title>
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

        <link rel="stylesheet" href="css/style_profile.css"/>
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
                        <div class="container-xxl py-5 bg-dark page-header mb-5">
                            <div class="container my-5 pt-5 pb-4">
                                <h1 class="display-3 text-white mb-3 animated slideInDown">Đánh giá</h1>
                                <nav aria-label="breadcrumb">
                                    <!--                                                    <ol class="breadcrumb text-uppercase">
                                                                                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                                                                                            <li class="breadcrumb-item text-white active" aria-current="page">Chi tiết</li>
                                                                                        </ol>-->
                                </nav> 
                            </div>
                        </div>
                        <c:choose>
                            <c:when test= "${not empty candidate}">
                                <div class="d-flex flex-column m-2 p-2  border border-1">
                                    <div class="d-flex flex-row justify-content-between align-middle">
                                        <label class="col-3 m-2 px-3 fw-bold fs-5">Ứng viên</label>
                                    </div>

                                    <div class="col-10 d-flex flex-row mx-4 text-center mb-3">
                                        <div class="col-3 d-flex justify-content-center">
                                            <img class="ava_img_icon_lg border border-1" src= "${candidate.getAvatarURL() != null ? candidate.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                        </div>
                                        <div class="col-7 text-start align-center m-auto">
                                            <p class="my-auto">${candidate.getFirstName()} ${candidate.getLastName()}</p>
                                        </div>

                                        <div class="col-2 align-center m-auto">
                                            <a class="my-auto btn btn-primary" href = "job?action=view-candidate-cv&userID=${candidate.userID}" target="_blank">Xem CV</a>
                                        </div>
                                    </div>


                                    <div class="d-flex flex-column m-2 p-3 border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <label class="col-3 m-1 fw-bold fs-5">Đánh giá</label>
                                        </div>

                                        <div>
                                            <c:forEach items="${stageList}" var="s" varStatus="loop">
                                                <div class="col-11 row g-2 m-1">
                                                    <label class="col-2 fw-bold fs-5 text-dark" for="stageID">Vòng phỏng vấn</label>
                                                    <span class="col-4 text-dark align-middle">${s.split(";")[1]}</span>
                                                    <span class="col-4"></span>
                                                </div>
                                                <c:forEach items="${listInterviewer}" begin="${loop.index}" end="${loop.index}" step="1" var="lI">
                                                    <c:choose>
                                                        <c:when test = "${empty lI}" >
                                                            <div class="alert alert-warning alert-dismissible fade show d-flex justify-content-between" role="alert">
                                                                Không tìm thấy người phỏng vấn ở vòng này
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach items="${lI}" var="i" varStatus="iLoop">

                                                                <div class="d-flex flex-row justify-content-center align-center border border-2 m-1 bg-light">
                                                                    <div class="col-11 d-flex flex-row justify-content-between my-auto">

                                                                        <div class="col-2 d-flex justify-content-center">
                                                                            <img class="ava_img_icon m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                                        </div>
                                                                        <div class="col-4 d-flex flex-column text-start">
                                                                            <span class="col-12 align-center m-1 fw-bold my-auto">${i.getFirstName()} ${i.getLastName()}</span>
                                                                        </div>

                                                                        <c:forEach items="${evaluation}" begin="${loop.index}" end="${loop.index}" step="1" var="lE">
                                                                            <div class="col-6 d-flex flex-row">
                                                                                <c:forEach items="${lE}" begin="${iLoop.index}" end="${iLoop.index}" step="1" var="e">
                                                                                    <c:choose>
                                                                                        <c:when test = "${e == null}">
                                                                                            <p>Chưa có đánh giá</p>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <div class="col-8 d-flex flex-column m-1 align-middle">
                                                                                                <label class="fw-bold text-dark m-1" for="creator">Đánh giá</label>
                                                                                                <textarea class="border-0 bg-transparent" cols="40" rows="3"  disabled>${e.evaluationDescription}</textarea>
                                                                                            </div>
                                                                                            <div class=" col-4 d-flex flex-column m-1 align-items-center ">
                                                                                                <label class="fw-bold text-dark m-1 " for ="score" >Điểm</label>
                                                                                                <span class="m-auto ">${e.score}</span>
                                                                                            </div>

                                                                                        </c:otherwise>
                                                                                    </c:choose>    

                                                                                </c:forEach>
                                                                            </div>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </c:forEach>
                                        </div>
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
