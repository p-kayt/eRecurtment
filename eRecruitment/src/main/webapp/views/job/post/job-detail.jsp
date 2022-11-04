<!DOCTYPE html>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="vi">

    <head>
        <meta charset="utf-8">
        <title>Thông Tin Tuyển Dụng</title>
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
        <link href="../../../css/style-dltemp.css" rel="stylesheet" />
    </head>

    <body>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <div class="container-xxl bg-white p-0">
            <c:if test="${empty user}">
                <jsp:include page="../../header/header_loginbtn.jsp" />
            </c:if>
            <c:if test="${not empty user}">
                <jsp:include page="../../header/header_logoutbtn.jsp" />
            </c:if>
            <!-- Spinner Start 
    
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
    
             Spinner End -->

            <!-- Header End -->
            <div class="container-xxl py-5 bg-dark page-header mb-5">
                <div class="container my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Thông Tin Tuyển Dụng</h1>
                    <!-- <nav aria-label="breadcrumb">
                        <ol class="breadcrumb text-uppercase">
                            <li class="breadcrumb-item"><a href="#">Home</a></li>
                            <li class="breadcrumb-item"><a href="#">Pages</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Job Detail</li>
                        </ol>
                    </nav> -->
                </div>
            </div>
            <!-- Header End -->
            <c:if test="${not empty requestScope.msg}">
                <div class="alert alert-secondary alert-dismissible fade show d-flex justify-content-between" role="alert">
                    ${requestScope.msg}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>
            <c:if test="${not empty requestScope.post}">
                <!-- Job Detail Start -->
                <div class="container-xxl py-5 wow fadeInUp" data-wow-delay="0.1s">
                    <div class="container">

                        <div class="row gy-5 gx-4">
                            <div class="col-lg-8">
                                <div class="d-flex align-items-center mb-5">
                                    <!--                                <img class="flex-shrink-0 img-fluid border rounded" src="image/com-logo-2.jpg" alt="" style="width: 80px; height: 80px;">-->
                                    <div class="text-start ps-4">
                                        <h3 class="mb-3">Vị Trí: ${requestScope.post.positionName}</h3>
                                        <span class="text-truncate me-3"><i class="fa fa-map-marker-alt text-primary me-2"></i>${requestScope.post.address}</span>
                                        <span class="text-truncate me-3">
                                            <i class="far fa-clock text-primary me-2"></i>
                                            <c:if test="${requestScope.post.formID == 1}">Full Time - Offline</c:if>
                                            <c:if test="${requestScope.post.formID == 2}">Full Time - Online</c:if>
                                            <c:if test="${requestScope.post.formID == 3}">Full Time - Hybrid</c:if>
                                            <c:if test="${requestScope.post.formID == 4}">Part Time - Offline</c:if>
                                            <c:if test="${requestScope.post.formID == 5}">Part Time - Online</c:if>
                                            <c:if test="${requestScope.post.formID == 6}">Part Time - Hybrid</c:if>
                                            </span>
                                            <span class="text-truncate me-0"><i class="far fa-money-bill-alt text-primary me-2"></i>${requestScope.post.salary}</span>
                                    </div>
                                </div>

                                <div class="mb-5">
                                    <h4 class="mb-3">Mô Tả Công Việc</h4>
                                    <p>${requestScope.post.postDescription}</p>
                                    <h4 class="mb-3">Yêu Cầu Công Việc</h4>
                                    <ul class="list-unstyled">
                                        <c:forEach var="req" items="${requestScope.post.requirementList}">
                                            <li><i class="fa fa-angle-right text-primary me-2"></i>${req.requirement}</li>
                                            </c:forEach>
                                    </ul>
                                    <h4 class="mb-3">Kỹ Năng Cần Thiết</h4>
                                    <ul class="list-unstyled">
                                        <c:forEach var="skill" items="${requestScope.post.skillList}">
                                            <li>
                                                <div><i class="fa fa-angle-right text-primary me-2"></i>${skill.skillName}</div>
                                                <div>${skill.skillDescription}</div>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                    <h4 class="mb-3">Quyền Lợi Công Việc</h4>
                                    <ul class="list-unstyled">
                                        <c:forEach var="bene" items="${requestScope.post.benefitList}">
                                            <li><i class="fa fa-angle-right text-primary me-2"></i>${bene.benefit}</li>
                                            </c:forEach>
                                    </ul>
                                </div>
                                <div class="mb-5">
                                    <form action="./post" method="post">
                                        <input type="hidden" name="action" value="apply-for-post">
                                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                        <input class="btn btn-primary" type="submit" value="Ứng Tuyển Ngay">
                                    </form>
                                </div>
                            </div>

                            <div class="col-lg-4">
                                <div class="bg-light rounded p-5 mb-4 wow slideInUp" data-wow-delay="0.1s">
                                    <h4 class="mb-4">Thông Tin Cần Biết</h4>

                                    <p><i class="fa fa-angle-right text-primary me-2"></i>Số lượng tuyển: ${requestScope.post.hiringQuantity}</p>
                                    <p>
                                        <i class="fa fa-angle-right text-primary me-2"></i>Hình thức làm việc: 
                                        <c:if test="${requestScope.post.formID == 1}">Full Time - Offline</c:if>
                                        <c:if test="${requestScope.post.formID == 2}">Full Time - Online</c:if>
                                        <c:if test="${requestScope.post.formID == 3}">Full Time - Hybrid</c:if>
                                        <c:if test="${requestScope.post.formID == 4}">Part Time - Offline</c:if>
                                        <c:if test="${requestScope.post.formID == 5}">Part Time - Online</c:if>
                                        <c:if test="${requestScope.post.formID == 6}">Part Time - Hybrid</c:if>
                                        </p>
                                        <p><i class="fa fa-angle-right text-primary me-2"></i>Mức lương: ${requestScope.post.salary}</p>
                                    <p><i class="fa fa-angle-right text-primary me-2"></i>Địa chỉ: ${requestScope.post.address}</p>
                                    <p><i class="fa fa-angle-right text-primary me-2"></i>Ngày bắt đầu: ${requestScope.post.startDate}</p>
                                    <p><i class="fa fa-angle-right text-primary me-2"></i>Ngày kết thúc: ${requestScope.post.expiredDate}</p>
                                    <p>
                                        <i class="fa fa-angle-right text-primary me-2"></i>Trạng thái: 
                                        <c:if test = "${requestScope.post.statusID == 1}">inActive</c:if>
                                        <c:if test = "${requestScope.post.statusID == 2}">Đang chờ</c:if>
                                        <c:if test = "${requestScope.post.statusID == 3}">Đang tuyển</c:if>
                                        <c:if test = "${requestScope.post.statusID == 4}">Đã đóng</c:if>
                                        </p>
                                    </div>
                                    <div class="bg-light rounded p-5 wow slideInUp" data-wow-delay="0.1s">
                                        <h4 class="mb-4">Quy Trình Ứng Tuyển</h4>
                                    <c:forEach var="stage" items="${requestScope.post.stageList}">
                                        <div>
                                            <div>
                                                <p>
                                                    <i class="fa fa-angle-right text-primary me-2"></i>
                                                    <c:if test = "${stage.stageID == 1}">Ứng tuyển CV</c:if>
                                                    <c:if test = "${stage.stageID == 2}">Phỏng vấn</c:if>
                                                    <c:if test = "${stage.stageID == 3}">Kết thúc</c:if>
                                                    <c:if test = "${stage.stageID == 4}">Đánh giá tổng kết</c:if>
                                                    </p>
                                                </div>
                                                <div>
                                                    <p>${stage.description}</p>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Job Detail End -->
            </c:if>
            <c:if test="${empty requestScope.post}">
                <h3 class="mb-3">Không tìm thấy bài đăng tuyển dụng</h3>
            </c:if>

            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>
        <jsp:include page="../../footer/footer.jsp" />

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>

        <!-- script for displaying element -->
        <script>

        </script>
    </body>
</html>