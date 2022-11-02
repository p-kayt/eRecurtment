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

        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title><c:if test="${not empty user}"><%=user.getFirstName()%> <%=user.getLastName()%></c:if></title>


        </head>
        <body>
            <header>
                <!-- navi -->
                <nav
                    class="navbar navbar-expand-xl navbar-expand-sm justify-content-center"
                    >
                    <button
                        class="navbar-toggler bg-dark col-6"
                        type="button"
                        data-toggle="collapse"
                        data-target="#Navbar"
                        aria-controls="Navbar"
                        aria-expanded="false"
                        aria-label="Toggle navigation"
                        >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <!--  -->
                    <div class="collapse navbar-collapse col-8" id="Navbar">
                        <ul class="navbar-nav mr-auto d-flex flex-row">
                            <li class="nav-item active col-6">
                                <!-- logo img -->
                                <a class="nav-link" href="home"
                                   ><span class="fa fa-home fa-lg bg-dark"></span>Home</a
                                >
                            </li>

                            <li class="nav-item col-4">
                                <a class="nav-link hyper" href="#">Section 1</a>
                            </li>

                            <li class="nav-item col-4">
                                <a class="nav-link hyper" href="#">Section 2</a>
                            </li>

                            <li class="nav-item col-4">
                                <a class="nav-link hyper" href="#">Section 3</a>
                            </li>
                        </ul>
                    </div>

                    <div>
                    <c:if test="${empty user}">
                        <a href="login">
                            <span class="fa fa-sign-in"></span>Login
                        </a>
                    </c:if>
                    <c:if test="${not empty user}">
                        <a href="logout">
                            <span class="fa fa-sign-in"></span>Logout
                        </a>
                    </c:if>
                </div>
            </nav>

        </header>

        <section>
            <c:if test="<%=(interview != null)%>"> 
                <div>
                    <div> 
                        <p>Mô tả bài đăng ${postDescription}</p>
                    </div>
                </div>
                <div>
                    <form action="interview" method = "post" id="form1">

                        <select id = "statusID" name= "statusID">
                            <c:if test ="<%=(interviewStatus != null)%>" >
                                <c:forEach items="<%=interviewStatus%>" var="i" varStatus="count">
                                    <option value = "${count.index + 1}" ${(count.index + 1) == interview.inteviewStatusID ? "selected" : ""} >${i}</option>   
                                </c:forEach>
                            </c:if>
                        </select> <br />

                        <label for="stageID">Tên vòng phỏng vấn</label>
                        <%--Need fix this, must load stage from database--%>
                        <select  id="stage" name ="stage" disabled>
                            <c:if test ="<%=(interviewStage != null)%>" >
                                <c:forEach items="<%=interviewStage%>" var="i" varStatus="count">
                                    <option value = "${count.index + 1}" ${(count.index + 1) == interview.stageID ? "selected" : ""} >${i}</option>   
                                </c:forEach>
                            </c:if>

                        </select>   <br/>

                        <input type="hidden" name = "stage" value="${interview.stageID}">

                        <label for="description">Mô tả</label> <br />
                        <textarea rows="4" cols="60" name="description" form="form1"><%=interview.getDescription()%></textarea> <br/>

                        <label for="format">Hình thức</label>
                        <%int formatID = interview.getFormatID();%>
                        <select id = "format" name= "format">
                            <c:if test ="<%=(interviewFormat != null)%>" >
                                <c:forEach items="<%=interviewFormat%>" var="i" varStatus="count">
                                    <option value = "${count.index + 1}" ${((count.index + 1) == interview.formatID) ? "selected" : ""}>${i}</option>   
                                </c:forEach>
                            </c:if>
                        </select> <br />

                        <%
                            String[] datetime = interview.getTime().split("\\s");
                            String date = datetime[0];
                            String hour = datetime[1];
                        %>
                        <label for="date" >Ngày</label>
                        <input type="date" name="date" value = <%=date%> required> <br/>

                        <label for="time">Giờ</label>
                        <input type="time" name="time" value = <%=hour%> required> <br/>

                        <label for = "link">Link</label>
                        <input type = "url" name="link" id="link" value="<%=interview.getLink()%>" > <br/>

                        <label for="address" >Địa chỉ</label>
                        <input type="text" name="address" id="address" value="<%=interview.getAddress()%>" > <br />

                        <label for="maxCandidate">Số ứng viên tối đa</label>
                        <input type="number" name="maxCandidate" min="1" value = "<%=interview.getMaxCandidate()%>" required> <br/>
                        <input type="hidden" name="interviewID" value="${interviewID}" >


                        <p>Người tạo     <%=booker%></p>

                        <input type="hidden" name="action" value="updateInterview" > 


                    </form>

                    <div>
                        <div>
                            <div>
                                <p>Người phỏng vấn</p>
                                <div>
                                    <form action="interview" method="post">
                                        <input type="hidden" name="action" value="showListInterviewer">
                                        <input type="hidden" name="interviewID" value = "${interviewID}">
                                        <input type="submit" value="Thêm">
                                    </form>
                                </div>
                                <div>
                                    <c:if test="<%=interviewerList != null%>">
                                        <c:forEach items="<%=interviewerList%>" var="i">
                                            <div>
                                                <div>
                                                    <img class="ava_img" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                </div>
                                                <div>
                                                    <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                </div>
                                                <div>
                                                    <form action="interview" method="post">
                                                        <input type="hidden" name ="action" value ="removeInterviewer">
                                                        <input type="hidden" name ="interviewID" value ="${interviewID}">
                                                        <input type="hidden" name ="userID" value="${i.getUserID()}" >
                                                        <input type="submit" value="Xóa">
                                                    </form>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div>
                            <div>
                                <p>Ứng viên</p>
                                <div>
                                    <form action="interview" method="post">
                                        <input type="hidden" name="action" value="showListCandidate">
                                        <input type="hidden" name="interviewID" value = "${interviewID}">
                                        <input type="submit" value="Thêm">
                                    </form>
                                </div>
                                <div>
                                    <c:if test="<%=candidateList != null%>">
                                        <c:forEach items="<%=candidateList%>" var="i">
                                            <div>
                                                <div>
                                                    <img class="ava_img" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                </div>
                                                <div>
                                                    <p>${i.getFirstName()} ${i.getLastName()}</p>
                                                </div>
                                                <div>
                                                    <c:forEach items="<%=listParticipant%>" var="p">
                                                        <c:if test="${p.userID == i.userID}">
                                                            <p>Giờ ${p.interviewTime.split("\\s")[1]}</p>
                                                        </c:if>
                                                    </c:forEach>
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
                        </div>
                    </div>

                    <div>
                        <div>
                            <div>
                                <p>Ứng viên miễn phỏng vấn</p>
                                <div>
                                    <form action="interview" method="post">
                                        <input type="hidden" name="action" value="showListCandidate">
                                        <input type="hidden" name="interviewID" value = "${interviewID}">
                                        <input type="submit" value="Thêm">
                                    </form>
                                </div>
                                <div>
                                    <c:if test="<%=listNoInterviewCandidate != null%>">
                                        <c:forEach items="<%=listNoInterviewCandidate%>" var="i">
                                            <div>
                                                <div>
                                                    <img class="ava_img" src= "${i.getAvatarURL() != null ? i.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                                </div>
                                                <div>
                                                    <p>${i.getFirstName()} ${i.getLastName()}</p>
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
                        </div>
                    </div>

                    <button type = "button" onclick = "UpdateInterview()">Cập nhật phỏng vấn</button>
                </div>
            </c:if>
        </section>



        <script>
            function UpdateInterview() {
                var f = document.getElementById("form1");
                f.submit();
            }
        </script>
    </body>
</html>

<!--InterviewDTO(interviewID, description, formatID, link, address, time, stageID, postID, statusID, bookerID);-->