<%-- 
    Document   : interview-list-HRStaff
    Created on : Nov 2, 2022, 5:26:48 PM
    Author     : MINH TRI
--%>

<%@page import="javax.servlet.jsp.jstl.core.LoopTagStatus"%>
<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang = "vi">
    <head>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <meta charset="utf-8" />
        <title>Danh sách các cuộc phỏng vấn đã tạo</title>
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


            <ul class="nav nav-tabs bg-dark row pt-2 justify-content-between mx-auto">
                <li class="nav-item col-auto">
                    <a class="nav-link active py-3 fw-bold border-0" aria-current="page" href="./interview?action=showCreatedInterview">Các cuộc phỏng vấn đã tạo</a>
                </li>
                <li class="nav-item col-auto">
                    <a class="nav-link py-3 fw-bold border-0" href="./interview?action=showPendingInterview">Các cuộc phỏng vấn đang chờ</a>
                </li>
                <li class="nav-item col-auto">
                    <a class="nav-link py-3 fw-bold border-0" href="./interview?action=showInterviewHisory">Các cuộc phỏng vấn đã xảy ra</a>
                </li>
                <li class="nav-item col-auto">
                    <a class="nav-link py-3 fw-bold border-0" href="./common-interview?action=showInterviewerPendingInterview">Các cuộc phỏng vấn sắp diễn ra</a>
                </li>
                <li class="nav-item col-auto">
                    <a class="nav-link py-3 fw-bold border-0" href="./common-interview?action=showInterviewerInterviewHistory">Lịch sử phỏng vấn</a>
                </li>
            </ul>




            <section>
                <c:choose>
                    <c:when test = "${user.userRole == 2 || user.userRole == 3}">
                        <c:choose>
                            <c:when test= "${not empty InterviewList}">
                                <c:choose>
                                    <c:when test="${InterviewList.size() == 0}">
                                        <p>Hiện tại chưa có cuộc phỏng vấn nào.</p>
                                    </c:when>  
                                    <c:otherwise>

                                        <div class="border border-1 m-5 p-4 shadow">
                                            <c:forEach items="${InterviewList}" var="c" varStatus="loop">
                                                <div class="border border-1 mb-5 p-4 shadow d-flex flex-column">
                                                    <div class="row g-2 m-1 mx-3">
                                                        <a href="post?action=post-detail&postID=${c.postID}" target="_blank">Xem bài đăng tuyển dụng</a>
                                                    </div>
                                                    <div class="row g-2 m-1 mx-3">
                                                        <label class="col-2 fw-bold" for="status">Trạng thái</label>
                                                        <c:forEach items="${listInterviewStatus}" begin="${loop.index}" end="${loop.index}" step="1" var="status">
                                                            <p class="col-4" id="status">${status}<p>
                                                            </c:forEach>
                                                    </div>
                                                    <div class="row g-2 m-1 mx-3">
                                                        <label class="col-2 fw-bold"  for="stage">Vòng</label>
                                                        <c:forEach items="${listInterviewStage}" begin="${loop.index}" end="${loop.index}" step="1" var="stage">
                                                            <p class="col-4" id="stage">${stage.split(";")[1]}<p>
                                                            </c:forEach>
                                                    </div>
                                                    <div class="d-flex flex-column m-1 mx-3">
                                                        <label class="col-2 fw-bold " for="description">Mô tả</label>
                                                        <textarea class="col-11 m-auto" id="description" rows="4" disabled>${c.getDescription()}</textarea>

                                                    </div>
                                                    <div class="row g-2 m-1 mx-3 ">
                                                        <label class="col-2 fw-bold" for="time">Thời gian</label>
                                                        <p class="col-4" id="time">${c.getTime()}</p>
                                                    </div>
<!--                                                        <p>${c.getPostID()}</p>-->

                                                    <form class="d-flex justify-content-end m-2" action="interview" method="post" >
                                                        <input type="hidden" name="action" value="showInterviewDetail">
                                                        <input type="hidden" name="interviewID" value="${c.getInterviewID()}">
                                                        <input class="btn btn-primary" type="submit" value="Chi tiết">
                                                    </form>

                                                    <c:if test= "${c.bookerID == user.userID}">
                                                        <form class="d-flex justify-content-end m-2" action="interview" method="post" >
                                                            <input type="hidden" name="action" value="interviewDetail">
                                                            <input type="hidden" name="postID" value="${c.getPostID()}">
                                                            <input type="hidden" name="interviewID" value="${c.getInterviewID()}">
                                                            <input class="btn btn-primary" type="submit" value="Chỉnh sửa">
                                                        </form>
                                                    </c:if>

                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </c:when>    
                            <c:otherwise>
                                <p>Hiện tại chưa có cuộc phỏng vấn nào.</p>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:otherwise>
                        <h2>Bạn không được phép truy cập trang web này</h2>
                    </c:otherwise>
                </c:choose>
            </section>

        </div>
        <jsp:include page="../footer/footer.jsp" />

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
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
