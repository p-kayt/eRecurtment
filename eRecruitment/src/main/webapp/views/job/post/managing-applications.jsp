<%-- 
    Document   : managing-applications
    Created on : Nov 5, 2022, 12:11:43 AM
    Author     : MSI GF63
--%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản Lý Ứng Tuyển</title>
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
        <link href="../../../css/style-dltemp.css" rel="stylesheet" />
    </head>
    <body>
        <div class="container-xxl bg-white p-0">
            <!-- Header Start -->
            <c:if test="${empty sessionScope.user}">
                <jsp:include page="../../header/header_loginbtn.jsp" />
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <jsp:include page="../../header/header_logoutbtn.jsp" />
            </c:if>
            <!-- Header End -->
            <!-- Breadcrumb Start -->
            <div class="container-xxl py-5 bg-dark page-header mb-5">
                <div class="container my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Quản Lý Ứng Tuyển</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb text-uppercase">
                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                            <li class="breadcrumb-item"><a href="job?id=${requestScope.position.positionID}&action=position-detail">Chi tiết</a></li>
                            <li class="breadcrumb-item"><a href="job?action=staff-post-detail&positionID=${requestScope.position.positionID}&postID=${requestScope.post.postID}">Thông Tin Bài Đăng Tuyển Dụng</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Quản Lý Ứng Tuyển</li>
                        </ol>
                    </nav> 
                </div>
            </div>
            <!-- Breadcrumb End -->
            <!-- Content Start -->
            <c:if test="${not empty requestScope.post.stageList}">
                <c:forEach var="stage" items="${requestScope.post.stageList}" varStatus="loop">
                    <div>
                        <div>
                            <h3>
                                Vòng: 
                                <c:if test="${stage.stageID == 1}">CV Applying</c:if>
                                <c:if test="${stage.stageID == 2}">Interview</c:if>
                                <c:if test="${stage.stageID == 3}">Finish</c:if>
                                <c:if test="${stage.stageID == 4}">Final Evaluation</c:if>
                                </h3>
                            </div>
                            <div>
                                <p>${stage.description}</p>
                        </div>
                        <div>
                            <table>
                                <thead>
                                    <tr class="col-12 rounded-9 justify-content-around">
                                        <th scope="col" class="col-1 text-center align-middle">ID</th>
                                        <th scope="col" class="col-2 text-center align-middle">Ngày Ứng Tuyển</th>
                                        <th scope="col" class="col-2 text-center align-middle">ID Ứng Viên</th>
                                        <th scope="col" class="col-2 text-center align-middle">Trạng Thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${not empty requestScope.appList}">
                                        <c:forEach var="app" items="${requestScope.appList}" varStatus="loop">
                                            <c:if test="${stage.id == app.stageID}">
                                                <tr class="col-12 rounded-9 justify-content-around">
                                                    <td scope="col" class="col-1 text-center align-middle">${app.id}</td>
                                                    <td scope="col" class="col-1 text-center align-middle">${app.applyDate}</td>
                                                    <td scope="col" class="col-1 text-center align-middle"><a href="./job?action=view-candidate-cv&userID=${app.userID}" target="_blank">${app.userID}</a></td>
                                                    <td scope="col" class="col-1 text-center align-middle">
                                                        <c:if test="${app.statusID == 1}">In-progress</c:if>
                                                        <c:if test="${app.statusID == 2}">Cancelled</c:if>
                                                        <c:if test="${app.statusID == 3}">Fail</c:if>
                                                        <c:if test="${app.statusID == 4}">Success</c:if>
                                                        </td>
                                                    </tr>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${empty requestScope.appList}">
                                    <div>
                                        <h3>Bài Đăng Chưa Có Ứng Viên Ứng Tuyển</h3>
                                    </div>
                                </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    </br>
                </c:forEach>
            </c:if>
            <c:if test="${empty requestScope.post.stageList}">
                <div>
                    <h3>Bài Đăng Chưa Có Các Vòng Tuyển Dụng</h3>
                </div>
            </c:if>
            <!-- Content End -->
        </div>
        <!-- Footer Start -->
        <jsp:include page="../../footer/footer.jsp" />
        <!-- Footer End -->
    </body>
</html>
