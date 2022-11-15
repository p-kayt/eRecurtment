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

            <c:if test="${not empty requestScope.msg}">
                <div class="alert alert-secondary alert-dismissible fade show d-flex justify-content-between" role="alert">
                    ${requestScope.msg}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>

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
            <c:if test="${not empty requestScope.post.stageList and not empty requestScope.appList}">
                <c:forEach var="stage" items="${requestScope.post.stageList}" varStatus="stageLoop">
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4 pb-5 mb-3">
                        <div  class="d-flex flex-column mb-2">
                            <div class="m-auto fs-4 fw-bold">
                                <span>Vòng</span>
                                <c:if test="${stage.stageID == 1}"><span>CV Applying</span></c:if>
                                <c:if test="${stage.stageID == 2}"><span>Interview</span></c:if>
                                <c:if test="${stage.stageID == 3}"><span>Finish</span></c:if>
                                <c:if test="${stage.stageID == 4}"><span>Final Evaluation</span></c:if>

                                </div>
                                <p class="text-muted m-auto">${stage.description}</p>
                        </div>
                        <div class="d-flex flex-row justify-content-center">
                            <c:if test="${stage.stageID == 2}">
                                <!-- Form chua thong tin de tao buoi phong van Interview -->
                                <div class="col-3 m-1 text-center">
                                    <span class="btn btn-primary" onclick="document.getElementById('createInterviewForm${stageLoop.index}').submit()">Tạo buổi phỏng vấn</span>
                                </div>
                                <!--  -->
                                <form action="interview" method="get" id="createInterviewForm${stageLoop.index}" target="_blank">
                                    <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                    <input type="hidden" name="stage" value="${stage.id}">
                                    <input class="d-none" type="submit" value="Tạo buổi phỏng vấn">
                                </form>
                            </c:if>

                            <c:if test="${not empty stage.interviewList}">
                                <form class="col-3 m-1 text-center" action="interview" target="_blank" method="post">
                                    <input type="hidden" name="action" value="showInterviewByPostStage">
                                    <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                    <input type="hidden" name="stage" value="${stage.id}">
                                    <input class="btn btn-info" type="submit" value="Danh sách phỏng vấn">
                                </form>
                            </c:if>

                        </div>
                        <c:if test="${stage.stageID == 2}">
                            <p>Ứng viên cần phải được thêm vào các buổi phỏng vấn đã tạo để có thể xét duyệt và xem đánh giá của ứng viên</p>
                        </c:if>
                        <div class="d-flex flex-column justify-content-center">
                            <table class="table table-hover table-bordered">
                                <thead>
                                    <tr class="col-12 rounded-9 justify-content-around">
                                        <th scope="col" class="col-1 text-center align-middle">ID</th>
                                        <th scope="col" class="col-2 text-center align-middle">Ngày Ứng Tuyển</th>
                                        <th scope="col" class="col-2 text-center align-middle">CV Ứng Viên</th>
                                        <th scope="col" class="col-2 text-center align-middle">Trạng Thái</th>

                                        <th scope="col" class="col-2 text-center align-middle">Xét Duyệt</th>
                                            <c:if test="${not empty stage.interviewList}">
                                            <th scope="col" class="col-2 text-center align-middle">Xem Đánh Giá PV</th>
                                            </c:if>
                                            <c:if test="${stage.stageID == 3 || stage.stageID == 4}">
                                            <th scope="col" class="col-2 text-center align-middle">Xem Đánh Giá PV</th>
                                            </c:if>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${not empty requestScope.appList}">
                                        <c:forEach var="app" items="${requestScope.appList}" varStatus="appLoop">
                                            <c:if test="${stage.id == app.stageID}">
                                                <tr class="col-12 rounded-9 justify-content-around">
                                                    <td scope="col" class="col-1 text-center align-middle">${app.id}</td>
                                                    <td scope="col" class="col-1 text-center align-middle">${app.applyDate}</td>
                                                    <td scope="col" class="col-1 text-center align-middle">
                                                        <a class="btn btn-info" href="./job?action=view-candidate-cv&userID=${app.userID}" target="_blank">Xem CV</a>
                                                    </td>
                                                    <td scope="col" class="col-1 text-center align-middle">
                                                        <c:if test="${app.statusID == 1}">In-progress</c:if>
                                                        <c:if test="${app.statusID == 2}">Cancelled</c:if>
                                                        <c:if test="${app.statusID == 3}">Fail</c:if>
                                                        <c:if test="${app.statusID == 4}">Success</c:if>
                                                        </td>
                                                        <!-- ========================== CV Applying ========================== -->
                                                        <!-- If Candidate application is waiting for staff's review -->
                                                    <c:if test="${stage.stageID == 1 and app.statusID == 1}">
                                                        <td scope="col" class="col-1 text-center align-middle">
                                                            <span class="btn btn-danger" onclick="document.getElementById('rejectCVForm').submit()">Từ Chối</span>
                                                            <span class="btn btn-success" onclick="document.getElementById('approveCVForm').submit()">Duyệt</span>
                                                        </td>
                                                <form id="rejectCVForm" action="./job" method="post">
                                                    <input type="hidden" name="action" value="reject-cv">
                                                    <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                                    <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                                    <input type="hidden" name="appID" value="${app.id}">
                                                </form>
                                                <form id="approveCVForm" action="./job" method="post">
                                                    <input type="hidden" name="action" value="approve-cv">
                                                    <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                                    <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                                    <input type="hidden" name="appID" value="${app.id}">
                                                    <input type="hidden" name="stageOffset" value="${stageLoop.count}">
                                                </form>
                                            </c:if>
                                            <!-- If Candidate application is waiting for staff's review -->
                                            <!-- ========================== CV Applying ========================== -->


                                            <!-- ========================== Application Status ========================== -->
                                            <!-- If Candidate cancel the application -->
                                            <c:if test="${app.statusID == 2}">
                                                <td scope="col" class="col-1 text-center align-middle">
                                                    Đã Hủy
                                                </td>
                                            </c:if>
                                            <!-- If Candidate cancel the application -->

                                            <!-- If Staff reject the candidate's application -->
                                            <c:if test="${app.statusID == 3}">
                                                <td scope="col" class="col-1 text-center align-middle">
                                                    Rớt
                                                </td>
                                            </c:if>
                                            <!-- If Staff reject the candidate's application -->

                                            <!-- If Staff reject the candidate's application -->
                                            <c:if test="${app.statusID == 4}">
                                                <td scope="col" class="col-1 text-center align-middle">
                                                    Đậu
                                                </td>
                                            </c:if>
                                            <!-- If Staff reject the candidate's application -->
                                            <!-- ========================== Application Status ========================== -->


                                            <!-- ========================== Interview ========================== -->
                                            <!-- If Stage is an interview stage but does not have Interview -->
                                            <c:if test="${stage.stageID == 2 and empty stage.interviewList}">
                                                <td scope="col" class="col-1 text-center align-middle">
                                                    Vòng Chưa Có Buổi Phỏng Vấn
                                                </td>
                                            </c:if>
                                            <!-- If Stage is an interview stage but does not have Interview -->

                                            <!-- If Stage is an interview stage and has Interview -->
                                            <c:if test="${stage.stageID == 2 and not empty stage.interviewList}">
                                                <c:forEach var="itv" items="${stage.interviewList}" varStatus="loopItv">
                                                    <c:forEach var="par" items="${itv.participantList}" varStatus="loopPar">
                                                        <c:if test="${par.userID == app.userID}">
                                                            <c:if test="${app.statusID == 1}">
                                                                <td scope="col" class="col-1 text-center align-middle">
                                                                    <form id="reject-pass-interview" action="./job" method="post">
                                                                        <input type="hidden" name="action" value="reject-pass-interview">
                                                                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                                                        <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                                                        <input type="hidden" name="appID" value="${app.id}">
                                                                        <input type="hidden" name="itvID" value="${itv.interviewID}">
                                                                        <input type="hidden" name="userID" value="${app.userID}">
                                                                        <input class="btn btn-danger" type="submit" value="Từ Chối">
                                                                    </form>
                                                                    <form id="approve-pass-interview" action="./job" method="post">
                                                                        <input type="hidden" name="action" value="approve-pass-interview">
                                                                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                                                        <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                                                        <input type="hidden" name="appID" value="${app.id}">
                                                                        <input type="hidden" name="itvID" value="${itv.interviewID}">
                                                                        <input type="hidden" name="stageOffset" value="${stageLoop.count}">
                                                                        <input type="hidden" name="userID" value="${app.userID}">
                                                                        <input class="btn btn-success" type="submit" value="Duyệt">
                                                                    </form>
                                                                </td>
                                                            </c:if>
                                                            <td scope="col" class="col-1 text-center align-middle">
                                                                <form action="evaluate" target="_blank" method="post">
                                                                    <input type="hidden" name="evaluateAction" value="viewCandidatEvaluation">
                                                                    <input type="hidden" name="interviewID" value="${itv.interviewID}">
                                                                    <input type="hidden" name="candidateID" value="${app.userID}">
                                                                    <input class="btn btn-info" type="submit" value="Xem đánh giá">
                                                                </form>
                                                            </td>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:forEach>

                                            </c:if>
                                            <!-- If Stage is an interview stage and has Interview -->
                                            <!-- ========================== Interview ========================== -->


                                            <!-- ========================== Final Evaluation ========================== -->
                                            <c:if test="${stage.stageID == 4}">
                                                <c:if test="${app.statusID == 1}">
                                                    <td scope="col" class="col-1 text-center align-middle">
                                                        <form id="reject-final-evaluation" action="./job" method="post">
                                                            <input type="hidden" name="action" value="reject-final-evaluation">
                                                            <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                                            <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                                            <input type="hidden" name="appID" value="${app.id}">
                                                            <input type="hidden" name="userID" value="${app.userID}">
                                                            <input class="btn btn-danger" type="submit" value="Từ Chối">
                                                        </form>
                                                        <form id="approve-final-evaluation" action="./job" method="post">
                                                            <input type="hidden" name="action" value="approve-final-evaluation">
                                                            <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                                            <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                                            <input type="hidden" name="appID" value="${app.id}">
                                                            <input type="hidden" name="stageOffset" value="${stageLoop.count}">
                                                            <input type="hidden" name="userID" value="${app.userID}">
                                                            <input class="btn btn-success" type="submit" value="Duyệt">
                                                        </form>
                                                    </td>
                                                </c:if>
                                                <td scope="col" class="col-1 text-center align-middle">
                                                    <form action="evaluate" target="_blank" method="post">
                                                        <input type="hidden" name="evaluateAction" value="viewCandidateEvaluationInAPost">
                                                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                                        <input type="hidden" name="candidateID" value="${app.userID}">
                                                        <input class="btn btn-info" type="submit" value="Xem đánh giá">
                                                    </form>
                                                </td>
                                            </c:if>

                                            <!-- ========================== Final Evaluation ========================== -->

                                            <!-- ========================== Finish ========================== -->
                                            <c:if test="${stage.stageID == 3}">
                                                <td scope="col" class="col-1 text-center align-middle">
                                                    <form action="evaluate" target="_blank" method="post">
                                                        <input type="hidden" name="evaluateAction" value="viewCandidateEvaluationInAPost">
                                                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                                        <input type="hidden" name="candidateID" value="${app.userID}">
                                                        <input class="btn btn-info" type="submit" value="Xem đánh giá">
                                                    </form>
                                                </td>
                                            </c:if>
                                            <!-- ========================== Finish ========================== -->


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
                </c:forEach>


                <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4 pb-5 mb-3">
                    <c:set var = "inProgress" value = "${0}"/>
                    <c:set var = "success" value = "${0}"/>
                    <c:set var = "fail" value = "${0}"/>
                    <c:set var = "cancel" value = "${0}"/>
                    <c:forEach var="app" items="${requestScope.appList}" varStatus="loop">
                        <c:if test="${app.statusID == 1}"><c:set var = "inProgress" value = "${inProgress + 1}"/></c:if>
                        <c:if test="${app.statusID == 2}"><c:set var = "cancel" value = "${cancel + 1}"/></c:if>
                        <c:if test="${app.statusID == 3}"><c:set var = "fail" value = "${fail + 1}"/></c:if>
                        <c:if test="${app.statusID == 4}"><c:set var = "success" value = "${success + 1}"/></c:if>
                    </c:forEach>

                    <div class="m-auto">
                        <h3>Thống Kê Tuyển Dụng</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">
                        <div class="d-flex flex-row justify-content-around m-2">
                            <label class="col-2 fw-bold">Tổng Số Ứng Viên</label>

                            <span class="col-3 text-center">${requestScope.appList.size()}</span>
                        </div>

                        <div class="d-flex flex-row justify-content-around m-2">
                            <label class="col-2 fw-bold">Đang Tuyển Dụng</label>

                            <span class="col-3 text-center">${inProgress}</span>
                        </div>
                        <div class="d-flex flex-row justify-content-around m-2">
                            <label class="col-2 fw-bold">Đậu</label>

                            <span class="col-3 text-center">${success}</span>
                        </div>
                        <div class="d-flex flex-row justify-content-around m-2">
                            <label class="col-2 fw-bold">Rớt</label>

                            <span class="col-3 text-center">${fail}</span>
                        </div>
                        <div class="d-flex flex-row justify-content-around m-2">
                            <label class="col-2 fw-bold">Hủy</label>

                            <span class="col-3 text-center">${cancel}</span>
                        </div>

                    </div>
                </div>
            </c:if>
            <c:if test="${empty requestScope.post.stageList}">
                <div>
                    <h3>Bài Đăng Chưa Có Các Vòng Tuyển Dụng</h3>
                </div>
            </c:if>
            <c:if test="${empty requestScope.appList}">
                <div>
                    <h3>Bài Đăng Chưa Có Ứng Viên Ứng Tuyển</h3>
                </div>
            </c:if>
            <!-- Content End -->
            <jsp:include page="../../footer/footer.jsp" />
        </div>
        
        <span class="btn btn-primary" onclick="document.getElementById('managing-applications').submit()">Quản lý ứng tuyển</span>
        <form class="col-2 m-3" action="./job" method="post" id="managing-applications">
                        <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                        <input type="hidden" name="action" value="managing-applications">
                        <input class="d-none" type="submit" value="Quản lý ứng tuyển">
                    </form>
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
