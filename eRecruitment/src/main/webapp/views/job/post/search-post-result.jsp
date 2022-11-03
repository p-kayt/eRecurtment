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
        <div>
            <c:if test="${empty sessionScope.user}">
                <jsp:include page="../../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <jsp:include page="../../header/header_logoutbtn.jsp" />
            </c:if>
            <div>
                <div>
                    <h1>Kết Quả Tìm Kiếm Bài Đăng</h1>
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
                                            placeholder="Tìm kiếm theo tên vị trí..."
                                            value="${requestScope.keyword}"
                                            />
                                    </div>
                                    <div class="col-md-4">
                                        <select class="form-select border-0" name="statusID">
                                            <option value="2" <c:if test="${requestScope.statusID == 2}">selected</c:if>>Pending</option>
                                            <option value="3" <c:if test="${requestScope.statusID == 3}">selected</c:if>>Hiring</option>
                                            <option value="4" <c:if test="${requestScope.statusID == 4}">selected</c:if>>Closed</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <button class="btn btn-dark border-0 w-100">Tìm kiếm</button>
                                </div>
                            </div>
                            <div>
                                <div class="col-md-4">
                                    <input
                                        type="text"
                                        class="form-control border-0"
                                        name="salary"
                                        placeholder="Nhập mức lương..."
                                        value="${requestScope.salary}"/>
                            </div>
                        </div>
                        <div>
                            <div class="col-md-4">
                                <label for="workingForm">Hình thức làm việc</label>
                                <select class="form-select border-0" name="workingForm" id="workingForm">
                                    <option value="1" <c:if test="${requestScope.workingForm == 1}">selected</c:if>>Tất cả</option>
                                    <option value="2" <c:if test="${requestScope.workingForm == 2}">selected</c:if>>Full Time</option>
                                    <option value="3" <c:if test="${requestScope.workingForm == 3}">selected</c:if>>Part Time</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="dateOrder">Sắp xếp theo</label>
                                    <select class="form-select border-0" name="dateOrder" id="dateOrder">
                                        <option value="1" <c:if test="${requestScope.dateOrder == 1}">selected</c:if>>Ngày đóng tuyển dụng</option>
                                    <option value="2" <c:if test="${requestScope.dateOrder == 2}">selected</c:if>>Ngày bắt đầu tuyển dụng</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
                <!-- Search End -->
            <c:if test="${not empty requestScope.postList}">
                <div class="tab-content">
                    <div id="tab-1" class="tab-pane fade show p-0 active">
                        <div class="row g-3">
                            <c:forEach var="post" items="${requestScope.postList}" varStatus="status">
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
                                                <a class="btn btn-primary" href="">Ứng tuyển ngay</a>
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
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty requestScope.postList}">
                <div>
                    <h3>Không Tìm Thấy Bài Đăng Tương Ứng</h3>
                </div>
            </c:if>
        </div>
    </body>
</html>
