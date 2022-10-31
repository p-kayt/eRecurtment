<%-- 
    Document   : interview-modify
    Created on : Oct 24, 2022, 4:02:04 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.interview.InterviewDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang = "vi">
    <%UserDTO user = (UserDTO) session.getAttribute("user");%>
    <%InterviewDTO interview = (InterviewDTO) session.getAttribute("interview");%>
    <head>
        <meta charset="utf-8" />
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
            <!---->
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
                <c:if test="${(interview != null)}"> 
                    <div class="d-flex flex-column justify-content-center align-middle m-4 p-5 border border-2 shadow">
                        <div> 
                            <h4>Mô tả bài đăng ${postDescription}</h4>
                        </div>
                        <div>
                            <form action="interview" method = "post" id="form1">
                                <%int statusID = interview.getInteviewStatusID();%>
                                <select id = "statusID" name= "statusID">
                                    <option value = "1" <%=(statusID == 1) ? "selected" : ""%> >Booked</option>
                                    <option value = "2" <%=(statusID == 2) ? "selected" : ""%>>Canceled</option>
                                    <option value = "3" <%=(statusID == 3) ? "selected" : ""%>>Have Occured</option>
                                </select>

                                <div class="d-flex flex-column">

                                    <div class="col-12">
                                        <label class="col-2" for="stageID">Tên vòng phỏng vấn</label>
                                        <%--Need fix this, must load stage from database--%>
                                        <select class="col-8" name = "stage" id="stage" disabled>
                                            <%int stageID = interview.getStageID();%>
                                            <option value = "1" <%=(stageID == 1) ? "selected" : ""%>>Vòng 1</option>
                                            <option value = "2" <%=(stageID == 2) ? "selected" : ""%>>Vòng 2</option>
                                            <option value = "3" <%=(stageID == 3) ? "selected" : ""%>>Vòng 3</option>
                                        </select>
                                    </div>

                                    <div class="col-12">
                                        <label class="col-2" for="description">Mô tả</label>
                                        <textarea class="col-8" rows="4" cols="60" name="description" form="form1"><%=interview.getDescription()%></textarea> <br/>
                                    </div>
                                    <div class="col-12">
                                        <label class="col-2" for="format">Hình thức</label>
                                        <%int formatID = interview.getFormatID();%>
                                        <select class="col-8" id = "format" name= "format">
                                            <option value = "1" <%=(formatID == 1) ? "selected" : ""%>>Offline</option>
                                            <option value="2" <%=(formatID == 2) ? "selected" : ""%>>Online</option>
                                        </select>
                                    </div>

                                    <%
                                        String[] datetime = interview.getTime().split("\\s");
                                        String date = datetime[0];
                                        String hour = datetime[1];
                                    %>
                                    <div class="col-12">
                                        <label class="col-2" for="date" >Ngày</label>
                                        <input class="col-4" type="date" name="date" value = <%=date%> required> <br/>
                                    </div>
                                    <div class="col-12">
                                        <label class="col-2" for="time">Giờ</label>
                                        <input class="col-4" type="time" name="time" value = <%=hour%> required> <br/>
                                    </div>
                                    <div class="col-12">
                                        <label class="col-2" for = "link">Link</label>
                                        <input class="col-8" type = "url" name="link" id="link" value="<%=interview.getLink()%>" > <br/>
                                    </div>

                                    <div class="col-12">
                                        <label class="col-2" for="address" >Địa chỉ</label>
                                        <input class="col-8" type="text" name="address" id="address" value="<%=interview.getAddress()%>" > <br />
                                    </div>
                                    <div class="col-12">
                                        <label class="col-2" for="maxCandidate">Số ứng viên tối đa</label>
                                        <input class="col-4" type="number" name="maxCandidate" min="1" value = "<%=interview.getMaxCandidate()%>" required> <br/>
                                    </div>

                                    <div class="col-12">
                                        <label class="col-2" for="creator">Người tạo </label>
                                        <span class="col-8 text-dark" id="creator"> ${booker} </span>
                                    </div>
                                    <input type="hidden" name="action" value="updateInterview" > 
                                </div>
                            </form>

                            <div class="d-flex flex-row justify-content-between align-middle">
                                <label class="col-2">Người phỏng vấn</label>
                                <button class="btn btn-primary m-2" href = "?action=addInterviewer">Thêm</button>
                            </div>

                            <div class="d-flex flex-row justify-content-between align-middle">
                                <label class="col-2">Ứng viên</label>
                                <a class="btn btn-primary m-2" href = "?action=addInterviewer">Thêm</a>
                            </div>

                            <div class="d-flex flex-row justify-content-between align-middle">
                                <label class="col-2">Ứng viên miễn phỏng vấn</label>
                                <button class="btn btn-primary m-2" href = "?action=addInterviewer">Thêm</button>
                                
                            </div>

                            <button class="btn btn-primary m-2" type = "button" onclick = "UpdateInterview()">Cập nhật phỏng vấn</button>
                        </div>
                    </div>
                </c:if>
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
