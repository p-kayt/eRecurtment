<%-- 
    Document   : interview-modify
    Created on : Oct 24, 2022, 4:02:04 PM
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

        <title><c:if test="${not empty user}"><%=user.getFirstName()%> <%=user.getLastName()%></c:if></title>

            <link
                rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
                integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
                crossorigin="anonymous"
                />
            <link rel="stylesheet" href="css/style_profile.css" />
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
            <form action = "interview" method = "post" id = "form1">
                <label for="format">Hình thức</label>
                <select id = "format" name= "format">
                    <option value = "1" selected>Offline</option>
                    <option value="2">Online</option>
                </select> <br />
                <label for = "link">Link</label>
                <input type = "url" name="link" id="link" > <br/>

                <label for="address" >Địa chỉ</label>
                <input type="text" name="address" id="address" > <br />

                <label for="date" >Ngày</label>
                <input type="date" name="date" value = "${date}" required> <br/>

                <label for="time">Giờ</label>
                <input type="time" name="time" value = "${time}" required> <br/>
                
                <label for="maxCandidate">Số ứng viên tối đa</label>
                <input type="number" name="maxCandidate" min="1" value = "${(maxCandidate == null) ? 10 : maxCandidate}" required> <br/>

                <label for="stage">Vòng phỏng vấn</label>
                <select name = "stage" id="stage">
                    <option value = "1" ${stage == 1 ? "selected" : ""}>Vòng 1</option>
                    <option value = "2" ${stage == 2 ? "selected" : ""}>Vòng 2</option>
                    <option value = "3" ${stage == 3 ? "selected" : ""}>Vòng 3</option>
                </select>   <br/>

                <input type ="hidden" name="action" value="bookInteview">
                <input type = "hidden" name = "postID" value = "1">

                <input type="submit" value = "Đặt lịch"> <br/><br/>
            </form>

            <label for="description">Mô tả</label> <br />
            <textarea rows="4" cols="60" name="description" form="form1">${description}</textarea>
        </section>
        
        <section>
            <h1>Date time</h1>
            <p>${datetime}</p>
        </section>


        <!--Check format: if format is offline then link is require, else, address is require-->
        <!--        <script>
                    function checkFormat(id) {
                        var f = document.getElementById(id);
                        
                    }
                </script>-->
    </body>
</html>
