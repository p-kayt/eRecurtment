<%-- 
    Document   : profile
    Created on : Oct 6, 2022, 10:39:15 PM
    Author     : MINH TRI
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
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
    <c:if test="${not empty user}">
        <div class="container">
            <div class="d-flex flex-row mt-4">
                <div class="profile-img d-flex flex-column">
                    <img src="image/sample-avatar.jpg" alt="avatar" />
                    <div class="align-self-center m-2">name goes here</div>
                </div>

                <div class="profile-info d-flex flex-column">
                    <form action = "profile" method ="get" id="profileForm">
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
                    <form action ="profile" method = "get" id="passwordForm">
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
    <!--Javascript-->
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

        </script>
    </c:if>
</body>
</html>



<%--Note: tach change password va update profile ra rieng--%>