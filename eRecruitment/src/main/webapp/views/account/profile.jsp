<%-- 
    Document   : profile
    Created on : Oct 6, 2022, 10:39:15 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.cv.CVDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
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
            <!-- navi -->
            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>
            <!--Show CV-->
            <c:if test="${not empty user}">

                <div class="d-flex flex-row mt-4 justify-content-center">
                    <div class="col-3">
                        <div class="profile-img d-flex flex-column col-12 w-auto m-auto">
                            <div class="user_name">
                                <img class="ava_img" src= "${user.getAvatarURL() != null ? user.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                                <div ><%=user.getFirstName()%> <%=user.getLastName()%></div>
                            </div>

                        </div>

                    </div>



                    <div class="profile-info d-flex flex-column" class="change_form">
                        <h4>Avatar</h4>
                        <div class="d-flex flex-row ava_form col-12">
                            <span class="col-2">Change Avatar</span>
                            <form class="col-10 d-flex flex-row justify-content-around" action = "profile" method ="post" enctype="multipart/form-data"> <!-- multipart phai di voi method post-->
                                <input class="col-9" type="file" name="file" accept="image/png" value =""/>
                                <input type ="hidden" name="action" value="updateAvatar">
                                <button class="col-2 btn btn-dark" type="submit">Update</button>
                            </form>
                            <%--<p>Path: ${path}</p>--%>
                        </div>
                        <%-- <p>${infor != null ? infor : "Null"}</p> --%>


                        <form class="d-flex flex-column profile_form" action = "profile" method ="post" id="profileForm">
                            <h4>Infomation</h4>


                            <label class="col-12 d-flex flex-row justify-content-between" for="firstName">
                                <span class="col-2">First name</span>
                                <input class="col-10" type = "text" id="firstName" name ="firstName"
                                       placeholder = "Enter your first name" value="<%=user.getFirstName()%>">
                            </label>

                            <label  class="col-12 d-flex flex-row justify-content-between" for ="lastName">
                                <span class="col-2">Last Name</span>
                                <input class="col-10" type="text" name ="lastName" id ="lastName" value = "<%=user.getLastName()%>"
                                       placeholder = "Enter your last name">
                            </label>

                            <label  class="col-12 d-flex flex-row justify-content-start" for="gender">
                                <span class="col-2">Gender</span>
                                <select class="col-2" name="gender" id="gender">
                                    <option value = "Male" <%=user.getGenderID() == 1 ? "selected" : ""%>>Male</option>
                                    <option value = "Female" <%=user.getGenderID() == 2 ? "selected" : ""%>>Female</option>                       
                                    <option value = "Other" <%=user.getGenderID() == 3 ? "selected" : ""%>>Other</option>
                                </select>
                            </label>
                            <input type="hidden" name="action" value="updateProfile">
                            <div class="d-flex flex-row col-4">
                                <button class="col-4 btn btn-primary" type="submit" >Save</button>
                                <p class="updateMsg">${updateMess}</p>
                                <p class="updateMsg">${updateErrorMess}</p>
                            </div>
                        </form>

                        <h4>Change password</h4>
                        <form class="password_form" action ="profile" method = "post" id="passwordForm">
                            <p class="updateMsg">${changePassMess}</p>
                            <label class="d-flex flex-row justify-content-start" for="oldPassword">
                                <span class="col-3"> Enter your password </span>
                                <input class="col-3" type="password" name="oldPassword" id="oldPassword" value="${oldPassword}"/>
                                <p class="text-danger">${passwordErrMess1}</p>
                            </label>

                            <label class="d-flex flex-row justify-content-start" for="newPassword">
                                <span class="col-3">Enter new password </span>
                                <input class="col-3" type="password" name="newPassword" id="newPassword" value="${newPassword}" />
                                <p class="text-danger">${passwordErrMess2}</p>
                            </label>

                            <label class="d-flex flex-row justify-content-start" for="rePass">
                                <span class="col-3">Confirm password</span>
                                <input class="col-3" type ="password" name="rePass" id="rePass" />
                                <p class="text-danger d-none">Password does not match!</p>
                            </label>

                            <input type="hidden" name="action" value="changePass">
                            <button class="btn btn-primary" onclick="checkPassword()" type="button">Save</button>
                        </form>
                    </div>


                </div>

                <div class="col-12 d-flex justify-content-center">
                    <button id="show-cv-btn" class="col-2 btn btn-primary" type="button" onclick="showCV()">View CV</button>
                    <div id="cv" style="display: none">
                        <jsp:include page="../cv/cv-read.jsp" />
                        <c:if test = "${empty cv}">
                            <form action="cv" method = "post">
                                <input type="hidden" name="action" value="createMyCV">
                                <button class="col-2 btn btn-primary" type="submit">Create CV</button>
                            </form>
                        </c:if>
                        <c:if test = "${not empty cv}">
                            <form action="cv" method = "post">
                                <input type="hidden" name="action" value="editMyCV">
                                <button class="col-2 btn btn-primary" type="submit">Edit CV</button>
                            </form>
                        </c:if>
                    </div>
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
                        document.getElementById("show-cv-btn").style.display = "none";
                        x.style.display = "block";
                    }
                </script>
            </c:if>


        </div>
        <jsp:include page="../footer/footer.jsp" />
    </body>
</html>



<%--Note: tach change password va update profile ra rieng--%>
