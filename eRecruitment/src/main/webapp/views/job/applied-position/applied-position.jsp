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
        <title>Danh sách ứng tuyển</title>
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

            <div class="tab-class text-center mt-4" >

                <!--xài nav như này thì k cần cái script button nữa :v--> 

                <!--                <button class="btn btn-primary border-0" onclick="chooseTab(1)">In-progress</button>
                                <button class="btn btn-primary border-0" onclick="chooseTab(2)">Has complete</button>
                                <button class="btn btn-primary border-0" onclick="chooseTab(3)">Cancelled</button>-->
                <!--nav as btn-->
                <ul
                    class="nav nav-pills d-inline-flex justify-content-center border-bottom mb-5"
                    >
                    <li class="nav-item">
                        <a
                            class="d-flex align-items-center text-start mx-3 ms-0 pb-3 active"
                            data-bs-toggle="pill"
                            href="#tab-1"
                            >
                            <h6 class="mt-n1 m-0">Đang tiến hành</h6>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a
                            class="d-flex align-items-center text-start mx-3 pb-3"
                            data-bs-toggle="pill"
                            href="#tab-2"
                            >
                            <h6 class="mt-n1 mb-0">Đã hoàn thành</h6>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a
                            class="d-flex align-items-center text-start mx-3 me-0 pb-3"
                            data-bs-toggle="pill"
                            href="#tab-3"
                            >
                            <h6 class="mt-n1 mb-0">Đã huỷ</h6>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="tab-content">
                <!--div as nav-->
                <div id="tab-1" class="tab-pane fade show p-0 bg-transparent active">

                    <div class="job-item py-4 px-2 mb-3 bg-transparent" >
                        <c:if test="${empty requestScope.appList}">
                            <p>Bạn không có ứng tuyển nào đang diễn ra</p>
                        </c:if>
                        <c:forEach var="i"  items="${requestScope.appList}" varStatus="loop">
                            <c:forEach var="j"  items="${requestScope.postList}" varStatus="loop">
                                <c:if test="${i.postID == j.postID}">
                                    <c:if test="${i.getStatusID()==1}">
                                        <a style="display: block"  href="./application?action=view-application-detail&appID=${i.id}&postID=${i.postID}&stageID=${i.stageID}" target="_blank">
                                            <div class="job-item py-4 px-2 mb-3 border border-1">
                                                <div class="row g-4 justify-content-around" >
                                                    <div class="col-sm-12 col-md-5 d-flex align-items-center">

                                                        <div class="text-start ps-4 col-11"   name="tab_element">
                                                            <h5 class="mb-3">${j.getPositionName()}</h5>
                                                            <p>${i.getApplyDate()}</p>
                                                            <p style="color: yellowgreen">In-progress </p>
                                                        </div>
                                                    </div>
                                                    <div
                                                        class="col-sm-12 col-md-5 d-flex flex-column align-items-start align-items-md-end justify-content-center align-middle"
                                                        >
                                                        <div class="d-flex mb-3">
                                                            <form action="application" method="get" onsubmit="cancelAlert()">
                                                                <input name="action" value="cancel-application" style="display: none"></input>
                                                                <input name="appID" value="${i.id}" style="display: none"></input>
                                                                <button class="btn btn-danger" type="submit">Huỷ ứng tuyển</button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </div>



                <!--div as nav-->
                <div id="tab-2" class="tab-pane fade show bg-transparent p-0"> 

                    <div class="job-item py-4 px-2 mb-3 bg-transparent" id="tab3">
                        <c:if test="${empty requestScope.appList}">
                            <p>Bạn chưa hoàn thành ứng tuyển nào</p>
                        </c:if>
                        <c:forEach var="i"  items="${requestScope.appList}" varStatus="loop">
                            <c:forEach var="j"  items="${requestScope.postList}" varStatus="loop">
                                <c:if test="${i.postID == j.postID}">
                                    <c:if test="${i.getStatusID()==3 || i.getStatusID()==4}">
                                        <a style="display: block"  href="./application?action=view-application-detail&appID=${i.id}&postID=${i.postID}&stageID=${i.stageID}" target="_blank">
                                            <div class="job-item py-4 px-2 mb-3 border border-1">
                                                <div class="row g-4 justify-content-around" >
                                                    <div class="col-sm-12 col-md-6 d-flex align-items-center">

                                                        <div class="text-start ps-4"   name="tab_element">
                                                            <h5 class="mb-3">${j.getPositionName()}</h5>
                                                            <p>${i.getApplyDate()}</p>
                                                            <p style="color: red"><c:if test="${i.getStatusID()==3}">Fail</c:if></p>
                                                            <p style="color: green"><c:if test="${i.getStatusID()==4}">Success</c:if></p>
                                                            </div>
                                                        </div>
                                                        <div
                                                            class="col-sm-12 col-md-5 d-flex flex-column align-items-start align-items-md-end justify-content-center align-middle"
                                                            >
                                                            <div class="d-flex mb-3">
                                                                <a class="btn btn-danger" href="" style="visibility: hidden">Cancel</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </a>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:forEach>

                    </div>
                </div>

                <!--div as nav-->
                <div id="tab-3" class="tab-pane fade show bg-transparent p-0">

                    <div class="job-item py-4 px-2 mb-3 bg-transparent" id="tab2" >
                        <c:if test="${empty requestScope.appList}">
                            <p>Bạn chưa huỷ ứng tuyển nào</p>
                        </c:if>
                        <c:forEach var="i"  items="${requestScope.appList}" varStatus="loop">
                            
                            <c:forEach var="j"  items="${requestScope.postList}" varStatus="loop">
                                <c:if test="${i.postID == j.postID}">
                                    <c:if test="${i.getStatusID()==2}">
                                        <a style="display: block"  href="./application?action=view-application-detail&appID=${i.id}&postID=${i.postID}&stageID=${i.stageID}" target="_blank">
                                            <div class="job-item py-4 px-2 mb-3 border border-1">
                                                <div class="row g-4 justify-content-around" >
                                                    <div class="col-sm-12 col-md-5 d-flex align-items-center">

                                                        <div class="text-start ps-4 col-11"   name="tab_element">
                                                            <h5 class="mb-3">${j.getPositionName()}</h5>
                                                            <p>${i.getApplyDate()}</p>
                                                            <p style="color: gray">Cancelled </p>
                                                        </div>
                                                    </div>    
                                                    <div
                                                        class="col-sm-12 col-md-5 d-flex flex-column align-items-start align-items-md-end justify-content-center align-middle"
                                                        >
                                                        <div class="d-flex mb-3">
                                                            <a class="btn btn-danger" href="" style="visibility: hidden">Cancel</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </a>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>


        <jsp:include page="../../footer/footer.jsp" />


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top" 
           ><i class="bi bi-arrow-up"></i
            ></a>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!--Javascript -->
        <script src="js/main.js"></script>
        <script>
            function cancelAlert() {
                alert("Bạn đã huỷ ứng tuyển thành công, hãy xem lại trong tab đã huỷ!");
            }

        </script>
    </body>
</html>
