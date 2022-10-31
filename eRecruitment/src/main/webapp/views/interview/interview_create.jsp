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
        <meta charset="utf-8" />
        <title>ERecruitment</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="" name="keywords" />
        <meta content="" name="description" />

        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap"
            rel="stylesheet"
            />

        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
            rel="stylesheet"
            />

        <link href="lib/animate/animate.min.css" rel="stylesheet" />
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

        <link href="css/bootstrap.min.css" rel="stylesheet" />

        <link href="css/style-dltemp.css" rel="stylesheet" />
        <!---->
    </head>
    <body>

        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <div class="container-xxl bg-white p-0"> 

            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>

            <section>
                <div class="interview-form d-flex flex-column justify-content-center align-middle m-4 p-5 border border-2 shadow">
                    <form action = "interview" method = "post" id = "form1">

                        <div class="col-5 d-flex flex-row justify-content-between m-2">
                            <span>Hình thức</span>
                            <div>
                                <input type="radio" id="online" name="format" value="1" checked>
                                <label for="online">Online</label>
                            </div>
                            <div>
                                <input type="radio" id="ofline" name="format" value="2">
                                <label for="ofline">Offline</label>
                            </div>
                        </div>

                        <div class="m-2">
                            <label class="col-2" for = "link">Link</label>
                            <input class="col-8" type = "url" name="link" id="link" >
                        </div>

                        <div class="m-2">
                            <label class="col-2" for="address" >Địa chỉ</label>
                            <input class="col-8" type="text" name="address" id="address" >
                        </div>

                        <div class="m-2">
                            <label class="col-2" for="date" >Ngày</label>
                            <input class="col-2" type="date" name="date" value = "${date}" required> <br/>
                        </div>

                        <div class="m-2">
                            <label class="col-2" for="time">Giờ</label>
                            <input class="col-2" type="time" name="time" value = "${time}" required> <br/>
                        </div>

                        <div class="m-2">
                            <label class="col-2" for="maxCandidate">Số ứng viên tối đa</label>
                            <input class="col-2" type="number" name="maxCandidate" min="1" value = "${(maxCandidate == null) ? 10 : maxCandidate}" required> <br/>
                        </div>

                        <div class="m-2">
                            <label class="col-2" for="stage">Vòng phỏng vấn</label>
                            <select class="col-3" name = "stage" id="stage">
                                <option value = "1" ${stage == 1 ? "selected" : ""}>Vòng 1</option>
                                <option value = "2" ${stage == 2 ? "selected" : ""}>Vòng 2</option>
                                <option value = "3" ${stage == 3 ? "selected" : ""}>Vòng 3</option>
                            </select>
                        </div>

                        <div class="m-2">
                            <label for="description">Mô tả</label> <br />
                            <textarea class="col-8" rows="4" cols="60" name="description" form="form1">${description}</textarea>
                        </div>
                        <input type ="hidden" name="action" value="bookInteview">
                        <input type = "hidden" name = "postID" value = "1">

                        <input class="btn btn-primary col-1 m-3" type="submit" value = "Đặt lịch">

                    </form>
                </div>
            </section>

            <section>
                <h1>Date time</h1>
                <p>${datetime}</p>
            </section>
        </div>

        <!--Check format: if format is offline then link is require, else, address is require-->
        <!--        <script>
                    function checkFormat(id) {
                        var f = document.getElementById(id);
                        
                    }
                </script>-->
    </body>
</html>
