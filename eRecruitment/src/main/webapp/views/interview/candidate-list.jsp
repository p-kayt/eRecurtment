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
        <title>JSP Page</title>
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



            <c:choose>
                <c:when test= "<%=(candidateList != null)%>">
                    <c:choose>
                        <c:when test="<%= (candidateList.size() == 0)%>">
                            <p>Không có ứng viên khả dụng.</p>
                        </c:when>  
                        <c:otherwise>
                            <h3>Danh sách ứng viên</h3>
                            <div class="border border-1 m-5 p-4 shadow">
                                <c:forEach items="<%=candidateList%>" var="i">
                                    <div class="d-flex flex-row align-center border border-2 m-1 bg-light">
                                        <div class="col-6 d-flex flex-row text-center">
                                            <div class="col-3 d-flex justify-content-center">
                                                <img class="ava_img_icon m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                            </div>
                                            <div class="col-9 text-start align-center m-auto">
                                                <p class="m-0">${i.getFirstName()} ${i.getLastName()}</p>
                                            </div>
                                        </div>
                                        <div class="col-4"></div>
                                        <div class="col-1 text-start align-center m-auto">
                                            <%
                                                String[] datetime = interview.getTime().split("\\s");
                                                String date = datetime[0];
                                                String hour = datetime[1];
                                            %>
                                            <form action="interview" method="get">

                                                <label for="time">Giờ</label>
                                                <input type="time" name="time" required> <br/>

                                                <input type = "hidden" name="day" value = "<%=date%>">
                                                <input type="hidden" name="interviewResultID" value="1">
                                                <input type="hidden" name ="action" value ="addCandidate">
                                                <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                <input type="hidden" name ="interviewID" value="${interviewID}" >
                                                <input class="btn btn-primary col-12" type="submit" value="Thêm">
                                            </form>

                                            <form action="interview" method="post">

                                                <input type="hidden" name="time" value = "<%=hour%>">
                                                <input type = "hidden" name="day" value = "<%=date%>">
                                                <input type="hidden" name="interviewResultID" value="2">
                                                <input type="hidden" name ="action" value ="addCandidate">
                                                <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                <input type="hidden" name ="interviewID" value="${interviewID}" >
                                                <input class="btn btn-primary col-12" type="submit" value="Miễn phỏng vấn">
                                            </form>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </c:when>    
                <c:otherwise>
                    <p>Không có ứng viên khả dụng.</p>
                </c:otherwise>
            </c:choose>

            <div>              
                 <form action="interview" method="post">
                    <input type="hidden" name ="action" value ="interviewDetail">
                    <input type="hidden" name ="interviewID" value="${interviewID}" >
                    <input class="btn btn-primary col-12" type="submit" value="Quay về">
                </form>
            </div>

            
        </div>


    </body>
</html>
