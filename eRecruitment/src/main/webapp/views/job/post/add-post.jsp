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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
            <c:if test="${not empty requestScope.msg}">
                <div>
                    <div>
                        <h4>${requestScope.msg}</h4>
                    </div>
                </div>
            </c:if>
            <div>
                <h3>Vị Trí:  <a href="./job?action=position-detail&id=${requestScope.position.positionID}">${requestScope.position.positionName}</a></h3>
            </div>
            <div>
                <form action="./job" method="post">
                    <input type="hidden" name="action" value="add-post">
                    <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                    <div>
                        <div>
                            <h3>Thông Tin Chính</h3>
                        </div>
                        <div>
                            <label for="postDescription">Mô Tả</label>
                            <input type="text" id="postDescription" name="postDescription" value="" placeholder="Nhập mô tả bài đăng...">
                        </div>
                        <div>
                            <label for="salary">Mức Lương</label>
                            <input type="text" id="salary" name="salary" value="" placeholder="Nhập lương (1 - 100, khoảng 100, ...)">
                        </div>
                        <div>
                            <label for="hiringQuantity">Số Lượng Tuyển</label>
                            <input type="number" id="hiringQuantity" name="hiringQuantity" value="" placeholder="1" min="0" max="${requestScope.position.hiringQuantity}">
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
                            <h3>Yêu Cầu Công Việc</h3>
                        </div>
                        <div id="requirementList">
                            <div id="requirementContainer">
                                <label for="requirement">Yêu Cầu 1</label><input type="text" id="requirement" name="requirement" value="" placeholder="Nhập yêu cầu công việc...">
                            </div>
                        </div>
                        <div>
                            <span class="fa fa-plus-circle fa-2x" onclick="addRequirement()"></span>
                        </div>
                        <div>
                            <span class="fa fa-minus-circle fa-2x" onclick="removeRequirement()"></span>
                        </div>
                    </div>
                    <div>
                        <div>
                            <h3>Kỹ Năng Cần Thiết</h3>
                        </div>
                        <div id="skillList">
                            <div id="skillContainer">
                                <div><label for="skillName">Kỹ Năng 1'</label><input type="text" id="skillName" name="skillName" value="" placeholder="Nhập tên kỹ năng..."></div><div><label for="skillDescription">Mô Tả 1</label><input type="text" id="skillDescription" name="skillDescription" value="" placeholder="Nhập mô tả kỹ năng..."></div>
                            </div>
                        </div>
                        <div>
                            <span class="fa fa-plus-circle fa-2x" onclick="addSkill()"></span>
                        </div>
                        <div>
                            <span class="fa fa-minus-circle fa-2x" onclick="removeSkill()"></span>
                        </div>
                    </div>
                    <div>
                        <div>
                            <h3>Quyền Lợi Công Việc</h3>
                        </div>
                        <div id="benefitList">
                            <div id="benefitContainer">
                                <label for="benefit">Quyền Lợi 1</label><input type="text" id="benefit" name="benefit" value="" placeholder="Nhập quyền lợi...">
                            </div>
                        </div>
                        <div>
                            <span class="fa fa-plus-circle fa-2x" onclick="addBenefit()"></span>
                        </div>
                        <div>
                            <span class="fa fa-minus-circle fa-2x" onclick="removeBenefit()"></span>
                        </div>
                    </div>
                    <div>
                        <div>
                            <h3>Quy Trình Ứng Tuyển</h3>
                        </div>
                        <div id="stageList">
                            <div id="stageContainer">
                                <div><label for="stageID">Vòng Ứng Tuyển 1</label><select id="stageID" name="stageID"><option value="1" selected>CV Applying</option><option value="2">Interview</option><option value="3">Finish</option><option value="4">Final Evaluation</option></select></div><div><label for="description">Mô Tả 1</label><input type="text" id="description" name="description" value="" placeholder="Nhập mô tả vòng ứng tuyển..."></div>
                            </div>
                        </div>
                        <div>
                            <span class="fa fa-plus-circle fa-2x" onclick="addStage()"></span>
                        </div>
                        <div>
                            <span class="fa fa-minus-circle fa-2x" onclick="removeStage()"></span>
                        </div>
                    </div>


                    <input type="submit" value="Tạo Bài Đăng">
                </form>
            </div>
        </div>
        <script type="text/javascript">
            function getCurrentDate() {
                var currentDate = new Date().toJSON().slice(0, 10);
                return currentDate;
            }
            var createdDate = document.getElementById("createdDate");
            createdDate.value = getCurrentDate();
            var startDate = document.getElementById("startDate");
            startDate.min = getCurrentDate();
            var expiredDate = document.getElementById("expiredDate");
            expiredDate.min = getCurrentDate();
        </script>
        <script src="js/jobutility.js"></script>
    </body>
</html>
