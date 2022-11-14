<%-- 
    Document   : application-detail
    Created on : Nov 13, 2022, 2:37:28 PM
    Author     : Huu Minh
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.application.ApplicationDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi tiết ứng tuyển</title>
    </head>
    <body>
        <div class="container-xxl bg-white p-0" >
            <c:if test="${empty sessionScope.user}">
                <jsp:include page="../../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <jsp:include page="../../header/header_logoutbtn.jsp" />
            </c:if>

            <%boolean check = false;%>
            <div class="d-flex flex-column justify-content-center align-middle m-4 p-5 border border-2 shadow">
                <div class="row g-2 m-auto p-3 fs-4 fw-bold text-dark">
                    <label class="col-auto ">Vị trí</label>
                    <span class="col-auto">${requestScope.post.positionName}</span>
                </div>
                <div class="d-flex flex-column pb-5">



                    <div class="row g-2 m-1 justify-content-around">
                        <label class="col-4 fw-bold text-dark">Ngày ứng tuyển</label>
                        <p class="col-4">${requestScope.application.applyDate}</p>
                    </div>

                    <c:forEach var="i"  items="${requestScope.stageList}" varStatus="loop">
                        <div class="row g-2 m-1 justify-content-around">
                            <c:if test="${i.id != requestScope.application.stageID}">
                                <c:if test="<%=!check%>">
                                    <label class="col-4 fw-bold text-dark">${i.description}</label>
                                    <p class="col-4">Đậu</p>
                                </c:if>
                            </c:if>
                        </div>
                        <div class="row g-2 m-1 justify-content-around">
                            <c:if test="${i.id == requestScope.application.stageID}">                
                                <c:if test="${requestScope.application.statusID == 1}">
                                    <label class="col-4 fw-bold text-dark">${i.description}</label>
                                    <p class="col-4 text-warning">Đang diễn ra</p>
                                </c:if>
                                <c:if test="${requestScope.application.statusID == 2}">
                                    <label class="col-4 fw-bold text-dark">${i.description}</label>
                                    <p class="col-4 text-dark">Đã huỷ</p>

                                </c:if>
                                <c:if test="${requestScope.application.statusID == 3}">
                                    <label class="col-4 fw-bold text-dark">${i.description}</label>
                                    <p class="col-4 text-danger">Rớt</p>
                                </c:if>
                                <c:if test="${requestScope.application.statusID == 4}">
                                    <label class="col-4 fw-bold text-dark">${i.description}</label>
                                    <p class="col-4 text-primary">Đậu</p>

                                </c:if>
                                <%check = true;%>
                            </c:if>

                            <c:if test="${i.id != requestScope.application.stageID}">
                                <c:if test="<%=check%>">
                                    <label class="col-4 fw-bold text-dark">${i.description}</label>
                                    <p class="col-4 text-dark">Chưa diễn ra</p>
                                </c:if>
                            </c:if>
                        </div>
                    </c:forEach>




                    <c:if test="${requestScope.application.statusID == 1}">
                        <form class="m-auto p-3" action="application" method="get" onsubmit="cancelAlert()">
                            <input name="action" value="cancel-application" style="display: none"></input>
                            <input name="appID" value="${requestScope.application.id}" style="display: none"></input>
                            <button class="btn btn-danger" type="submit">Huỷ ứng tuyển</button>
                        </form>
                    </c:if>
                </div>
                <c:if test="${requestScope.application.statusID == 4}">
                    <label class="fw-bold align-center" style="color: green">Chúc mừng bạn đã vượt qua quá trình ứng tuyển công việc này! Vui lòng kiểm tra email hoặc liên hệ với công ty để tiến hành bàn sâu hơn về công việc.</label>

                </c:if>
            </div>
            <jsp:include page="../../footer/footer.jsp" />
        </div>


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top" 
           ><i class="bi bi-arrow-up"></i
            ></a>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!--Javascript -->
        <script src="js/main.js"></script>
        <script>
                            function cancelAlert() {
                                alert("Bạn đã huỷ ứng tuyển thành công, hãy xem lại trong tab đã huỷ!");
                            }

        </script>
    </body>


</html>
