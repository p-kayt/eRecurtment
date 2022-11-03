<%-- Document : homepage Created on : Sep 27, 2022, 5:47:58 PM Author : MINH TRI
--%><%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>ERecruitment</title>
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
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <div class="container-xxl bg-white p-0">
            <!--      header with nav -->
            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>


            <!-- Carousel Start -->
            <div class="container-fluid p-0">
                <div class="owl-carousel header-carousel position-relative">
                    <div class="owl-carousel-item position-relative">
                        <img class="img-fluid" src="image/carousel-1.jpg" alt="" />
                        <div
                            class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center"
                            style="background: rgba(43, 57, 64, 0.5)"
                            >
                            <div class="container">
                                <div class="row justify-content-start">
                                    <div class="col-10 col-lg-8">
                                        <h1 class="display-3 text-white animated slideInDown mb-4">
                                            Tìm công việc hoàn hảo cho bạn
                                        </h1>

                                        <a
                                            href=""
                                            class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft"
                                            >Tìm ngay</a
                                        >
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="owl-carousel-item position-relative">
                        <img class="img-fluid" src="image/carousel-2.jpg" alt="" />
                        <div
                            class="position-absolute top-0 start-0 w-100 h-100 d-flex align-items-center"
                            style="background: rgba(43, 57, 64, 0.5)"
                            >
                            <div class="container">
                                <div class="row justify-content-start">
                                    <div class="col-10 col-lg-8">
                                        <h1 class="display-3 text-white animated slideInDown mb-4">
                                            Khởi nghiệp phù hợp nhất
                                        </h1>

                                        <a
                                            href=""
                                            class="btn btn-primary py-md-3 px-md-5 me-3 animated slideInLeft"
                                            >Tìm ngay</a
                                        >

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Carousel End -->

            <!-- Search Start -->
            <form action="./post" method="post">
                <input type="hidden" name="action" value="search-posts">
                <div
                    class="container-fluid bg-primary mb-5 wow fadeIn"
                    data-wow-delay="0.1s"
                    style="padding: 35px"
                    >
                    <div class="container">
                        <div class="row g-2 d-flex justify-content-around">
                            <div class="col-md-10">
                                <div class="row g-2 d-flex justify-content-around">
                                    <div class="col-md-8">
                                        <input
                                            type="text"
                                            class="form-control border-0"
                                            name="keyword"
                                            placeholder="Tìm kiếm theo tên vị trí..."
                                            />
                                    </div>
                                    <div class="col-md-4">
                                        <select class="form-select border-0" name="statusID">
                                            <option value="2">Pending</option>
                                            <option value="3" selected>Hiring</option>
                                            <option value="4">Closed</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-dark border-0 w-100">Tìm kiếm</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- Search End -->

            <!-- Jobs Start -->
            <div class="container-xxl py-5">
                <div class="container">
                    <h1 class="text-center mb-5 wow fadeInUp" data-wow-delay="0.1s">
                        Danh sách việc làm
                    </h1>
                    <div class="tab-class text-center wow fadeInUp" data-wow-delay="0.3s">
                        <ul
                            class="nav nav-pills d-inline-flex justify-content-center border-bottom mb-5"
                            >
                            <li class="nav-item">
                                <a
                                    class="d-flex align-items-center text-start mx-3 ms-0 pb-3 active"
                                    data-bs-toggle="pill"
                                    href="#tab-1"
                                    >
                                    <h6 class="mt-n1 m-0">Đề xuất</h6>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="d-flex align-items-center text-start mx-3 pb-3"
                                    data-bs-toggle="pill"
                                    href="#tab-2"
                                    >
                                    <h6 class="mt-n1 mb-0">Toàn thời gian</h6>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="d-flex align-items-center text-start mx-3 me-0 pb-3"
                                    data-bs-toggle="pill"
                                    href="#tab-3"
                                    >
                                    <h6 class="mt-n1 mb-0">Bán thời gian</h6>
                                </a>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane fade show p-0 active">
                                <div class="row g-3">
                                    <c:if test="${not empty requestScope.highestQuantity}">
                                        <c:forEach var="post" items="${requestScope.highestQuantity}" varStatus="status">
                                            <div class="job-item py-4 px-2 mb-3 col-6">
                                                <div class="row g-4">
                                                    <div class="col-sm-12 col-md-6 d-flex align-items-center">

                                                        <div class="text-start ps-4">
                                                            <h5 class="mb-3">${post.positionName}</h5>
                                                            <span class="text-truncate me-3"
                                                                  ><i
                                                                    class="fa fa-map-marker-alt text-primary me-2"
                                                                    ></i
                                                                >${post.address}</span
                                                            >
                                                            <span class="text-truncate me-3"
                                                                  ><i class="far fa-clock text-primary me-2"></i>
                                                                <c:if test="${post.formID == 1}">Full Time - Offline</c:if>
                                                                <c:if test="${post.formID == 2}">Full Time - Online</c:if>
                                                                <c:if test="${post.formID == 3}">Full Time - Hybrid</c:if>
                                                                <c:if test="${post.formID == 4}">Part Time - Offline</c:if>
                                                                <c:if test="${post.formID == 5}">Part Time - Online</c:if>
                                                                <c:if test="${post.formID == 6}">Part Time - Hybrid</c:if>
                                                                </span
                                                                >
                                                                <span class="text-truncate me-0"
                                                                      ><i
                                                                        class="far fa-money-bill-alt text-primary me-2"
                                                                        ></i
                                                                    >${post.salary}</span
                                                            >
                                                        </div>
                                                    </div>
                                                    <div
                                                        class="col-sm-12 col-md-6 d-flex flex-column align-items-start align-items-md-end justify-content-center"
                                                        >
                                                        <div class="d-flex mb-3">
                                                            <a class="btn btn-light btn-square me-3" href=""
                                                               ><i class="far fa-heart text-primary"></i
                                                                ></a>
                                                            <a class="btn btn-primary" href="">Ứng tuyển ngay</a>
                                                        </div>
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Date Line: ${post.expiredDate}</small
                                                        >
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                                <div class="p-3">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <li class="page-item">
                                                <a class="page-link" href="./post?action=more-recommended">Xem thêm</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div id="tab-2" class="tab-pane fade show p-0">
                                <div class="row g-3">
                                    <c:if test="${not empty requestScope.fulltime}">
                                        <c:forEach var="post" items="${requestScope.fulltime}" varStatus="status">
                                            <div class="job-item py-4 px-2 mb-3 col-6">
                                                <div class="row g-4">
                                                    <div class="col-sm-12 col-md-6 d-flex align-items-center">

                                                        <div class="text-start ps-4">
                                                            <h5 class="mb-3">${post.positionName}</h5>
                                                            <span class="text-truncate me-3"
                                                                  ><i
                                                                    class="fa fa-map-marker-alt text-primary me-2"
                                                                    ></i
                                                                >${post.address}</span
                                                            >
                                                            <span class="text-truncate me-3"
                                                                  ><i class="far fa-clock text-primary me-2"></i>
                                                                <c:if test="${post.formID == 1}">Full Time - Offline</c:if>
                                                                <c:if test="${post.formID == 2}">Full Time - Online</c:if>
                                                                <c:if test="${post.formID == 3}">Full Time - Hybrid</c:if>
                                                                <c:if test="${post.formID == 4}">Part Time - Offline</c:if>
                                                                <c:if test="${post.formID == 5}">Part Time - Online</c:if>
                                                                <c:if test="${post.formID == 6}">Part Time - Hybrid</c:if>
                                                                </span
                                                                >
                                                                <span class="text-truncate me-0"
                                                                      ><i
                                                                        class="far fa-money-bill-alt text-primary me-2"
                                                                        ></i
                                                                    >${post.salary}</span
                                                            >
                                                        </div>
                                                    </div>
                                                    <div
                                                        class="col-sm-12 col-md-6 d-flex flex-column align-items-start align-items-md-end justify-content-center"
                                                        >
                                                        <div class="d-flex mb-3">
                                                            <a class="btn btn-light btn-square me-3" href=""
                                                               ><i class="far fa-heart text-primary"></i
                                                                ></a>
                                                            <a class="btn btn-primary" href="">Ứng tuyển ngay</a>
                                                        </div>
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Date Line: ${post.expiredDate}</small
                                                        >
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                                <div class="p-3">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <li class="page-item">
                                                <a class="page-link" href="./post?action=more-fulltime">Xem thêm</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                            <div id="tab-3" class="tab-pane fade show p-0">
                                <div class="row g-3">
                                    <c:if test="${not empty requestScope.parttime}">
                                        <c:forEach var="post" items="${requestScope.parttime}" varStatus="status">
                                            <div class="job-item py-4 px-2 mb-3 col-6">
                                                <div class="row g-4">
                                                    <div class="col-sm-12 col-md-6 d-flex align-items-center">

                                                        <div class="text-start ps-4">
                                                            <h5 class="mb-3">${post.positionName}</h5>
                                                            <span class="text-truncate me-3"
                                                                  ><i
                                                                    class="fa fa-map-marker-alt text-primary me-2"
                                                                    ></i
                                                                >${post.address}</span
                                                            >
                                                            <span class="text-truncate me-3"
                                                                  ><i class="far fa-clock text-primary me-2"></i>
                                                                <c:if test="${post.formID == 1}">Full Time - Offline</c:if>
                                                                <c:if test="${post.formID == 2}">Full Time - Online</c:if>
                                                                <c:if test="${post.formID == 3}">Full Time - Hybrid</c:if>
                                                                <c:if test="${post.formID == 4}">Part Time - Offline</c:if>
                                                                <c:if test="${post.formID == 5}">Part Time - Online</c:if>
                                                                <c:if test="${post.formID == 6}">Part Time - Hybrid</c:if>
                                                                </span
                                                                >
                                                                <span class="text-truncate me-0"
                                                                      ><i
                                                                        class="far fa-money-bill-alt text-primary me-2"
                                                                        ></i
                                                                    >${post.salary}</span
                                                            >
                                                        </div>
                                                    </div>
                                                    <div
                                                        class="col-sm-12 col-md-6 d-flex flex-column align-items-start align-items-md-end justify-content-center"
                                                        >
                                                        <div class="d-flex mb-3">
                                                            <a class="btn btn-light btn-square me-3" href=""
                                                               ><i class="far fa-heart text-primary"></i
                                                                ></a>
                                                            <a class="btn btn-primary" href="">Ứng tuyển ngay</a>
                                                        </div>
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Date Line: ${post.expiredDate}</small
                                                        >
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                                <div class="p-3">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <li class="page-item">
                                                <a class="page-link" href="./post?action=more-parttime">Xem thêm</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                        <!-- Jobs End -->

                    </div>

                </div>

            </div>
            <!-- footers -->
            <jsp:include page="../footer/footer.jsp" />


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
               ><i class="bi bi-arrow-up"></i
                ></a>
        </div>

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
