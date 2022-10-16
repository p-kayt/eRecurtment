<%-- Document : homepage Created on : Sep 27, 2022, 5:47:58 PM Author : MINH TRI
--%> <%@page import="com.t404notfound.erecruitment.bean.UserDTO"%> <%@page
    contentType="text/html" pageEncoding="UTF-8"%> <%@ taglib prefix="c"
                                                          uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>eRecruitment</title>
            <link
                rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
                integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
                crossorigin="anonymous"
                />
            <link rel="stylesheet" href="../../css/style_home.css" />
        </head>
        <body>
            <%UserDTO user = (UserDTO) session.getAttribute("user");%>
            <%--<jsp:include page="//views/header/header.jsp" ></jsp:include> --%>
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
                <div class="container">
                    <!-- banner -->
                    <!-- carousel -->
                    <div
                        class="bg-dark"
                        style="height: 350px; border: 1px; margin-top: 10px"
                        ></div>
                </div>
            </header>
        </body>
    </html>
