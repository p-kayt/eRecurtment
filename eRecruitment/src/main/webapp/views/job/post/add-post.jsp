<%-- 
    Document   : add-post
    Created on : Nov 1, 2022, 11:12:02 AM
    Author     : MSI GF63
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <title>Tạo Bài Đăng Tuyển Dụng</title>
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
                <jsp:include page="../../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../../header/header_logoutbtn.jsp" />
            </c:if>

            <div class="container-xxl py-5 bg-dark page-header">
                <div class="container my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Tạo Bài Đăng Tuyển Dụng</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb text-uppercase">
                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                            <li class="breadcrumb-item"><a href="job?id=${requestScope.position.positionID}&action=position-detail">${requestScope.position.positionName}</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Tạo Bài Đăng Tuyển Dụng</li>
                        </ol>
                    </nav> 
                </div>
            </div>

            <div class="container-xxl py-1 bg-light page-header mb-5">
                <div class="container my-5 pt-5 pb-4">
                    <h4 class="display-5 text-dark mb-3">Vị Trí: ${requestScope.position.positionName}</h4>
                </div>
            </div>
            <c:if test="${not empty requestScope.msg}">
                <div class="alert alert-secondary alert-dismissible fade show d-flex flex-row justify-content-between" role="alert">
                    <span>${requestScope.msg}</span>
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </c:if>


            <form action="./job" method="post">
                <input type="hidden" name="action" value="add-post">
                <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                <div  class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h3>Thông Tin Chính</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4 pb-5">
                        <div class="d-flex flex-row justify-content-center m-2">
                            <label class="col-2" for="postDescription">Mô Tả</label>
                            <textarea class="col-6" rows="5" type="text" id="postDescription" name="postDescription" placeholder="Nhập mô tả bài đăng..."></textarea>

                        </div>
                        <div class="d-flex flex-row justify-content-center m-2">
                            <label class="col-2" for="salary">Mức Lương</label>
                            <input class="col-3" type="text" id="salary" name="salary" value="" placeholder="Nhập lương (1 - 100, khoảng 100, ...)">
                            <span class="col-3"></span>
                        </div>
                        <div class="d-flex flex-row justify-content-center m-2">
                            <label class="col-2" for="hiringQuantity">Số Lượng Tuyển</label>
                            <input class="col-3" type="number" id="hiringQuantity" name="hiringQuantity" value="" placeholder="1" min="0" max="${requestScope.position.hiringQuantity}">
                            <span class="col-3"></span>
                        </div>
                        <div class="d-flex flex-row justify-content-center m-2">
                            <label class="col-2" for="createdDate">Ngày Tạo</label>
                            <input class="col-3" type="date" id="createdDate" name="createdDate" value="" readonly>
                            <span class="col-3"></span>
                        </div>
                        <div class="d-flex flex-row justify-content-center m-2">
                            <label class="col-2" for="startDate">Ngày Bắt Đầu</label>
                            <input class="col-3" type="date" id="startDate" name="startDate" value="">
                            <span class="col-3"></span>
                        </div>
                        <div class="d-flex flex-row justify-content-center m-2">
                            <label class="col-2" for="expiredDate">Ngày Kết Thúc</label>
                            <input class="col-3" type="date" id="expiredDate" name="expiredDate" value="">
                            <span class="col-3"></span>
                        </div>
                        <div class="d-flex flex-row justify-content-center m-2">
                            <label class="col-2" for="formID">Hình Thức</label>
                            <select class="col-3" id="formID" name="formID">
                                <option value="1" selected>Full Time - Offline</option>
                                <option value="2">Full Time - Online</option>
                                <option value="3">Full Time - Hybrid</option>
                                <option value="4">Part Time - Offline</option>
                                <option value="5">Part Time - Online</option>
                                <option value="6">Part Time - Hybrid</option>
                            </select>
                            <span class="col-3"></span>
                        </div>
                        <div class="d-flex flex-row justify-content-center m-2">
                            <label class="col-2" for="statusID">Trạng Thái</label>
                            <select class="col-3" id="statusID" name="statusID">
                                <option value="1">inActive</option>
                                <option value="2">Pending</option>
                                <option value="3" selected>Hiring</option>
                                <option value="4">Closed</option>
                            </select>
                            <span class="col-3"></span>
                        </div>
                    </div>
                </div>

                <div  class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h3>Yêu Cầu Công Việc</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">
                        <div id="requirementList">
                        </div>
                        <div class="d-flex flex-column m-2 mx-3">
                            <div class="col-2">
                                <label class="bi bi-plus-square-dotted" onclick="addRequirement()"><span class="m-2">Thêm yêu cầu</span></label>
                            </div>
                            <div class="col-2">
                                <label class="bi bi-dash" onclick="removeRequirement()"><span class="m-2">Xoá yêu cầu</span></label>
                            </div>
                        </div>
                    </div>
                </div>

                <div  class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h3>Kỹ Năng Cần Thiết</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">
                        <div id="skillList">
                        </div>
                        <div class="d-flex flex-column m-2 mx-3">
                            <div class="col-2">
                                <label class="bi bi-plus-square-dotted" onclick="addSkill()"><span class="m-2">Thêm kỹ năng</span></label>
                            </div>
                            <div class="col-2">
                                <label class="bi bi-dash" onclick="removeSkill()"><span class="m-2">Xoá kỹ năng</span></label>
                            </div> 
                        </div>
                    </div>
                </div>

                <div  class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h3>Quyền Lợi Công Việc</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">
                        <div id="benefitList">
                        </div>
                        <div class="d-flex flex-column m-2 mx-3">
                            <div class="col-2">
                                <label class="bi bi-plus-square-dotted" onclick="addBenefit()"><span class="m-2">Thêm quyền lợi</span></label>
                            </div>
                            <div class="col-2">
                                <label class="bi bi-dash" onclick="removeBenefit()"><span class="m-2">Xoá quyền lợi</span></label>
                            </div>   
                        </div>
                    </div>
                </div>
                <div  class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h3>Quy Trình Ứng Tuyển</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">

                        <div id="stageList">
                            <div id="stageContainer">
                            </div>
                        </div>
                        <div class="d-flex flex-column m-2 mx-3">
                            <div class="col-2">
                                <label class="bi bi-plus-square-dotted" onclick="addStage()"><span class="m-2">Thêm quy trình</span></label>
                            </div>
                            <div class="col-2">
                                <label class="bi bi-dash" onclick="removeStage()"><span class="m-2">Xoá quy trình</span></label>
                            </div>

                        </div>
                    </div>


                    <div class="d-flex justify-content-center m-4 pb-4">
                        <input class="btn btn-primary col-3 shadow" type="submit" value="Tạo Bài Đăng">
                    </div>
            </form>
        </div>
        <jsp:include page="../../footer/footer.jsp" />
    </div>



    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
       ><i class="bi bi-arrow-up"></i
        ></a>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>



    <script src="js/jobutility.js"></script>
    
    
    <script type="text/javascript">
        function getCurrentDate() {
            var currentDate = new Date().toJSON().slice(0, 10);
            return currentDate;
        }
        var createdDate = document.getElementById("createdDate");
        createdDate.value = getCurrentDate();
        var startDate = document.getElementById("startDate");
        startDate.min = getCurrentDate();
        startDate.onchange = function () {
            var expiredate = document.getElementById("expiredDate");
            expiredate.setAttribute("min", this.value)
        }
        var expiredDate = document.getElementById("expiredDate");
        expiredDate.min = getCurrentDate();
    </script>
</body>
</html>
