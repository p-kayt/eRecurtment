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
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title>Danh sách các cuộc phỏng vấn sắp diễn ra</title>

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
                            <a class="nav-link py-3 fw-bold border-0 active" href="./common-interview?action=showCandidatePendingInterview">Các cuộc phỏng vấn sắp diễn ra</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0" href="./common-interview?action=showCandidateInterviewHistory">Lịch sử phỏng vấn</a>
                        </li>
                    </ul>
                </c:when>
                <c:when test = "${user.userRole == 4}">
                    <ul class="nav nav-tabs bg-dark row pt-2 justify-content-start mx-auto">
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0 active" href="./common-interview?action=showInterviewerPendingInterview">Các cuộc phỏng vấn sắp diễn ra</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0" href="./common-interview?action=showInterviewerInterviewHistory">Lịch sử phỏng vấn</a>
                        </li>
                    </ul>
                </c:when>
                <c:when test = "${user.userRole == 2}">
                    <ul class="nav nav-tabs bg-dark row pt-2 justify-content-between mx-auto">
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0" href="./interview?action=showCreatedInterview">Các cuộc phỏng vấn đã tạo</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0" id="pending-interview" href="./interview?action=showPendingInterview" onclick="changeTab()">Các cuộc phỏng vấn đang chờ</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0" id="happend-interview" href="./interview?action=showInterviewHisory" onclick="changeTab()">Các cuộc phỏng vấn đã xảy ra</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0 active" href="./common-interview?action=showInterviewerPendingInterview">Các cuộc phỏng vấn sắp diễn ra</a>
                        </li>
                        <li class="nav-item col-auto">
                            <a class="nav-link py-3 fw-bold border-0" href="./common-interview?action=showInterviewerInterviewHistory">Lịch sử phỏng vấn</a>
                        </li>
                    </ul>
                </c:when>
            </c:choose>
            <section>

                <c:choose>
                    <c:when test= "${not empty InterviewList}">
                        <c:choose>
                            <c:when test="${(InterviewList.size() == 0)}">
                                <p>Chưa có cuộc phỏng vấn nào. list rong</p>
                            </c:when>  
                            <c:otherwise>
                                <!--                                <h3>Danh sách các cuộc phỏng vấn</h3>-->
                                <div class="border border-1 m-5 p-4 shadow">
                                    <c:forEach items="${InterviewList}" var="p" varStatus="loop">
                                        <div class="border border-1 mb-5 p-4 shadow d-flex flex-column">
                                            <div class="row g-2 m-1 mx-3">
                                                <label class="col-2 fw-bold" for="status">Trạng thái</label>
                                                <c:forEach items="${listInterviewStatus}" begin="${loop.index}" end="${loop.index}" step="1" var="status">
                                                    <p class="col-4" id="status">${status}<p>
                                                    </c:forEach>
                                            </div>
                                            <%--Hiển thị kết quả phỏng vấn của ứng viên nếu hành động là sem lịch sử phỏng vấn--%>

                                            <c:if test = "${user.userRole == 1}"> 
                                                <c:if test = "${not empty listResultOfCandidate}">
                                                    <c:forEach items="${listResultOfCandidate}" begin="${loop.index}" end="${loop.index}" step="1" var="result">
                                                        <p>${result}<p>
                                                        </c:forEach>
                                                    </c:if>
                                                </c:if>

                                                <%--Hiển thị kết quả phỏng vấn của ứng viên nếu hành động là xem lịch sử phỏng vấn--%>
                                            <div class="row g-2 m-1 mx-3">
                                                <label class="col-2 fw-bold"  for="stage">Vòng</label>
                                                <c:forEach items="${listInterviewStage}" begin="${loop.index}" end="${loop.index}" step="1" var="stage">
                                                    <p class="col-4" id="stage">${stage}<p>
                                                    </c:forEach>
                                            </div>
                                            <div class="d-flex flex-column m-1 mx-3">
                                                <label class="col-2 fw-bold " for="description">Mô tả</label>
                                                <textarea class="col-11 m-auto" id="description" rows="4" >${p.getDescription()}</textarea>

                                            </div>
                                            <div class="row g-2 m-1 mx-3 ">
                                                <label class="col-2 fw-bold" for="time">Thời gian</label>
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



<!--                                            <p>This is post detail  ${p.getPostID()}</p>-->
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
                        <p>Chưa có cuộc phỏng vấn nào. list null</p>
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
