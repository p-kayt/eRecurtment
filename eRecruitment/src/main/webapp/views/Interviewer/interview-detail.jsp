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
                    <c:when test = "${user.userRole == 2 ||user.userRole == 4}">
                        <div class="container-xxl py-5 bg-dark page-header mb-5">
                            <div class="container my-5 pt-5 pb-4">
                                <h1 class="display-3 text-white mb-3 animated slideInDown">Chi tiết</h1>
                                <nav aria-label="breadcrumb">
                                    <!--                                                    <ol class="breadcrumb text-uppercase">
                                                                                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                                                                                            <li class="breadcrumb-item text-white active" aria-current="page">Chi tiết</li>
                                                                                        </ol>-->
                                </nav> 
                            </div>
                        </div>
                        <c:if test="${not empty interview}"> 
                            <div class="d-flex flex-column justify-content-center align-middle m-4 p-5 border border-2 shadow">
                                <div class="d-flex flex-column">
                                    <div class="d-flex flex-row m-2 align-items-center">
                                        <div class="col-10"> 
                                            <a class="text-decoration-underline fw-bold mx-5 " href="post?action=post-detail&postID=${interview.postID}" target="_blank">Xem bài đăng tuyển dụng</a>
                                        </div>

                                        <div class="col-2">
                                            <p class="text-white fw-bold bg-primary p-2 text-center">${statusName}</p>
                                        </div>
                                    </div>


                                    <div class="d-flex flex-column m-2 pb-5">
                                        <div class="col-11 row g-2 m-1 justify-content-center">
                                            <label class="col-2 fw-bold text-dark" for="stageID">Tên vòng phỏng vấn</label>
                                            <span class="col-4 text-dark">${stageName.split(";")[1]}</span>
                                            <span class="col-4"></span>
                                        </div>

                                        <div class="col-11 row g-2 m-1 justify-content-center">
                                            <label class="col-2 fw-bold text-dark" for="description">Mô tả</label>
                                            <textarea class="col-8 bg-transparent border-1" rows="4" disabled="">${interview.description}</textarea>
                                        </div>

                                        <div class="col-11 row g-2 m-1 justify-content-center">
                                            <label class="col-2 fw-bold text-dark" for="format">Hình thức</label>
                                            <p class="col-8">${formatName}</p>
                                        </div>

                                        <div class="col-11 row g-2 m-1 justify-content-center">
                                            <label class="col-2 fw-bold text-dark" for="date" >Ngày</label>
                                            <span class="col-4">${interview.time.split(' ')[0]}</span>
                                            <span class="col-4"></span>
                                        </div>

                                        <div class="col-11 row g-2 m-1 justify-content-center">
                                            <label class="col-2 fw-bold text-dark" for="date" >Thời gian</label>
                                            <span class="col-4">${interview.time.split(' ')[1]}</span>
                                            <span class="col-4"></span>
                                        </div>

                                        <div class="col-11 row g-2 m-1 justify-content-center">
                                            <c:choose>
                                                <c:when test="${interviewFormat == 'Online'}">
                                                    <label class="col-2 fw-bold text-dark" for = "link">Link</label>
                                                    <span class="col-8" id="link">${interview.link}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <label class="col-2 fw-bold text-dark" for = "address">Địa chỉ</label>
                                                    <span class="col-8" id="address">${interview.address}</span>

                                                </c:otherwise>
                                            </c:choose>

                                        </div>

                                        <div class="col-11 row g-3 m-0 justify-content-center">
                                            <label class="col-2 fw-bold text-dark" for="creator">Người tạo</label>
                                            <span class="col-4 text-dark" id="creator"> ${booker.firstName} ${booker.lastName} </span>
                                            <span class="col-4 text-dark">${booker.email}</span>                                            
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column m-2 p-2 border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <label class="col-3 m-2 px-3 fw-bold">Người phỏng vấn</label>
                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="${not empty listInterviewer}">
                                                <c:forEach items="${listInterviewer}" var="i">
                                                    <div class="d-flex flex-row justify-content-between align-center border border-2 m-1 bg-light">
                                                        <div class="col-10 d-flex flex-row text-center">
                                                            <div class="col-3 d-flex justify-content-center">
                                                                <img class="ava_img_icon m-2 border border-1" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>
                                                            <div class="col-4 text-start align-center m-auto">
                                                                <p class="my-auto">${i.getFirstName()} ${i.getLastName()}</p>
                                                            </div>
                                                            <div class="col-4 text-start align-center m-auto">
                                                                <p class="my-auto">Email: ${i.email}</p>
                                                            </div>
                                                        </div>
                                                        <div class="col-2"></div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column m-2 p-2 border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <label class="col-3 m-2 px-3 fw-bold">Ứng viên</label>
                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="${not empty listCandidate}">
                                                <c:forEach items="${listCandidate}" var="i" varStatus="loop">
                                                    <div class="d-flex flex-row justify-content-around align-center border border-2 m-1 bg-light">
                                                        <div class="col-5 d-flex flex-row justify-content-between">
                                                            <div class="col-5 d-flex justify-content-center">
                                                                <img class="ava_img_icon m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>

                                                            <div class="col-6 d-flex flex-column text-start align-middle m-2">
                                                                <span class="col-12 align-center m-1 fw-bold">${i.getFirstName()} ${i.getLastName()}</span>
                                                                <span class="col-12 m-1">Thời gian: 
                                                                    <c:forEach items="${candidateInterviewTime}" begin="${loop.index}" end="${loop.index}" step="1" var="time">
                                                                        ${time}
                                                                    </c:forEach>
                                                                </span>
                                                                <c:if test ="${user.userRole != 1}">
                                                                    <a class="m-1 col-12" href = "cv?action=viewCVOfACandidate&userID=${i.userID}" target="_blank">Xem CV</a>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="col-6 p-0 m-0">
                                                            <c:if test="${user.userRole == 4 || user.userRole==2}">
                                                                <c:forEach items="${evaluate}" begin="${loop.index}" end="${loop.index}" step="1" var="e">

                                                                    <form  action="evaluate" method = "get" id = "Ca${loop.index}">
                                                                        <div class="d-flex flex-row m-0 p-0">
                                                                            <div class="col-7 d-flex flex-column m-1 align-middle">
                                                                                <label class="fw-bold text-dark m-1" for="creator">Đánh giá</label>
                                                                                <textarea form ="Ca${loop.index}" cols="40" rows="3" name="description">${not empty e ? e.evaluationDescription : ""}</textarea>
                                                                            </div>
                                                                            <div class=" col-2 d-flex flex-column m-1 align-items-center ">
                                                                                <label class="fw-bold text-dark m-1" for ="score" >Điểm</label>
                                                                                <input class="m-auto" type="number" name="score" value="${not empty e ? e.score : 5}" min="0" max="10" required><br>
                                                                            </div>
                                                                            <input type="hidden" name = "evaluateAction" value= "evaluate">
                                                                            <input type="hidden" name="interviewerID" value="${user.userID}">
                                                                            <input type="hidden" name="interviewID" value="${interview.interviewID}">
                                                                            <input type="hidden" name="postID" value="${interview.postID}">
                                                                            <input type="hidden" name="option" value="${option}">
                                                                            <input type="hidden" name="candidateID" value="${i.userID}">
                                                                            <div class="col-2 m-auto">
                                                                                <input class="btn btn-primary m-1" type="submit" value = "Đánh giá">
                                                                            </div>
                                                                        </div>
                                                                    </form>

                                                                </c:forEach>
                                                            </c:if>
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
                        <h2>Chỉ người phỏng vấn mới có thể xem trang này</h2>
                    </c:otherwise>
                </c:choose>
            </section>


        </div>
    </body>
</html>
