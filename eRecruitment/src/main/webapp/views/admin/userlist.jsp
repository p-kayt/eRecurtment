<%-- 
    Document   : userlist
    Created on : Oct 9, 2022, 2:59:04 PM
    Author     : Savoy
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Quản lý các tài khoản</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <meta content="" name="keywords" />
        <meta content="" name="description" />

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <link
            href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Inter:wght@700;800&display=swap"
            rel="stylesheet"
            />

        <!-- Icon Font Stylesheet -->
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
            rel="stylesheet"
            />
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
            rel="stylesheet"
            />

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet" />
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet" />

        <!-- Template Stylesheet -->
        <link href="css/style-dltemp.css" rel="stylesheet" />
    </head>
    <body>
        <%UserDTO user = (UserDTO) session.getAttribute("user");%>
        <div class="container-xxl bg-white p-0">
            <!--      header with nav -->
            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>



            <div
                class="container-fluid bg-primary mb-5 wow fadeIn"
                data-wow-delay="0.1s"
                style="padding: 35px"
                >
                <div class="container">
                    <form action = "./adminViewUser" method = "POST">
                        <div class="row g-2 d-flex justify-content-start">
                            <div class="col-md-6">
                                <input type="text" class="form-control border-0" placeholder="Tìm kiếm" name = "txtSearch" value = "${requestScope.SearchValue}"/>
                            </div>
                            <div class="col-md-3 d-flex flex-row justify-content-around">
                                <input class="btn btn-dark col-5" type = "SUBMIT" name = "action" value = "Search">
                                <input class="btn btn-dark col-5" type = "SUBMIT" name = "action" value = "All">
                            </div>

                        </div>
                    </form>
                </div>
            </div>

            <c:if test = "${not empty requestScope.StatusResult}">
                <h4>Trạng thái của người dùng ${requestScope.FirstName} ${requestScope.LastName} (Email: ${requestScope.Email}) đã được chuyển sang: ${requestScope.StatusResult}!</h4>
            </c:if>

            <c:if test = "${not empty requestScope.RoleResult}">
                <h4>Người dùng ${requestScope.FirstName} ${requestScope.LastName} (Email: ${requestScope.Email}) đã được cấp quyền: ${requestScope.RoleResult}!</h4>
            </c:if>

            <c:if test = "${empty requestScope.Users}">
                <h4>${requestScope.nullMsg}</h4>
            </c:if>


            <c:if test = "${not empty requestScope.Users}">

                <table class="table table-hover table-bordered">
                    <thead>
                        <tr class="tb_head col-12 rounded-9 justify-content-around">
                            <th scope="col" class="col-1 text-center pb-4">ID</th>
                            <th scope="col" class="col-3 text-center pb-4">Email</th>
                            <th scope="col" class="col-2 text-center pb-4">Họ và tên đệm</th>
                            <th scope="col" class="col-1 text-center pb-4">Tên</th>
                            <th scope="col" class="col-1 text-center pb-4">Giới tính</th>
                            <th scope="col" class="col-2 text-center pb-4">Quyền hệ thống</th>
                            <th scope="col" class="col-1 text-center pb-4">Trạng thái</th>
                            <th scope="col" class="col-2 text-center pb-4"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var = "current" items="${requestScope.Users}" varStatus = "status" >
                            <tr>
                                <th scope="row" class="align-middle text-center"> ${current.getUserID()} </th>
                                <td class="align-middle"> ${current.getEmail()} </td>
                                <td class="align-middle"> ${current.getFirstName()} </td>
                                <td class="align-middle"> ${current.getLastName()} </td>
                                <td class="align-middle text-center"> 
                                    <c:if test="${current.getGender() == 'Male'}">
                                        Nam
                                    </c:if>
                                    <c:if test="${current.getGender() == 'Female'}">
                                        Nữ
                                    </c:if> 
                                </td>
                                <td class="align-middle">
                                    <c:choose>
                                        <c:when test = "${current.getUserRole() == 'System Admin'}">
                                            Admin
                                        </c:when>
                                        <c:otherwise>
                                            <c:if test = "${current.getUserRole() == 'Candidate'}">
                                                <select name = "Role" form = "Assign Role_${current.getEmail()}">
                                                    <option value="Candidate">Ứng viên</option>
                                                    <option value="HR Staff">Nhân viên HR</option>
                                                    <option value="HR Manager">Quản lý HR</option>
                                                    <option value="Interviewer">Người phỏng vấn</option>
                                                    <option disabled value="System Admin">Admin</option>
                                                </select>
                                            </c:if>
                                            <c:if test = "${current.getUserRole() == 'HR Staff'}">
                                                <select name = "Role" form = "Assign Role_${current.getEmail()}">
                                                    <option value="HR Staff">Nhân viên HR</option>
                                                    <option value="Candidate">Ứng viên</option>
                                                    <option value="HR Manager">Quản lý HR</option>
                                                    <option value="Interviewer">Người phỏng vấn</option>
                                                    <option disabled value="System Admin">Admin</option>
                                                </select>
                                            </c:if>
                                            <c:if test = "${current.getUserRole() == 'HR Manager'}">
                                                <select name = "Role" form = "Assign Role_${current.getEmail()}">
                                                    <option value="HR Staff">Quản lý HR</option>
                                                    <option value="Candidate">Ứng viên</option>
                                                    <option value="HR Manager">Nhân viên HR</option>
                                                    <option value="Interviewer">Người phỏng vấn</option>
                                                    <option disabled value="System Admin">Admin</option>
                                                </select>
                                            </c:if>
                                            <c:if test = "${current.getUserRole() == 'Interviewer'}">
                                                <select name = "Role" form = "Assign Role_${current.getEmail()}">
                                                    <option value="Interviewer">Người phỏng vấn</option>
                                                    <option value="Candidate">Ứng viên</option>
                                                    <option value="HR Manager">Nhân viên HR</option>
                                                    <option value="HR Staff">Quản lý HR</option>
                                                    <option disabled value="System Admin">Admin</option>
                                                </select>
                                            </c:if>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td class="text-center align-middle">
                                    <c:if test="${current.getStatus() == 'Active'}">
                                        Tự do
                                    </c:if>
                                    <c:if test="${current.getStatus() == 'inActive'}">
                                        Bị cấm
                                    </c:if>
                                </td>
                                <td class="d-flex flex-column col-12">
                                    <c:choose> 
                                        <c:when test = "${current.getUserRole() == 'System Admin'}">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="col-11">
                                                <form action = "./adminUpdateUsers" method = "POST" id = "Change Status_${current.getEmail()}"></form>
                                                <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "Change Status_${current.getEmail()}">
                                                <input type = "HIDDEN" name = "FirstName" value= "${current.getFirstName()}" form = "Change Status_${current.getEmail()}">
                                                <input type = "HIDDEN" name = "LastName" value= "${current.getLastName()}" form = "Change Status_${current.getEmail()}">
                                                <input type = "HIDDEN" name = "Status" value= "${current.getStatus()}" form = "Change Status_${current.getEmail()}">
                                                <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Change Status_${current.getEmail()}">
                                                <c:choose> 
                                                    <c:when test = "${current.getStatus() == 'Active'}">
                                                        <input class="btn btn-primary m-2 w-100" type = "SUBMIT" name = "action" value = "Cấm" form = "Change Status_${current.getEmail()}">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <input class="btn btn-primary m-2 w-100" type = "SUBMIT" name = "action" value = "Bỏ cấm" form = "Change Status_${current.getEmail()}">
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="col-11">
                                                <form action = "./AdminAssignRoles" method = "POST" id = "Assign Role_${current.getEmail()}"></form>
                                                <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "Assign Role_${current.getEmail()}">
                                                <input type = "HIDDEN" name = "FirstName" value= "${current.getFirstName()}" form = "Assign Role_${current.getEmail()}">
                                                <input type = "HIDDEN" name = "LastName" value= "${current.getLastName()}" form = "Assign Role_${current.getEmail()}">
                                                <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Assign Role_${current.getEmail()}">
                                                <input class="btn btn-primary m-2 w-100" type = "SUBMIT" name = "action" value = "Đổi quyền" form = "Assign Role_${current.getEmail()}">
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>                
            </c:if>


        </div>
        <jsp:include page="../footer/footer.jsp" />
    </body>
</html>
