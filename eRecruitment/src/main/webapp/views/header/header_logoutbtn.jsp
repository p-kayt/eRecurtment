<%-- 
    Document   : header_logoutbtn
    Created on : Oct 31, 2022, 10:35:34 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <header>
    <!-- navi -->
    <nav
        class="navbar navbar-expand-lg bg-white navbar-light shadow sticky-top p-0"
        >
        <a
            href="index.html"
            class="navbar-brand d-flex align-items-center text-center py-0 px-4 px-lg-5"
            >
            <h1 class="m-0 text-primary">eRrecruitment</h1>
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
                
                <a href="logout" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">
                    Đăng xuất
                </a>
            </div>

    </nav>
    <!-- Navbar End -->
</header>
    </body>
</html>