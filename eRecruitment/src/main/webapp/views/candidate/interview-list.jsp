<%-- 
    Document   : interview-list-HRStaff
    Created on : Nov 2, 2022, 5:26:48 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang = "vi">
    <head>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>

        <meta charset="UTF-8" />
        <title>Lịch sử phỏng vấn</title>
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

        <link rel="stylesheet" href="css/style_profile.css"/>
        <!--css/style-dltemp.css-->

    </head>
    <body>
        <div class="container-xxl bg-white p-0">
            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>
            <c:choose>
                <c:when test = "${user.userRole == 1}">
                    <ul class="nav nav-tabs bg-dark row pt-2 justify-content-start mx-auto">
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0" href="./common-interview?action=showCandidatePendingInterview">Các cuộc phỏng vấn sắp diễn ra</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0  active" href="./common-interview?action=showCandidateInterviewHistory">Lịch sử phỏng vấn</a>
                        </li>
                    </ul>
                </c:when>
                <c:when test = "${user.userRole == 4}">
                    <ul class="nav nav-tabs bg-dark row pt-2 justify-content-start mx-auto">
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0" href="./common-interview?action=showInterviewerPendingInterview">Các cuộc phỏng vấn sắp diễn ra</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0  active" href="./common-interview?action=showInterviewerInterviewHistory">Lịch sử phỏng vấn</a>
                        </li>
                    </ul>
                </c:when>
                <c:when test = "${user.userRole == 2}">
                    <ul class="nav nav-tabs bg-dark row pt-2 justify-content-between mx-auto">
                        <li class="nav-item col-auto">
                            <a class="nav-link  py-3 fw-bold border-0 ${action == 'showCreatedInterview' ? 'active' :'' }"  href="./interview?action=showCreatedInterview">Các cuộc phỏng vấn đã tạo</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0 ${action == 'showPendingInterview' ? 'active' :'' }" aria-current="page" href="./interview?action=showPendingInterview">Các cuộc phỏng vấn đang chờ</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0 ${action == 'showInterviewHisory' ? 'active' :'' }" href="./interview?action=showInterviewHisory">Các cuộc phỏng vấn đã xảy ra</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0 ${action == 'showInterviewerPendingInterview' ? 'active' :'' }" href="./common-interview?action=showInterviewerPendingInterview">Các cuộc phỏng vấn sắp diễn ra</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0 ${action == 'showInterviewerInterviewHistory' ? 'active' :'' }" href="./common-interview?action=showInterviewerInterviewHistory">Lịch sử phỏng vấn</a>
                        </li>
                    </ul>
                </c:when>
            </c:choose>
            <section>

                <c:choose>
                    <c:when test= "${not empty InterviewList}">
                        <c:choose>
                            <c:when test="${(InterviewList.size() == 0)}">
                                <div class="alert alert-secondary alert-dismissible fade show" role="alert">
                                    Chưa có cuộc phỏng vấn nào
                                </div>
                            </c:when>  
                            <c:otherwise>
                                <!--                                <h3>Danh sách các cuộc phỏng vấn</h3>-->
                                <div class="border border-1 m-5 p-4 shadow">
                                    <c:forEach items="${InterviewList}" var="p" varStatus="loop">
                                        <div class="border border-1 mb-4 p-3 shadow d-flex flex-column">

                                            <div class="d-flex flex-row m-2 justify-content-end align-items-center">
                                                <!--chia trang jsp : này là history-->
                                                <c:if test = "${user.userRole == 1}"> 
                                                    <c:if test = "${not empty listResultOfCandidate}">
                                                        <div class="col-3">
                                                            <c:forEach items="${listResultOfCandidate}" begin="${loop.index}" end="${loop.index}" step="1" var="result">
                                                                <p class="text-white fw-bold bg-primary p-2 text-center">Trạng thái: ${result}</p>
                                                            </c:forEach>
                                                        </div>
                                                    </c:if>
                                                </c:if>

                                                <c:forEach items="${listInterviewStatus}" begin="${loop.index}" end="${loop.index}" step="1" var="status">
                                                    <p class="col-2 bg-primary text-white text-center p-1" id="status">${status}</p>
                                                </c:forEach>

                                            </div>


                                            <%--Hiển thị kết quả phỏng vấn của ứng viên nếu hành động là sem lịch sử phỏng vấn--%>

                                            <c:if test = "${user.userRole == 1}"> 
                                                <c:if test = "${not empty listResultOfCandidate}">
                                                    <c:forEach items="${listResultOfCandidate}" begin="${loop.index}" end="${loop.index}" step="1" var="result">
                                                        <p>${result}</p>
                                                    </c:forEach>
                                                </c:if>
                                            </c:if>

                                            <%--Hiển thị kết quả phỏng vấn của ứng viên nếu hành động là xem lịch sử phỏng vấn--%>
                                            <div class="row g-2 m-1 mx-3 fs-5 fw-bolder text-dark">
                                                <label class="col-2 fw-bold"  for="stage">Vòng</label>
                                                <c:forEach items="${listInterviewStage}" begin="${loop.index}" end="${loop.index}" step="1" var="stage">
                                                    <p class="col-6" id="stage">${stage.split(";")[1]}</p>
                                                </c:forEach>
                                            </div>
                                            <div class="d-flex flex-column m-0 mx-3 text-dark">
                                                <label class="col-2 fw-bold fs-5" for="description">Mô tả</label>
                                                <textarea class="col-11 m-auto my-3" id="description" rows="4" disabled>${p.getDescription()}</textarea>

                                            </div>
                                            <div class="row g-2 m-1 mx-3 fs-6 text-dark">
                                                <label class="col-2 fw-bold fs-5" for="time">Thời gian</label>
                                                <p class="col-4" id="time"><c:choose>
                                                        <c:when test = "${user.userRole == 1}">
                                                            <c:forEach items="${candidateInterviewTime}" begin="${loop.index}" end="${loop.index}" step="1" var="time">
                                                                ${time}
                                                            </c:forEach>
                                                        </c:when>

                                                        <c:otherwise>
                                                            ${p.getTime()}
                                                        </c:otherwise>
                                                    </c:choose></p>
                                            </div>

                                            <div class="row g-2 m-1 mx-3">
                                                <a class="text-decoration-underline" href="post?action=post-detail&postID=${p.postID}" target="_blank">Xem bài đăng tuyển dụng</a>
                                            </div>
                                            <form class="d-flex justify-content-end m-2" action="common-interview" method="post" >

                                                <input type="hidden" name="postID" value="${p.getPostID()}">
                                                <input type="hidden" name="interviewID" value="${p.getInterviewID()}">

                                                <c:choose>
                                                    <c:when test = "${user.userRole == 1}">
                                                        <input type="hidden" name="action" value="showCandidateInterviewDetail">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input type="hidden" name="option" value="${option}">
                                                        <input type="hidden" name="action" value="showInterviewerInterviewDetail">
                                                    </c:otherwise>
                                                </c:choose>


                                                <input class="btn btn-primary" type="submit" value="Chi tiết">
                                            </form>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </c:when>    
                    <c:otherwise>
                        <div class="alert alert-secondary alert-dismissible fade show" role="alert">
                            Chưa có cuộc phỏng vấn nào
                        </div>
                        <!--                        <div style="height: 100px"></div>-->
                    </c:otherwise>
                </c:choose>

            </section>
            <jsp:include page="../footer/footer.jsp" />
        </div>



        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!--Javascript -->
        <script src="js/main.js"></script>

    </body>
</html>
