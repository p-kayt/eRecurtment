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
        <%String booker = (String) request.getAttribute("booker");%>
        <%ArrayList<String> interviewStage = (ArrayList<String>) request.getAttribute("interviewStage");%>
        <%ArrayList<String> interviewStatus = (ArrayList<String>) request.getAttribute("interviewStatus");%>
        <%ArrayList<String> interviewFormat = (ArrayList<String>) request.getAttribute("interviewFormat");%>

        <%ArrayList<UserDTO> interviewerList = (ArrayList<UserDTO>) request.getAttribute("listMainInterviewer");%>

        <%ArrayList<UserDTO> candidateList = (ArrayList<UserDTO>) request.getAttribute("listMainCandidate");%>
        <%ArrayList<UserDTO> listNoInterviewCandidate = (ArrayList<UserDTO>) request.getAttribute("listNoInterviewCandidate");%>
        <%ArrayList<ParticipantDTO> listParticipant = (ArrayList<ParticipantDTO>) request.getAttribute("listParticipant");%>


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
                    <c:when test = "${user.userRole == 2 || user.userRole == 3}">
                        <c:if test="<%=(interview != null)%>"> 
                            <div class="d-flex flex-column justify-content-center align-middle m-4 p-5 border border-2 shadow">
                                <div class="d-flex flex-column">
                                    <form action="interview" method = "post" id="form1">
                                        <div class="d-flex flex-row m-2">
                                            <div class="col-10"> 
                                                <h4>Mô tả bài đăng ${postDescription}</h4>
                                            </div>
                                            <select class="col-2" id = "statusID" name= "statusID">
                                                <c:if test ="<%=(interviewStatus != null)%>" >
                                                    <c:forEach items="<%=interviewStatus%>" var="i" varStatus="count">
                                                        <option value = "${count.index + 1}" ${(count.index + 1) == interview.inteviewStatusID ? "selected" : ""} >${i}</option>   
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                        </div>
                                        <div class="d-flex flex-column m-2">
                                            <label for="stageID">Tên vòng phỏng vấn</label>
                                            <%--Need fix this, must load stage from database--%>
                                            <select  id="stage" name ="stage" disabled>
                                                <c:if test ="<%=(interviewStage != null)%>" >
                                                    <c:forEach items="<%=interviewStage%>" var="i" varStatus="count">
                                                        <option value = "${count.index + 1}" ${(count.index + 1) == interview.stageID ? "selected" : ""} >${i}</option>   
                                                    </c:forEach>
                                                </c:if>
                                            </select>

                                            <input type="hidden" name = "stage" value="${interview.stageID}">

                                            <div class="col-12">
                                                <label class="col-2" for="description">Mô tả</label>
                                                <textarea class="col-8" rows="4" cols="60" name="description" form="form1"><%=interview.getDescription()%></textarea> <br/>
                                            </div>

                                            <div class="col-12">
                                                <label class="col-2" for="format">Hình thức</label>
                                                <%int formatID = interview.getFormatID();%>
                                                <select class="col-8" id = "format" name= "format">
                                                    <c:if test ="<%=(interviewFormat != null)%>" >
                                                        <c:forEach items="<%=interviewFormat%>" var="i" varStatus="count">
                                                            <option value = "${count.index + 1}" ${((count.index + 1) == interview.formatID) ? "selected" : ""}>${i}</option>   
                                                        </c:forEach>
                                                    </c:if>
                                                </select>
                                            </div>
                                            <%
                                                String[] datetime = interview.getTime().split("\\s");
                                                String date = datetime[0];
                                                String hour = datetime[1];
                                            %>
                                            <div class="col-12">
                                                <label class="col-2" for="date" >Ngày</label>
                                                <input class="col-4" type="date" name="date" value = <%=date%> required>
                                            </div>
                                            <div class="col-12">
                                                <label class="col-2" for="time">Giờ</label>
                                                <input class="col-4" type="time" name="time" value = <%=hour%> required>
                                            </div>
                                            <div class="col-12">
                                                <label class="col-2" for = "link">Link</label>
                                                <input class="col-8" type = "url" name="link" id="link" value="<%=interview.getLink()%>" >
                                            </div>

                                            <div class="col-12">
                                                <label class="col-2" for="address" >Địa chỉ</label>
                                                <input class="col-8" type="text" name="address" id="address" value="<%=interview.getAddress()%>" >
                                            </div>

                                            <div class="col-12">
                                                <label class="col-2" for="maxCandidate">Số ứng viên tối đa</label>
                                                <input class="col-4" type="number" name="maxCandidate" min="1" value = "<%=interview.getMaxCandidate()%>" required>
                                            </div>

                                            <input type="hidden" name="interviewID" value="${interviewID}" >


                                            <div class="col-12">
                                                <label class="col-2" for="creator">Người tạo </label>
                                                <span class="col-8 text-dark" id="creator"> ${booker} </span>
                                            </div>

                                            <input type="hidden" name="action" value="updateInterview" > 
                                        </div>
                                    </form>

                                    <div class="d-flex flex-column m-2  border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <label class="col-2">Người phỏng vấn</label>
                                            <div>
                                                <form action="interview" method="post">
                                                    <input type="hidden" name="action" value="showListInterviewer">
                                                    <input type="hidden" name="interviewID" value = "${interviewID}">
                                                    <input class="btn btn-primary m-2" type="submit" value="Thêm">
                                                </form>
                                            </div>
                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="<%=interviewerList != null%>">
                                                <c:forEach items="<%=interviewerList%>" var="i">
                                                    <div class="d-flex flex-row justify-content-between align-center border border-2 m-1 bg-light">
                                                        <div class="col-6 d-flex flex-row text-center">
                                                            <div class="col-3 d-flex justify-content-center">
                                                                <img class="img-thumbnail m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>
                                                            <div class="col-9 text-start align-center m-auto">
                                                                <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                            </div>
                                                        </div>
                                                        <div class="col-4"></div>
                                                        <div class="col-1 text-start align-center m-auto">
                                                            <form action="interview" method="post">
                                                                <input type="hidden" name ="action" value ="removeInterviewer">
                                                                <input type="hidden" name ="interviewID" value ="${interviewID}">
                                                                <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                                <input class="btn btn-danger col-12" type="submit" value="Xóa">
                                                            </form>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column m-2  border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <p>Ứng viên</p>
                                            <div>
                                                <form action="interview" method="post">
                                                    <input type="hidden" name="action" value="showListCandidate">
                                                    <input type="hidden" name="interviewID" value = "${interviewID}">
                                                    <input class="btn btn-primary m-2" type="submit" value="Thêm">
                                                </form>
                                            </div>
                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="<%=candidateList != null%>">
                                                <c:forEach items="<%=candidateList%>" var="i">
                                                    <div class="d-flex flex-row justify-content-between align-center border border-2 m-1 bg-light">
                                                        <div class="col-6 d-flex flex-row text-center">
                                                            <div class="col-3 d-flex justify-content-center">
                                                                <img class="ava_img_icon m-2" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>
                                                            <div class="col-9 text-start align-center m-auto">
                                                                <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                            </div>
                                                            <div>
                                                                <c:forEach items="<%=listParticipant%>" var="p">
                                                                    <c:if test="${p.userID == i.userID}">
                                                                        <p>Giờ ${p.interviewTime.split("\\s")[1]}</p>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <form action="interview" method="post">
                                                                <input type="hidden" name ="action" value ="removeCandidate">
                                                                <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                                <input type="hidden" name ="interviewID" value ="${interviewID}">
                                                                <input type="submit" value="Xóa">
                                                            </form>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-column m-2 border border-1">
                                        <div class="d-flex flex-row justify-content-between align-middle">
                                            <p>Ứng viên miễn phỏng vấn</p>
                                            <div>
                                                <form action="interview" method="post">
                                                    <input type="hidden" name="action" value="showListCandidate">
                                                    <input type="hidden" name="interviewID" value = "${interviewID}">
                                                    <input class="btn btn-primary m-2" type="submit" value="Thêm">
                                                </form>
                                            </div>
                                        </div>
                                        <div  class="d-flex flex-column align-middle">
                                            <c:if test="<%=listNoInterviewCandidate != null%>">
                                                <c:forEach items="<%=listNoInterviewCandidate%>" var="i">
                                                    <div class="d-flex flex-row justify-content-between align-center border border-2 m-1 bg-light">
                                                        <div class="col-6 d-flex flex-row text-center">
                                                            <div class="col-3 d-flex justify-content-center">
                                                                <img class="ava_img" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                            </div>
                                                            <div>
                                                                <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <form action="interview" method="post">
                                                                <input type="hidden" name ="action" value ="removeCandidate">
                                                                <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                                <input type="hidden" name ="interviewID" value ="${interviewID}">
                                                                <input type="submit" value="Xóa">
                                                            </form>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>

                                    <button class="btn btn-primary m-auto col-3"  type = "button" onclick = "UpdateInterview()">Cập nhật phỏng vấn</button>
                                </div>
                            </div>
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <h2>Bạn không được phép chỉnh sửa lịch phỏng vấn</h2>
                    </c:otherwise>
                </c:choose>
            </section>


        </div>
        <script>
            function UpdateInterview() {
                var f = document.getElementById("form1");
                f.submit();
            }
        </script>
    </body>
</html>

<!--InterviewDTO(interviewID, description, formatID, link, address, time, stageID, postID, statusID, bookerID);-->