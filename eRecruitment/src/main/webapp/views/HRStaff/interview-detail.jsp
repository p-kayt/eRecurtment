<%-- 
    Document   : interview-modify
    Created on : Oct 24, 2022, 4:02:04 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.interview.ParticipantDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "vi">
    <head>
        <meta charset="utf-8" />
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <%InterviewDTO interview = (InterviewDTO) request.getAttribute("interview");%>

        <title><c:if test="${not empty user}"><%=user.getFirstName()%> <%=user.getLastName()%></c:if></title>
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


            <section>
                <c:choose>
                    <c:when test = "${user.userRole == 2 || user.userRole == 3}">
                        <div class="container-xxl py-5 bg-dark page-header mb-5">
                            <div class="container my-5 pt-5 pb-4">
                                <h1 class="display-3 text-white mb-3 animated slideInDown">Mô tả bài đăng</h1>
                                <nav aria-label="breadcrumb">
                                    <!--                                                    <ol class="breadcrumb text-uppercase">
                                                                                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                                                                                            <li class="breadcrumb-item text-white active" aria-current="page">Chi tiết</li>
                                                                                        </ol>-->
                                </nav> 
                            </div>
                        </div>
                        <c:if test="${not empty interview}"> 
                            <div class="d-flex flex-column align-middle m-4 p-5 border border-2 shadow">
                                <div class="d-flex flex-column">
                                    <div class="d-flex flex-row m-2">
                                        <div class="d-flex flex-row justify-content-center row g-2 m-1">
                                            <p><a href="post?action=post-detail&postID=${postID}" target="_blank">Xem bài đăng tuyển dụng</a></p>
                                        </div>
                                        <p>${interviewStatus}</p>
                                    </div>
                                    <div class="d-flex flex-column m-2">
                                        <p>Tên vòng phỏng vấn:     ${interviewStage.split(";")[1]}</p>

                                        <div style="background: #ccc">
                                            <p>Mô tả</p>
                                            <p>${interview.description}</p>
                                        </div>
                                        <p>Hình thức ${interviewFormat}</p>


                                        <%
                                            String[] datetime = interview.getTime().split("\\s");
                                            String date = datetime[0];
                                            String hour = datetime[1].split("\\.")[0];
                                        %>
                                        <p>Ngày    <%=date%></p>
                                        <p>Giờ     <%=hour%></p>

                                        <c:choose>
                                            <c:when test="${interviewFormat == 'Online'}">
                                                <div class="col-11 row g-2 m-1 justify-content-center">
                                                    <p>Link     ${interview.link}</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="col-11 row g-2 m-1 justify-content-center">
                                                    <p>Địa chỉ     ${interview.address}</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="col-11 row g-2 m-1 justify-content-center">
                                            <p>Người tạo    ${booker.firstName} ${booker.lastName}</p>
                                            <p>Email: ${booker.email}</p>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column m-2 p-2 border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <p>Người phỏng vấn</p>
                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="${not empty listInterviewer}">
                                                <c:forEach items="${listInterviewer}" var="i">
                                                    <div class="d-flex flex-row justify-content-between align-center border border-2 m-1 bg-light">
                                                        <div class="col-6 d-flex flex-row text-center">
                                                            <div class="col-3 d-flex justify-content-center">
                                                                <img class="ava_img_icon m-2 border border-1" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>
                                                            <div class="col-9 text-start align-center m-auto">
                                                                <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                            </div>
                                                            <div class="col-9 text-start align-center m-auto">
                                                                <p>Email: ${i.email}</p>
                                                            </div>
                                                        </div>
                                                        <div class="col-4"></div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column m-2 p-2  border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <p>Ứng viên</p>
                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="${not empty listCandidate}">
                                                <c:forEach items="${listCandidate}" var="i" varStatus="loop">
                                                    <div class="d-flex flex-row justify-content-between align-center border border-2 m-1 bg-light">
                                                        <div class="col-6 d-flex flex-row text-center">
                                                            <div class="col-3 d-flex justify-content-center">
                                                                <img class="ava_img_icon m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>
                                                            <div class="col-6 text-start align-center m-auto">
                                                                <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                            </div>
                                                            <div class="col-3 text-start align-center m-auto">
                                                                <a href = "job?action=view-candidate-cv&userID=${i.userID}" target="_blank">Xem CV</a>
                                                            </div>
                                                            <div class="col-4 text-start align-center m-auto"> 
                                                                <c:forEach items="${listParticipant}" var="p">
                                                                    <c:if test="${p.userID == i.userID}">
                                                                        <p>Giờ ${p.interviewTime.split("\\s")[1].split("\\.")[0]}</p>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </div>
                                                            <div class="col-4 text-start align-center m-auto">
                                                                <c:forEach items="${result}" begin="${loop.index}" end="${loop.index}" step="1" var="r">
                                                                    <p>${r}<p>
                                                                    </c:forEach>
                                                            </div>
                                                            <div class="col-4 text-start align-center m-auto">
                                                                <form action="evaluate" target="_blank" method="post">
                                                                    <input type="hidden" name="evaluateAction" value="viewCandidatEvaluation">
                                                                    <input type="hidden" name="interviewID" value="${interview.interviewID}">
                                                                    <input type="hidden" name="candidateID" value="${i.userID}">
                                                                    <input type="submit" value="Xem đánh giá">
                                                                </form>
                                                            </div>
                                                            <div class="col-9 text-start align-center m-auto"> 

                                                            </div>
                                                        </div>

                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column m-2 p-2  border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <p>Ứng viên miễn phỏng vấn</p>

                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="${not empty listNoInterviewCandidate}">
                                                <c:forEach items="${listNoInterviewCandidate}" var="i">
                                                    <div class="d-flex flex-row justify-content-between align-center border border-2 m-1 bg-light">
                                                        <div class="col-6 d-flex flex-row text-center">
                                                            <div class="col-3 d-flex justify-content-center">
                                                                <img class="ava_img" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>
                                                            <div>
                                                                <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                            </div>
                                                            <div class="col-9 text-start align-center m-auto">
                                                                <a href = "job?action=view-candidate-cv&userID=${i.userID}" target="_blank">Xem CV</a>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-secondary alert-dismissible fade show d-flex justify-content-between" role="alert">
                            Bạn không được phép truy cập trang web này
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>


        </div>
        <jsp:include page="../footer/footer.jsp" />
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


    </body>
</html>

<!--InterviewDTO(interviewID, description, formatID, link, address, time, stageID, postID, statusID, bookerID);-->