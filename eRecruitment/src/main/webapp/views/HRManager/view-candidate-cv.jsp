<%-- 
    Document   : view-candidate-cv
    Created on : Nov 2, 2022, 7:08:36 PM
    Author     : Savoy
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xem CV</title>
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
            <!--      header with nav -->
            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>

            <div class="container-xxl py-5 bg-dark page-header mb-5">
                <div class="container my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Xem CV</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb text-uppercase">
                            <li class="breadcrumb-item"><a href="ManagerViewCandidates?txtSearch=&action=All">Danh s??ch ???ng vi??n</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Xem CV</li>
                        </ol>
                    </nav> 
                </div>
            </div>

            <c:if test="${requestScope.FirstName != null && requestScope.LastName != null && requestScope.Email != null}">
                <div class="d-flex flex-column m-4">
                    <div class="d-flex flex-column">
                        <h4>CV c???a ${requestScope.FirstName} ${requestScope.LastName}</h4>
                        <h5 class="text-muted">${requestScope.Email}</h5>
                    </div>
                    <div>
                        <form action = "./ManagerAcceptDecline" method = "POST" id = "Change Status"></form>
                        <input type = "HIDDEN" name = "Email" value= "${requestScope.Email}" form = "Change Status">
                        <input type = "HIDDEN" name = "FirstName" value= "${requestScope.FirstName}" form = "Change Status">
                        <input type = "HIDDEN" name = "LastName" value= "${requestScope.LastName}" form = "Change Status">
                        <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Change Status">
                        <c:if test="${requestScope.Status == 'In-progress'}">
                            <input class="btn btn-primary m-1" type = "SUBMIT" name = "action" value = "Ph?? duy???t" form = "Change Status">
                            <input class="btn btn-dark m-1" type = "SUBMIT" name = "action" value = "T??? ch???i" form = "Change Status">
                        </c:if>
                        <c:if test="${requestScope.Status != 'In-progress'}">
                            <input class="btn btn-success m-1" type = "SUBMIT" name = "action" value = "Ho??n t??c k???t qu??? duy???t" form = "Change Status">
                        </c:if>
                        <form action="./ManagerViewCandidates" method ="POST" id = "Back"></form>
                        <input type = "HIDDEN" name = "txtSearch" value= "${requestScope.SearchValue}" form = "Back">
                        <input class="btn btn-success m-1" type = "SUBMIT" name = "action" value = "Quay v??? danh s??ch" form = "Back">
                    </div>
                </div>
            </c:if>

            <jsp:include page="../cv/cv-read.jsp" />

            <jsp:include page="../footer/footer.jsp" />

            <!-- Back to Top -->

        </div>
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!--Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
