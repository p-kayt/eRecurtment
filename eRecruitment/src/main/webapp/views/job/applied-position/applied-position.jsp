<%-- 
    Document   : applied-job
    Created on : Nov 5, 2022, 12:05:18 AM
    Author     : Huu Minh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Applied position</title>
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
            <c:if test="${empty sessionScope.user}">
                <jsp:include page="../../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <jsp:include page="../../header/header_logoutbtn.jsp" />
            </c:if>
            
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
                                    <h6 class="mt-n1 mb-0">Full Time</h6>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a
                                    class="d-flex align-items-center text-start mx-3 me-0 pb-3"
                                    data-bs-toggle="pill"
                                    href="#tab-3"
                                    >
                                    <h6 class="mt-n1 mb-0">Part Time</h6>
                                </a>
                            </li>
                        </ul>

                        <div class="tab-content">
                            <div id="tab-1" class="tab-pane fade show p-0 active">
                                <div class="row g-3">
                                    <c:if test="${not empty requestScope.highestQuantity}">
                                        <c:forEach var="post" items="${requestScope.highestQuantity}" varStatus="status">
                                            <div class="job-item py-4 px-2 mb-3 col-6">
                                                <div class="row g-4" onclick="location.href='./post?action=post-detail&postID=${post.postID}'">
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
                                                            <a class="btn btn-primary" href="./post?action=apply-for-post&postID=${post.postID}">Ứng tuyển ngay</a>
                                                        </div>
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Bắt Đầu: ${post.startDate}</small
                                                        >
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Đóng: ${post.expiredDate}</small
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
                                                <div class="row g-4" onclick="location.href='./post?action=post-detail&postID=${post.postID}'">
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
                                                            <a class="btn btn-primary" href="./post?action=apply-for-post&postID=${post.postID}">Ứng tuyển ngay</a>
                                                        </div>
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Bắt Đầu: ${post.startDate}</small
                                                        >
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Đóng: ${post.expiredDate}</small
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
                                                <div class="row g-4" onclick="location.href='./post?action=post-detail&postID=${post.postID}'">
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
                                                            <a class="btn btn-primary" href="./post?action=apply-for-post&postID=${post.postID}">Ứng tuyển ngay</a>
                                                        </div>
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Bắt Đầu: ${post.startDate}</small
                                                        >
                                                        <small class="text-truncate"
                                                               ><i class="far fa-calendar-alt text-primary me-2"></i
                                                            >Đóng: ${post.expiredDate}</small
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
        </div>
    </body>
</html>
