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
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous"
            />
        <link rel="stylesheet" href="css/style_profile.css" />
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

        <c:if test="${not empty user}">
            <div class="container">
                <div class="d-flex flex-row mt-4">
                    <div class="profile-img d-flex flex-column">
                        <div>
                            <img src= "${user.getAvatarURL() != null ? user.getAvatarURL() : 'image/avatar/default.png'}" alt="avatar" />
                            <div class="align-self-center m-2"><%=user.getFirstName()%> <%=user.getLastName()%></div>
                        </div>
                        <div>
                            <p>PNG file</p>
                            <form action = "profile" method ="post" enctype="multipart/form-data"> <!-- multipart phai di voi method post-->
                                <input type="file" name="file" accept="image/png" value =""/> <br />
                                <input type ="hidden" name="action" value="updateAvatar">
                                <button type="submit">Update avatar</button>
                            </form>
                            <%--<p>Path: ${path}</p>--%>
                        </div>
                        <%-- <p>${infor != null ? infor : "Null"}</p> --%>
                    </div>

                    <div class="profile-info d-flex flex-column">
                        <form action = "profile" method ="post" id="profileForm">
                            <p style="color: yellow; font-weight: bold; display: block;">${updateMess}</p>
                            <p style="color: yellow; font-weight: bold; display: block;">${updateErrorMess}</p>
                            <label for="firstName">First name</label> <br/>
                            <input type = "text" id="firstName" name ="firstName"
                                   placeholder = "Enter your first name" value="<%=user.getFirstName()%>"><br/>

                            <label for ="lastName">Last Name</label> <br/>
                            <input type="text" name ="lastName" id ="lastName" value = "<%=user.getLastName()%>"
                                   placeholder = "Enter your last name"> <br/>

                            <label for="gender">Gender</label> <br/>
                            <select name="gender" id="gender">
                                <option value = "Male" <%=user.getGenderID() == 1 ? "selected" : ""%>>Male</option>
                                <option value = "Female" <%=user.getGenderID() == 2 ? "selected" : ""%>>Female</option>                       
                                <option value = "Other" <%=user.getGenderID() == 3 ? "selected" : ""%>>Other</option>
                            </select> <br/>
                            <input type="hidden" name="action" value="updateProfile">

                            <button type="submit" >Save</button>
                        </form><br/><br/>

                        <h3>Change password</h3>
                        <form action ="profile" method = "post" id="passwordForm">
                            <p style="color: yellow; font-weight: bold; display: block;">${changePassMess}</p>
                            <label for="oldPassword">Enter your password</label> <br/>
                            <input type="password" name="oldPassword" id="oldPassword" value="${oldPassword}"/> <br/>
                            <p style="color: red; font-weight: bold; display: block;">${passwordErrMess1}</p>
                            <label for="newPassword">Enter new password</label> <br/>
                            <input type="password" name="newPassword" id="newPassword" value="${newPassword}" /> <br/>
                            <p style="color: red; font-weight: bold; display: block;">${passwordErrMess2}</p>
                            <label for="rePass">Confirm password</label> <br/>
                            <input type ="password" name="rePass" id="rePass" /> <br/>
                            <p id ="passwordError" style="color: red; font-weight: bold; display: none;">Password does not match!</p>
                            <input type="hidden" name="action" value="changePass">
                            <button onclick="checkPassword()" type="button">Save</button>
                        </form>
                    </div>


                </div>
            </div>
        </c:if>

        <!--Show CV-->
        <jsp:include page ="../cv/cv-read.jsp"/>

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
            </script>
        </c:if>


    </body>
</html>



<%--Note: tach change password va update profile ra rieng--%>
