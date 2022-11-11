<%-- 
    Document   : search-post-result
    Created on : Nov 3, 2022, 9:55:37 AM
    Author     : MSI GF63
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.application.ApplicationDTO"%>
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
        <div class="container-xxl bg-white p-0" >
            <c:if test="${empty sessionScope.user}">
                <jsp:include page="../../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <jsp:include page="../../header/header_logoutbtn.jsp" />
            </c:if>

            <div class="" >
                <button onclick="chooseTab(1)">In-progress</button>
                <button onclick="chooseTab(2)">Has complete</button>
                <button onclick="chooseTab(3)">Cancelled</button>



                <div class="job-item py-4 px-2 mb-3" id="tab1">
                    <c:forEach var="i"  items="${requestScope.appList}" varStatus="loop">
                        <c:forEach var="j"  items="${requestScope.postList}" varStatus="loop">
                            <c:if test="${i.postID == j.postID}">
                                <c:if test="${i.getStatusID()==1}">
                                    <div class="row g-4 justify-content-around" >
                                        <div class="col-sm-12 col-md-6 d-flex align-items-center">

                                            <div class="text-start ps-4"   name="tab_element">
                                                <h5 class="mb-3">${j.getPositionName()}</h5>
                                                <p>${i.getApplyDate()}</p>
                                                <p>In-progress </p>
                                                <a class="btn btn-primary" href="./application?action=cancel-application&appID=${i.id}">Cancel</a>                                                
                                            </div>
                                        </div>

                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </div>


                <div class="job-item py-4 px-2 mb-3" id="tab2" style="display: none">
                    <c:forEach var="i"  items="${requestScope.appList}" varStatus="loop">
                        <c:forEach var="j"  items="${requestScope.postList}" varStatus="loop">
                            <c:if test="${i.postID == j.postID}">
                                <c:if test="${i.getStatusID()==2}">
                                    <div class="row g-4 justify-content-around" >
                                        <div class="col-sm-12 col-md-6 d-flex align-items-center">

                                            <div class="text-start ps-4"   name="tab_element">
                                                <h5 class="mb-3">${j.getPositionName()}</h5>
                                                <p>${i.getApplyDate()}</p>
                                                <p>Cancelled</p>
                                            </div>
                                        </div>

                                    </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </div>


                <div class="job-item py-4 px-2 mb-3" id="tab3" style="display: none">
                    <c:forEach var="i"  items="${requestScope.appList}" varStatus="loop">
                        <c:forEach var="j"  items="${requestScope.postList}" varStatus="loop">
                            <c:if test="${i.postID == j.postID}">
                                <c:if test="${i.getStatusID()==3 || i.getStatusID()==4}">
                                    <div class="row g-4 justify-content-around" >
                                        <div class="col-sm-12 col-md-6 d-flex align-items-center">

                                            <div class="text-start ps-4"   name="tab_element">
                                                <h5 class="mb-3">${j.getPositionName()}</h5>
                                                <p>${i.getApplyDate()}</p>
                                                <p><c:if test="${i.getStatusID()==3}">Fail</c:if>
                                                    <c:if test="${i.getStatusID()==4}">Success</c:if></p>
                                                </div>
                                            </div>

                                        </div>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </c:forEach>

                </div>



                <jsp:include page="../../footer/footer.jsp" />


                <!-- Back to Top -->
                <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top" 
                   ><i class="bi bi-arrow-up"></i
                    ></a>
                <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

                <script src="lib/wow/wow.min.js"></script>
                <script src="lib/easing/easing.min.js"></script>
                <script src="lib/waypoints/waypoints.min.js"></script>
                <script src="lib/owlcarousel/owl.carousel.min.js"></script>


            </div>
    </body>
    <!--Javascript -->
    <script src="js/main.js"></script>
    <script>

                    var inProgress = document.getElementById("tab1");
                    var cancelled = document.getElementById("tab2");
                    var complete = document.getElementById("tab3");
                    function chooseTab(tab) {

                        inProgress.style = "display:none";
                        cancelled.style = "display:none";
                        complete.style = "display:none";
                        switch (tab) {
                            case 1:
                                inProgress.style = "display:block";
                                break;
                            case 2:
                                cancelled.style.display = "display:block";
                                break;
                            case 3:
                                complete.style.display = "display:block";
                                break;

                            default:

                                break;
                        }
                    }

    </script>
</html>
