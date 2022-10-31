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

        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <div class="container-xxl bg-white p-0"> 

            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>

            <section>
                <form action = "interview" method = "post" id = "form1">
                    <div cq>
                        <div class="col-12 d-flex flex-row">
                            <span>Hình thức</span>
                            <input type="radio" id="online" name="format" value="1" checked>
                            <label for="online">Online</label>

                            <input type="radio" id="ofline" name="format" value="2">
                            <label for="ofline">Offline</label>

                        </div>

                        <label for = "link">Link</label>
                        <input type = "url" name="link" id="link" >

                        <label for="address" >Địa chỉ</label>
                        <input type="text" name="address" id="address" >


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
                    </div>
                </form>

                <label for="description">Mô tả</label> <br />
                <textarea rows="4" cols="60" name="description" form="form1">${description}</textarea>
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
