<%-- 
    Document   : interview-list-HRStaff
    Created on : Nov 2, 2022, 5:26:48 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang = "vi">
    <head>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>

        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Danh sách các cuộc phỏng vấn đã tạo</title>

    </head>
    <body>
        <header>
            <!-- navi -->
            <nav
                class="navbar navbar-expand-xl navbar-expand-sm justify-content-center"
                >
                <button
                    class="navbar-toggler bg-dark col-6"
                    type="button"
                    data-toggle="collapse"
                    data-target="#Navbar"
                    aria-controls="Navbar"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
                    >
                    <span class="navbar-toggler-icon"></span>
                </button>
                <!--  -->
                <div class="collapse navbar-collapse col-8" id="Navbar">
                    <ul class="navbar-nav mr-auto d-flex flex-row">
                        <li class="nav-item active col-6">
                            <!-- logo img -->
                            <a class="nav-link" href="home"
                               ><span class="fa fa-home fa-lg bg-dark"></span>Home</a
                            >
                        </li>

                        <li class="nav-item col-4">
                            <a class="nav-link hyper" href="#">Section 1</a>
                        </li>

                        <li class="nav-item col-4">
                            <a class="nav-link hyper" href="#">Section 2</a>
                        </li>

                        <li class="nav-item col-4">
                            <a class="nav-link hyper" href="#">Section 3</a>
                        </li>
                    </ul>
                </div>

                <div>
                    <c:if test="${empty user}">
                        <a href="login">
                            <span class="fa fa-sign-in"></span>Login
                        </a>
                    </c:if>
                    <c:if test="${not empty user}">
                        <a href="logout">
                            <span class="fa fa-sign-in"></span>Logout
                        </a>
                    </c:if>
                </div>
            </nav>

        </header>

        <section>
            <div>
                <h2>Các cuộc phỏng vấn đã tạo</h2>
            </div>

        </section>




    </body>
</html>
