<%-- 
    Document   : header_loginbtn
    Created on : Oct 31, 2022, 10:34:13 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8" />
        <title>ERecruitment</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="" name="keywords" />
        <meta content="" name="description" />

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
                        <!-- <div class="nav-item dropdown">
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

                        <a href="login" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">
                            <span>Đăng nhập</span>
                        </a>
                    </div>

            </nav>
            <!-- Navbar End -->
        </header>
    </body>
</html>
