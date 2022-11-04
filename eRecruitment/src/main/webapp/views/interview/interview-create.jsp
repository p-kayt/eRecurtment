<%-- 
    Document   : interview-modify
    Created on : Oct 24, 2022, 4:02:04 PM
    Author     : MINH TRI
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang = "vi">
    <head>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <%ArrayList<String> interviewStage = (ArrayList<String>) request.getAttribute("interviewStage");%>
        <%ArrayList<String> interviewFormat = (ArrayList<String>) request.getAttribute("interviewFormat");%>

        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />

        <title><c:if test="${not empty user}"><%=user.getFirstName()%> <%=user.getLastName()%></c:if></title>

            <link
                rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
                integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
                crossorigin="anonymous"
                />
            <link rel="stylesheet" href="css/style_profile.css" />
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
                        <div>
                            <form action = "interview" method = "post" id = "form1">
                                <label for="format">Hình thức</label>
                                <select id = "format" name= "format">
                                    <c:if test ="<%=(interviewFormat != null)%>" >
                                        <c:forEach items="<%=interviewFormat%>" var="i" varStatus="count">
                                            <option value = "${count.index + 1}" ${(format == (count.index + 1)) ? "selected" : ""}>${i}</option>   
                                        </c:forEach>
                                    </c:if>
                                </select> <br />
                                <label for = "link">Link</label>
                                <input type = "url" name="link" id="link" > <br/>

                                <label for="address" >Địa chỉ</label>
                                <input type="text" name="address" id="address" > <br />

                                <label for="date" >Ngày</label>
                                <input type="date" name="date" value = "${date}" required> <br/>

                                <label for="time">Giờ</label>
                                <input type="time" name="time" value = "${time}" required> <br/>

                                <label for="maxCandidate">Số ứng viên tối đa</label>
                                <input type="number" name="maxCandidate" min="1" value = "${(maxCandidate == null) ? 10 : maxCandidate}" required> <br/>

                                <label for="stage">Vòng phỏng vấn</label>
                                <select name = "stage" id="stage">
                                    <c:if test ="<%=(interviewStage != null)%>" >
                                        <c:forEach items="<%=interviewStage%>" var="i" varStatus="count">
                                            <option value = "${count.index + 1}" ${(stage == (count.index + 1)) ? "selected" : ""}>${i}</option>   
                                        </c:forEach>
                                    </c:if>
                                </select>   <br/>

                                <input type ="hidden" name="action" value="bookInteview">
                                <input type = "hidden" name = "postID" value = "${postID}">

                                <input type="submit" value = "Đặt lịch"> <br/><br/>
                            </form>

                            <label for="description">Mô tả</label> <br />
                            <textarea rows="4" cols="60" name="description" form="form1">${description}</textarea>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <h2>Bạn không có quyền đặt lịch phỏng vấn</h2>
                    </c:otherwise>
                </c:choose>
            </section>




            <!--Check format: if format is offline then link is require, else, address is require-->
            <!--        <script>
                        function checkFormat(id) {
                            var f = document.getElementById(id);
                            
                        }
                    </script>-->
    </body>
</html>
