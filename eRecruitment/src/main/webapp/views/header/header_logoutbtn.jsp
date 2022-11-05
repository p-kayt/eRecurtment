<%-- 
    Document   : header_logoutbtn
    Created on : Oct 31, 2022, 10:35:34 AM
    Author     : ASUS
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
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
        <header>
            <!-- navi -->
            <nav
                class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0"
                >
                <a
                    href="home"
                    class="navbar-brand d-flex align-items-center text-center py-0 px-4 px-lg-5"
                    >
                    <h1 class="m-0 text-primary">eRecruitment</h1>
                </a>
                <button
                    type="button"
                    class="navbar-toggler me-4"
                    data-bs-toggle="collapse"
                    data-bs-target="#navbarCollapse"
                    >
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarCollapse">
                    <div class="navbar-nav ms-auto p-4 p-lg-0">
                        <a href="home" class="nav-item nav-link active">Trang chủ</a>
                        <!--            <div class="nav-item dropdown">
                                          <a
                                            href="#"
                                            class="nav-link dropdown-toggle"
                                            data-bs-toggle="dropdown"
                                            >Jobs</a
                                          >
                                          <div class="dropdown-menu rounded-0 m-0">
                                            <a href="job-list.html" class="dropdown-item">Job List</a>
                                            <a href="job-detail.html" class="dropdown-item">Job Detail</a>
                                          </div>
                                        </div> -->

                        <a href="#" class="nav-item nav-link">Giới thiệu</a>
                        <%UserDTO user = (UserDTO) session.getAttribute("user");%>

                        <c:choose>
                            <c:when test = "${user.getUserRole() == 1}">
                                <a href="./common-interview?action=showCandidatePendingInterview" class="nav-item nav-link">Lịch phỏng vấn</a>
                            </c:when>
                            <c:when test = "${user.getUserRole() == 2}">
                                <a href="./interview?action=showCreatedInterview" class="nav-item nav-link">Lịch phỏng vấn</a>
                            </c:when>
                            <c:when test = "${user.getUserRole() == 4}">
                                <a href="./common-interview?action=showInterviewerPendingInterview" class="nav-item nav-link">Lịch phỏng vấn</a>
                            </c:when>
                        </c:choose>

                        <a href="profile" class="nav-item nav-link">Hồ sơ</a>
                        <c:if test = "${user.getUserRole() == 1}">
                            <a href="" class="nav-item nav-link">Xem CV</a>
                        </c:if>
                        <c:if test = "${user.getUserRole() == 2 || user.getUserRole() == 3}">
                            <a href="./job?action=position-list" class="nav-item nav-link">Quản lý tuyển dụng</a>
                        </c:if>
                        <c:if test = "${user.getUserRole() == 3}">
                            <a href="./ManagerViewCandidates?txtSearch=&action=All" class="nav-item nav-link">Phê duyệt ứng viên</a>
                        </c:if>
                        <c:if test = "${user.getUserRole() == 5}">
                            <a href="./adminViewUser?txtSearch=&action=All" class="nav-item nav-link">Quản lý các user</a>
                        </c:if>
                        <a href="logout" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">
                            Đăng xuất
                        </a>
                    </div>

            </nav>
            <!-- Navbar End -->
        </header>
    </body>
</html>
