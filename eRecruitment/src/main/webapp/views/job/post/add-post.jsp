<%-- 
    Document   : add-post
    Created on : Nov 1, 2022, 11:12:02 AM
    Author     : MSI GF63
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tạo Bài Đăng Tuyển Dụng</title>
    </head>
    <body>
        <div>
            <c:if test="${empty sessionScope.user}">
                <jsp:include page="../../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <jsp:include page="../../header/header_logoutbtn.jsp" />
            </c:if>
            <div>
                <div>
                    <h1>Tạo Bài Đăng Tuyển Dụng</h1>
                </div>
            </div>
            <div>
                <h3>Vị Trí:  <a href="./job?action=position-detail&id=${requestScope.position.positionID}">${requestScope.position.positionName}</a></h3>
            </div>
            <div>
                <form action="./job" method="post">
                    <input type="hidden" name="action" value="add-post">
                    <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                    <div>
                        <div>
                            <h4>Thông Tin Chính</h4>
                        </div>
                        <div>
                            <label for="postDescription">Mô Tả</label>
                            <input type="text" id="postDescription" name="postDescription" value="" placeholder="">
                        </div>
                        <div>
                            <label for="salary">Mức Lương</label>
                            <input type="text" id="salary" name="salary" value="" placeholder="">
                        </div>
                        <div>
                            <label for="hiringQuantity">Số Lượng Tuyển</label>
                            <input type="number" id="hiringQuantity" name="hiringQuantity" value="" placeholder="" min="0" max="${requestScope.position.hiringQuantity}">
                        </div>
                        <div>
                            <label for="createdDate">Ngày Tạo</label>
                            <input type="date" id="createdDate" name="createdDate" value="" readonly>
                        </div>
                        <div>
                            <label for="startDate">Ngày Bắt Đầu</label>
                            <input type="date" id="startDate" name="startDate" value="">
                        </div>
                        <div>
                            <label for="expiredDate">Ngày Kết Thúc</label>
                            <input type="date" id="expiredDate" name="expiredDate" value="">
                        </div>
                        <div>
                            <label for="formID">Hình Thức</label>
                            <select id="formID" name="formID">
                                <option value="1" selected>Full Time - Offline</option>
                                <option value="2">Full Time - Online</option>
                                <option value="3">Full Time - Hybrid</option>
                                <option value="4">Part Time - Offline</option>
                                <option value="5">Part Time - Online</option>
                                <option value="6">Part Time - Hybrid</option>
                            </select>
                        </div>
                        <div>
                            <label for="statusID">Trạng Thái</label>
                            <select id="statusID" name="statusID">
                                <option value="1">inActive</option>
                                <option value="2" selected>Pending</option>
                                <option value="3">Hiring</option>
                                <option value="4">Closed</option>
                            </select>
                        </div>
                    </div>
                    <div>
                        <div>
                            <h4>Yêu Cầu Công Việc</h4>
                        </div>
                    </div>
                    <div>
                        <div>
                            <h4>Kỹ Năng Cần Thiết</h4>
                        </div>
                    </div>
                    <div>
                        <div>
                            <h4>Quyền Lợi Công Việc</h4>
                        </div>
                    </div>
                    <div>
                        <div>
                            <h4>Quy Trình Ứng Tuyển</h4>
                        </div>
                    </div>


                    <input type="submit" value="Tạo Bài Đăng">
                </form>
            </div>
        </div>
        <script type="text/javascript">
            function getCurrentDate() {
                let currentDate = new Date().toJSON().slice(0, 10);
                return currentDate;
            }
            var createdDate = document.getElementById("createdDate");
            createdDate.value = getCurrentDate();
            var startDate = document.getElementById("startDate");
            startDate.min = getCurrentDate();
            var expiredDate = document.getElementById("expiredDate");
            expiredDate.min = getCurrentDate();
        </script>
    </body>
</html>
