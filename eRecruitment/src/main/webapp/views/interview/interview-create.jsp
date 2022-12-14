<%-- 
    Document   : interview-modify
    Created on : Oct 24, 2022, 4:02:04 PM
    Author     : MINH TRI
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "vi">
    <head>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <%ArrayList<String> interviewFormat = (ArrayList<String>) request.getAttribute("interviewFormat");%>
        <meta charset="utf-8" />
        <title><c:if test="${not empty user}"><%=user.getFirstName()%> <%=user.getLastName()%></c:if></title>
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

            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>



            <div class="container-xxl py-5 bg-dark page-header mb-5">
                <div class="container my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">?????t l???ch ph???ng v???n</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb text-uppercase">
                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh s??ch v??? tr??</a></li>
                            <li class="breadcrumb-item"><a href="">Chi ti???t</a></li>
                            <li class="breadcrumb-item"><a href="">Th??ng Tin B??i ????ng Tuy???n D???ng</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">?????t l???ch ph???ng v???n</li>
                        </ol>
                    </nav> 
                </div>
            </div>
            <div>
                <c:choose>
                    <c:when test = "${user.userRole == 2 || user.userRole == 3}">
                        <div class="d-flex flex-column m-auto my-4 col-10 border border-1 shadow p-4 pb-5">
                            <form class="m-auto col-10" action = "interview" method = "get" id = "form1">
                                <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                    <a class="col-11 text-decoration-underline fw-bold" href="post?action=post-detail&postID=${postID}" target="_blank">Xem b??i ????ng tuy???n d???ng</a>
                                </div>
                                <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                    <label class="col-3" for="format">H??nh th???c</label>
                                    <!--                                    <div class="col-2 d-flex flex-row" id="fomat">
                                    <c:if test ="<%=(interviewFormat != null)%>" >
                                        <c:forEach items="<%=interviewFormat%>" var="i" varStatus="count">
                                            <input class="col-2" type="radio" name="format" value = "${count.index + 1}" id="${count.index + 1}" ${(format == (count.index + 1)) ? "selected" : ""}>
                                            <label for="${count.index + 1}">${i}</label>
                                        </c:forEach>
                                    </c:if>
                                </div>-->
                                    <select class="col-6 p-1 formatcheck" id ="format" name= "format">
                                        <c:if test ="<%=(interviewFormat != null)%>" >
                                            <c:forEach items="<%=interviewFormat%>" var="i" varStatus="count">
                                                <option value = "${count.index + 1}" ${(format == (count.index + 1)) ? "selected" : ""}>${i}</option>   
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                    <span class="col-2"></span>
                                </div>
                                <!--
                                                                <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                <c:choose>
                                    <c:when test="${interviewFormat == 'Online'}">
                                        <label class="col-3" for = "link">Link</label>
                                        <input class="col-8" type = "url" name="link" id="link" >
                                    </c:when>
                                    <c:otherwise>
                                        <label class="col-3" for="address" >?????a ch???</label>
                                        <input class="col-8" type="text" name="address" id="address" >

                                    </c:otherwise>
                                </c:choose>

                            </div>-->

                                <div class="d-flex flex-row justify-content-center row g-2 m-1 " id="online">
                                    <label class="col-3" for = "link">Link</label>
                                    <input class="col-8" type = "url" name="link" id="link" >
                                </div>
                                <div class="d-flex flex-row justify-content-center row g-2 m-1 " id="offline">
                                    <label class="col-3" for="address" >?????a ch???</label>
                                    <input class="col-8" type="text" name="address" id="address" >
                                </div>
                                <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                    <label class="col-3" for="date" >Ng??y</label>
                                    <input class="col-4" type="date" name="date" value = "${date}" required>
                                    <span class="col-4"></span>

                                </div>
                                <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                    <label class="col-3" for="time">Gi???</label>
                                    <input class="col-4" type="time" name="time" value = "${time}" required>
                                    <span class="col-4"></span>
                                </div>
                                <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                    <label class="col-3" for="maxCandidate">S??? ???ng vi??n t???i ??a</label>
                                    <input class="col-4" type="number" name="maxCandidate" min="1" value = "${(maxCandidate == null) ? 10 : maxCandidate}" required>
                                    <span class="col-4"></span>
                                </div>
                                <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                    <label class="col-3" for="stage">V??ng ph???ng v???n</label>
                                    <select class="col-6"  id="stage" disabled>
                                        <option value = "${interviewStage.split(";")[0]}">${interviewStage.split(";")[1]}</option>   
                                    </select>
                                    <input type="hidden" name = "stage" value="${interviewStage.split(";")[0]}">
                                    <span class="col-2"></span>
                                </div>
                                <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                    <label class="col-3" for="description">M?? t???</label>
                                    <textarea class="col-8" rows="4" name="description" form="form1">${description}</textarea>

                                </div>
                                <input type ="hidden" name="action" value="bookInteview">
                                <input type = "hidden" name = "postID" value = "${postID}">
                                <div class="row g-1 mt-4">
                                    <input class="btn btn-primary col-2 m-auto" type="submit" value = "?????t l???ch">
                                </div>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <h2>B???n kh??ng c?? quy???n ?????t l???ch ph???ng v???n</h2>
                    </c:otherwise>
                </c:choose>
            </div>





        </div>
        <jsp:include page="../footer/footer.jsp" />


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <!--Check format: if format is offline then link is require, else, address is require-->
<!--        <script>
           console.log( document.querySelector('#format').value == 1)
            $(document).ready(function () {
                
                if (document.querySelector('#format').value == 2)
                    (
                            console.log(document.querySelector('#format').value)

                            )
            });

        </script>-->
    </script>
</body>
</html>
