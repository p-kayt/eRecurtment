<%-- 
    Document   : candidatelist
    Created on : Oct 31, 2022, 3:08:50 PM
    Author     : Savoy
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Danh sách ứng viên</title>
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
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Danh sách ứng viên</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb text-uppercase">
                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách ứng viên</a></li>
                        </ol>
                    </nav> 
                </div>
            </div>
            <div
                class="container-fluid bg-primary mb-5 wow fadeIn"
                data-wow-delay="0.1s"
                style="padding: 35px"
                >
                <div class="container">
                    <form action = "./ManagerViewCandidates" method = "POST">
                        <div class="row g-2 d-flex justify-content-start">
                            <div class="col-md-6">
                                <input type="text" class="form-control border-0" placeholder="Tìm kiếm" name = "txtSearch" value = "${requestScope.SearchValue}"/>
                            </div>
                            <div class="col-md-3 d-flex flex-row justify-content-around">
                                <input class="btn btn-dark col-5" type = "SUBMIT" name = "action" value = "Search">
                                <input class="btn btn-dark col-5" type = "SUBMIT" name = "action" value = "All">
                            </div>

                        </div>
                    </form>
                </div>
            </div>

            <div>
                <h4>
                    <c:if test = "${requestScope.AppResult != 'Undo' && requestScope.AppResult != null}">
                        Candidate ${requestScope.FirstName} ${requestScope.LastName}'s application has been ${requestScope.AppResult}
                    </c:if>
                </h4>
            </div>

            <c:if test = "${empty requestScope.Candidates}">
                <h4>${requestScope.nullMsg}</h4>  
            </c:if>

            <c:if test = "${not empty requestScope.Candidates}">
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr class="tb_head col-12 rounded-9 justify-content-around">
                            <th scope="col" class="col-1 text-center pb-4">User ID</th>
                            <th scope="col" class="col-3 pb-4">Email</th>
                            <th scope="col" class="col-2 pb-4">First Name</th>
                            <th scope="col" class="col-1 pb-4">Last Name</th>
                            <th scope="col" class="col-1 text-center pb-4">View resume</th>
                            <th scope="col" class="col-2 text-center pb-4">Application Status</th>
                            <th scope="col" class="col-2 text-center pb-4">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var = "current" items="${requestScope.Candidates}" varStatus = "status" >
                            <tr>
                                <th scope="row" class="align-middle text-center"> ${current.getUserID()} </td>
                                <td class="align-middle"> ${current.getEmail()} </td>
                                <td class="align-middle"> ${current.getFirstName()} </td>
                                <td class="align-middle"> ${current.getLastName()} </td>
                                <td class="align-middle text-center"> ${current.getGender()} </td>
                                

                                <td class="align-middle text-center">${current.getAppStatus()} </td>
                                <td class="align-middle d-flex flex-column">
                                    <form action = "./ManagerAcceptDecline" method = "POST" id = "Change Status_${current.getEmail()}"></form>
                                    <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "Change Status_${current.getEmail()}">
                                    <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Change Status_${current.getEmail()}">
                                    <c:if test = "${current.getAppStatus() == 'In-progress'}">
                                        <form action = "./ManagerViewCandidateEvaluation" method ="POST" id = "View Evaluation_${current.getEmail()}"></form>
                                        <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "View Evaluation_${current.getEmail()}">
                                        <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "View Evaluation_${current.getEmail()}">
                                        <input type = "HIDDEN" name = "FirstName" value= "${current.getFirstName()}" form = "View Evaluation_${current.getEmail()}">
                                        <input type = "HIDDEN" name = "LastName" value= "${current.getLastName()}" form = "View Evaluation_${current.getEmail()}">
                                        <input class="btn btn-light border border-1 m-1" type = "SUBMIT" name = "action" value = "View Interview Result" form = "View Evaluation_${current.getEmail()}">

                                        <input type = "HIDDEN" name = "FirstName" value= "${current.getFirstName()}" form = "Change Status_${current.getEmail()}">
                                        <input type = "HIDDEN" name = "LastName" value= "${current.getLastName()}" form = "Change Status_${current.getEmail()}">
                                        <input class="btn btn-primary m-1" type = "SUBMIT" name = "action" value = "Accept" form = "Change Status_${current.getEmail()}">
                                        <input class="btn btn-dark m-1" type = "SUBMIT" name = "action" value = "Decline" form = "Change Status_${current.getEmail()}">
                                    </c:if>
                                    <c:if test = "${current.getAppStatus() == 'Fail'}">
                                        <input type = "SUBMIT" name = "action" value = "Undo" form = "Change Status_${current.getEmail()}">
                                    </c:if>
                                    <c:if test = "${current.getAppStatus() == 'Success'}">
                                        <input type = "SUBMIT" name = "action" value = "Undo" form = "Change Status_${current.getEmail()}">
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>                

            </c:if>
        </div>
        <jsp:include page="../footer/footer.jsp" />


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>

    <!-- JavaScript Libraries -->
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
