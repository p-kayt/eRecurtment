<%-- 
    Document   : search-post-result
    Created on : Nov 3, 2022, 9:55:37 AM
    Author     : MSI GF63
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Tìm kiếm bài đăng</title>
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

            <div class="container-xxl py-5 bg-dark page-header">
                <div class="container my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Tìm Kiếm Bài Đăng</h1>

                </div>
            </div>
            <!-- Search Start -->
            <form action="./post" method="post">
                <input type="hidden" name="action" value="advanced-search-posts">
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
                                            placeholder="Tìm kiếm theo tên..."
                                            value="${requestScope.keyword}"
                                            />
                                    </div>
                                    <div class="col-md-4">
                                        <input
                                            type="text"
                                            class="form-control border-0"
                                            name="salary"
                                            placeholder="Nhập mức lương..."
                                            value="${requestScope.salary}"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <button class="btn btn-dark border-0 w-100">Tìm kiếm</button>
                            </div>
                        </div>
                        <div class="col-md-10 d-flex">
                            <div class="col-8 d-flex row g-2 "> 
                                <div class="col-md-6">
                                    <label class="text-white">Trạng thái</label>
                                    <select class="form-select border-0" name="statusID">
                                        <option value="2" <c:if test="${requestScope.statusID == 2}">selected</c:if>>Đang chờ</option>
                                        <option value="3" <c:if test="${requestScope.statusID == 3}">selected</c:if>>Đang tuyển</option>
                                        <option value="4" <c:if test="${requestScope.statusID == 4}">selected</c:if>>Đã đóng</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="text-white" for="workingForm">Hình thức làm việc</label>
                                        <select class="form-select border-0" name="workingForm" id="workingForm">
                                            <option value="1" <c:if test="${requestScope.workingForm == 1}">selected</c:if>>Tất cả</option>
                                        <option value="2" <c:if test="${requestScope.workingForm == 2}">selected</c:if>>Full Time</option>
                                        <option value="3" <c:if test="${requestScope.workingForm == 3}">selected</c:if>>Part Time</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-4 align-items-center mx-2 px-1">
                                    <label class="text-white" for="dateOrder">Sắp xếp theo</label>
                                    <select class="form-select border-0" name="dateOrder" id="dateOrder">
                                        <option value="1" <c:if test="${requestScope.dateOrder == 1}">selected</c:if>>Ngày đóng tuyển dụng</option>
                                    <option value="2" <c:if test="${requestScope.dateOrder == 2}">selected</c:if>>Ngày bắt đầu tuyển dụng</option>
                                    </select>
                                </div>
                                <!--                                <span class="col-2"></span>-->
                            </div>
                        </div>
                    </div>
                </form>
                <!-- Search End -->
            <c:if test="${not empty requestScope.postList}">
                <div class="search-item">

                    <div class="row g-1">
                        <c:forEach var="post" items="${requestScope.postList}" varStatus="status">
                            <div class="job-item py-4 px-2 mb-3">
                                <div class="row g-4 justify-content-around"  onclick="location.href = './post?action=post-detail&postID=${post.postID}'">
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
                                        class="col-sm-12 col-md-5 d-flex flex-column align-items-start align-items-md-end justify-content-center align-middle"
                                        >
                                        <c:if test="${post.statusID == 3}">
                                        <div class="d-flex mb-3">
                                            <a class="btn btn-primary" href="./post?action=apply-for-post&postID=${post.postID}">Ứng tuyển ngay</a>
                                        </div>
                                        </c:if>
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
                    </div>
                </div>
            </c:if>
            <c:if test="${empty requestScope.postList}">
                <div class="alert alert-secondary alert-dismissible fade show d-flex flex-row justify-content-between" role="alert">
                    <span>Không Tìm Thấy Bài Đăng Tương Ứng</span>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

            </c:if>

            <jsp:include page="../../footer/footer.jsp" />
        </div>

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!--Javascript -->
        <script src="js/main.js"></script>

    </body>
</html>
