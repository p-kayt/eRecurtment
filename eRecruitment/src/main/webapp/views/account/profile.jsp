<%-- 
    Document   : profile
    Created on : Oct 6, 2022, 10:39:15 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.cv.CVDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="vi">
    <%UserDTO user = (UserDTO) session.getAttribute("user");%>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title><%=user.getFirstName()%> <%=user.getLastName()%></title>
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
        <link rel="stylesheet" href="css/style_profile.css"/>
        <!--        <link href="css/style-dltemp.css" rel="stylesheet"/>-->
    </head>
    <body>
        <div class="container-xxl bg-white p-0">
            <!-- navigation start -->
            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>
            <!-- navigation end -->
            <!--Show CV-->
            <c:if test="${not empty user}">
                <div class="d-flex flex-row mt-4 justify-content-center">

                    <div class="col-3">
                        <div class="profile-img d-flex flex-column col-12 h-auto border border-1 rounded rounded-2">
                            <div class="user_name">
                                <img class="ava_img" id="output" src= "${user.getAvatarURL() != null ? user.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" id="open-img" onclick="openImgForm()"/>

                            </div>
                            <div class="form-popup d-none" id="imgUpdate">
                                <form class="col-12 d-flex flex-column justify-content-center" action = "profile" method ="post" enctype="multipart/form-data"> <!-- multipart phai di voi method post-->
                                    <div class="d-flex justify-content-center col-12 p-3">
                                        <div class="btn btn-light">
                                            <label class="form-label" for="customFile2">Chọn file</label>
                                            <input class="form-control d-none" id="customFile2" type="file" name="file" accept="image/png" value ="" onchange="document.getElementById('output').src = window.URL.createObjectURL(this.files[0])"/>
                                        </div>
                                    </div>
                                    <div class="d-flex flex-row justify-content-center">
                                        <input type ="hidden" name="action" value="updateAvatar">
                                        <button class="col-4 btn btn-primary border border-1 m-1" type="submit" onclick="closeImgForm()">Cập nhật</button>

                                        <button type="button" class="btn cancel col-4 border border-1 m-1" onclick="closeImgForm()">Hủy</button>
                                    </div>
                                </form>
                            </div>
                            <div class="d-flex flex-column justify-content-start m-4">
                                <h4 class="text-light"><%=user.getFirstName()%> <%=user.getLastName()%></h4>
                                <div class="text-light">
                                    <c:if test="<%=user.getGenderID() == 1%>">
                                        Nam
                                    </c:if>
                                    <c:if test="<%=user.getGenderID() == 2%>">
                                        Nữ
                                    </c:if>
                                    <c:if test="<%=user.getGenderID() == 3%>">
                                        Bí mật
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <div class="col-12 d-flex flex-column justify-content-center m-4">
                            <button class="open-button btn btn-light border border-2 rounded rounded-3 col-10 m-1" id="open-button" onclick="openForm()">Chỉnh sửa hồ sơ</button>
                            <button class="open-button btn btn-light border border-2 rounded rounded-3 col-10 m-1" id="open-pws" onclick="openPwsForm()">Đổi mật khẩu</button>
                        </div>

                        <div class="form-popup d-none " id="infoForm">
                            <form class="d-flex flex-column profile_form m-3 justify-content-start" action = "profile" method ="post" id="profileForm">


                                <label class="col-12 d-flex flex-row justify-content-between m-1" for="firstName">
                                    <span class="col-4">Họ</span>
                                    <input class="col-8" type = "text" id="firstName" name ="firstName"
                                           placeholder = "Nhập vào họ" value="<%=user.getFirstName()%>">
                                </label>

                                <label  class="col-12 d-flex flex-row justify-content-between m-1" for ="lastName">
                                    <span class="col-4">Tên</span>
                                    <input class="col-8" type="text" name ="lastName" id ="lastName" value = "<%=user.getLastName()%>"
                                           placeholder = "Nhập vào tên">
                                </label>

                                <label  class="col-12 d-flex flex-row justify-content-start m-1" for="gender">
                                    <span class="col-4">Giới tính</span>
                                    <select class="col-8" name="gender" id="gender">
                                        <option value = "Male" <%=user.getGenderID() == 1 ? "selected" : ""%>>Nam</option>
                                        <option value = "Female" <%=user.getGenderID() == 2 ? "selected" : ""%>>Nữ</option>                       
                                        <option value = "Other" <%=user.getGenderID() == 3 ? "selected" : ""%>>Bí mật</option>
                                    </select>
                                </label>



                                <div class="d-flex flex-row col-12 justify-content-start m-2">
                                    <input type="hidden" name="action" value="updateProfile">
                                    <button class="col-4 btn btn-primary" type="submit" >Lưu</button>
                                    <button type="button" class="btn cancel col-4" onclick="closeForm()">Ðóng</button>
                                    <p class="updateMsg">${updateMess}</p>
                                    <p class="updateMsg">${updateErrorMess}</p>
                                </div>
                            </form>
                        </div>

                        <div class="form-popup d-none " id="pwsForm">
                            <form class="password_form m-3" action ="profile" method = "post" id="passwordForm">
                                <p class="updateMsg">${changePassMess}</p>

                                <label class="d-flex flex-column justify-content-start" for="oldPassword">
                                    <span class="col-8">Nhập mật khẩu cũ</span>
                                    <input class="col-10" type="password" name="oldPassword" id="oldPassword" value="${oldPassword}"/>
                                    <p class="text-danger">${passwordErrMess1}</p>
                                </label>

                                <label class="d-flex flex-column justify-content-start" for="newPassword">
                                    <span class="col-8">Nhập mật khẩu mới</span>
                                    <input class="col-10" type="password" name="newPassword" id="newPassword" value="${newPassword}" />
                                    <p class="text-danger">${passwordErrMess2}</p>
                                </label>

                                <label class="d-flex flex-column justify-content-start" for="rePass">
                                    <span class="col-8">Xác nhận mật khẩu</span>
                                    <input class="col-10" type ="password" name="rePass" id="rePass" />
                                    <p class="text-danger d-none">Mật khẩu không khớp!</p>
                                </label>
                                <div class="d-flex flex-row col-12 justify-content-start m-2">
                                    <input type="hidden" name="action" value="changePass">
                                    <button class="col-4 btn btn-primary" onclick="checkPassword()" type="button">Lưu</button>
                                    <button type="button" class="btn cancel col-4" onclick="closePwsForm()">Ðóng</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-9 d-flex flex-column justify-content-between">

                        <c:if test="${not empty (requestScope.msg)}">
                            <div class="alert alert-secondary alert-dismissible fade show d-flex justify-content-between" role="alert">
                                ${requestScope.msg}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>
                        <c:if test="${user.getUserRole() == 1}">
                            <div class="col-10 m-auto">
                                <div class="d-flex flex-row justify-content-between">
                                    <h2 class="text-primary col-4">CV của tôi</h2>
                                    <c:if test = "${not empty cv}">
                                        <form class="col-2" action="cv" method = "post">
                                            <input type="hidden" name="action" value="editMyCV">
                                            <button class="btn btn-primary m-3" type="submit">Chỉnh sửa CV</button>
                                        </form>
                                    </c:if>
                                </div>
                                <jsp:include page="../cv/cv-read.jsp" />
                                <c:if test = "${empty cv}">
                                    <form action="cv" method = "post">
                                        <input type="hidden" name="action" value="createMyCV">
                                        <button class="col-2 btn btn-primary" type="submit">Tạo CV</button>
                                    </form>
                                </c:if>
                            </div>
                            <div class="col-10 m-auto">
                                <c:if test = "${not empty cv}">
                                    <form action="cv" method = "post">
                                        <input type="hidden" name="action" value="editMyCV">
                                        <button class="col-2 btn btn-primary m-3" type="submit">Chỉnh sửa CV</button>
                                    </form>
                                </c:if>
                            </div>
                        </c:if>
                    </div>


                </div>


                <div id="cv" style="display: none">
                    <jsp:include page="../cv/cv-read.jsp" />
                    <c:if test = "${empty cv}">
                        <form action="cv" method = "post">
                            <input type="hidden" name="action" value="createMyCV">
                            <button class="col-2 btn btn-primary" type="submit">Tạo CV</button>
                        </form>
                    </c:if>
                    <c:if test = "${not empty cv}">
                        <form action="cv" method = "post">
                            <input type="hidden" name="action" value="editMyCV">
                            <button class="col-2 btn btn-primary" type="submit">Chỉnh sửa CV</button>
                        </form>
                    </c:if>
                </div>
            </c:if>

            <!--JavaScript-->
            <c:if test = "${not empty user}">
                <script>
                    function checkPassword() {
                        var f = document.getElementById("passwordForm");
                        var pass = document.getElementById("newPassword");
                        var rePass = document.getElementById("rePass");

                        if (pass.value === rePass.value) {
                            f.submit();
                        } else {
                            document.getElementById("passwordError").style.display = "block";
                            repass.value = null;
                        }
                    }


                    function showCV() {
                        var x = document.getElementById("cv");
                        x.style.display = "block";
                    }

                    function openForm() {
                        document.getElementById("open-button").classList.add("d-none");
                        document.getElementById("infoForm").classList.remove("d-none");
                        document.getElementById("infoForm").classList.add("d-block");
                    }

                    function closeForm() {
                        document.getElementById("open-button").classList.remove("d-none");
                        document.getElementById("infoForm").classList.add("d-none");
                    }

                    function openImgForm() {
                        document.getElementById("imgUpdate").classList.remove("d-none");
                        document.getElementById("imgUpdate").classList.add("d-block");
                    }

                    function closeImgForm() {
                        document.getElementById("imgUpdate").classList.add("d-none");
                    }

                    function openPwsForm() {
                        document.getElementById("open-pws").classList.add("d-none");
                        document.getElementById("pwsForm").classList.remove("d-none");
                        document.getElementById("pwsForm").classList.add("d-block");
                    }

                    function closePwsForm() {
                        document.getElementById("open-pws").classList.remove("d-none");
                        document.getElementById("pwsForm").classList.add("d-none");
                    }
                </script>
            </c:if>

            <jsp:include page="../footer/footer.jsp" />
        </div>

        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i>
        </a>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!--Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>



<%--Note: tach change password va update profile ra rieng--%>
