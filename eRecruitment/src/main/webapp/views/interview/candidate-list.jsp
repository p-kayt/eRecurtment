<%-- 
    Document   : candidate-list
    Created on : Nov 1, 2022, 8:25:22 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.interview.ParticipantDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
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
        <!---->
    </head>
    <body>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <%InterviewDTO interview = (InterviewDTO) request.getAttribute("interview");%>
        <%ArrayList<UserDTO> candidateList = (ArrayList<UserDTO>) request.getAttribute("listCandidate");%>


        <div class="container-xxl bg-white p-0"> 
            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>
            <c:choose>
                <c:when test = "${user.userRole == 2 || user.userRole == 3}">

                    <div>
                        <c:choose>
                            <c:when test= "<%=(candidateList != null)%>">
                                <div class="container-xxl py-5 bg-dark page-header mb-5">
                                    <div class="container my-5 pt-5 pb-4">
                                        <h1 class="display-3 text-white mb-3 animated slideInDown">Danh sách ứng viên</h1>
                                        <nav aria-label="breadcrumb">
                                            <!--                                                    <ol class="breadcrumb text-uppercase">
                                                                                                    <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                                                                                                    <li class="breadcrumb-item text-white active" aria-current="page">Chi tiết</li>
                                                                                                </ol>-->
                                        </nav> 
                                    </div>
                                </div>
                                <c:choose>
                                    <c:when test="<%= (candidateList.size() == 0)%>">
                                        <div class="alert alert-secondary alert-dismissible fade show d-flex justify-content-between" role="alert">
                                            Không có ứng viên khả dụng.
                                        </div>
                                    </c:when>  
                                    <c:otherwise>

                                        <div class="border border-1 m-5 p-4 shadow">
                                            <c:forEach items="<%=candidateList%>" var="i">
                                                <div class="d-flex flex-row align-center border border-2 m-1 bg-light">
                                                    <div class="col-8 d-flex flex-row text-center">
                                                        <div class="col-3 d-flex justify-content-center">
                                                            <img class="ava_img_icon m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                        </div>
                                                        <div class="col-4 text-start align-center m-auto">
                                                            <p class="m-0">${i.getFirstName()} ${i.getLastName()}</p>
                                                        </div>
                                                        <div class="col-4 text-start align-center m-auto">
                                                            <a href = "job?action=view-candidate-cv&userID=${i.userID}" target="_blank">Xem CV</a>
                                                        </div>
                                                    </div>
                                                    <div class="col-3 text-start align-center m-auto">
                                                        <%
                                                            String[] datetime = interview.getTime().split("\\s");
                                                            String date = datetime[0];
                                                            String hour = datetime[1].split("\\.")[0];
                                                        %>
                                                        <div class="d-flex flex-row">
                                                            <form action="interview" method="get" id="timeform">
                                                                <label for="time">Thời gian</label>
                                                                <input type="time" name="time" required>

                                                                <input type = "hidden" name="day" value = "<%=date%>">
                                                                <input type="hidden" name="interviewResultID" value="1">
                                                                <input type="hidden" name ="action" value ="addCandidate">
                                                                <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                                <input type="hidden" name ="interviewID" value="${interviewID}" >


                                                            </form>

                                                            <form action="interview" method="post" id="passform">
                                                                <input type="hidden" name="time" value = "<%=hour%>">
                                                                <input type = "hidden" name="day" value = "<%=date%>">
                                                                <input type="hidden" name="interviewResultID" value="2">
                                                                <input type="hidden" name ="action" value ="addExemptCandidate" ><!--sua cho nay-->
                                                                <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                                <input type="hidden" name ="interviewID" value="${interviewID}" >

                                                            </form>
                                                                <div class="d-flex flex-column">
                                                                <input class="btn btn-primary col-12 mb-1" type="submit" value="Thêm" form="timeform">
                                                                <input class="btn btn-primary col-12" type="submit" value="Miễn phỏng vấn" form="passform">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                            </c:when>    
                            <c:otherwise>
                                <div class="alert alert-secondary alert-dismissible fade show d-flex justify-content-between" role="alert">
                                    Không có ứng viên khả dụng.
                                </div>
                            </c:otherwise>
                        </c:choose>

                        <div class="col-3 m-auto py-4">              
                            <form action="interview" method="post">
                                <input type="hidden" name ="action" value ="interviewDetail">
                                <input type="hidden" name ="interviewID" value="${interviewID}" >
                                <input class="btn btn-primary col-12" type="submit" value="Quay về">
                            </form>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-secondary alert-dismissible fade show d-flex justify-content-between" role="alert">
                        Bạn không được phép chỉnh sửa lịch phỏng vấn
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                </c:otherwise>
            </c:choose>  
            <jsp:include page="../footer/footer.jsp" />
        </div>


        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    </body>
</html>
