<%-- 
    Document   : signup
    Created on : Sep 28, 2022, 7:53:36 PM
    Author     : MINH TRI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <link
            rel="stylesheet"
            href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
            integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
            crossorigin="anonymous"
            />

        <link rel="stylesheet" href="css/style_lgin.css">
    </head>
    <body>
        <div class="container">
            <div class="login-form">
                <form action = "./signup" method="post" id="signupForm">
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label class="" for="email"
                                   >Email</label
                            >
                            <input
                                type="email"
                                class="form-control form-control-sm mr-1"
                                id="email"
                                name = "email"
                                value= "${email}"
                                placeholder="Enter your Email"
                                required
                                />
                        </div>
                        <div style="color: red">
                            <p>${accExistMess}</p>
                        </div>

                        <div class="form-group col-12">
                            <label class="" for="firstName"
                                   >First Name</label
                            >
                            <input
                                type="text"
                                class="form-control form-control-sm mr-1"
                                id="firstName"
                                name = "firstName"
                                value = "${firstName}"
                                placeholder="Enter your first name"
                                required
                                />
                        </div>

                        <div class="form-group col-12">
                            <label class="" for="lastName"
                                   >First Name</label
                            >
                            <input
                                type="text"
                                class="form-control form-control-sm mr-1"
                                id="lastName"
                                name="lastName"
                                value="${lastName}"
                                placeholder="Enter your last name"
                                required
                                />
                        </div>

                        <div class="form-group col-12">
                            <label class="" for="gender"
                                   >Gender</label
                            >
                            <select id="gender" name="gender">
                                <option value="male" selected>Male</option>

                                <option value="female">Female</option>

                                <option value="other">Other</option>

                            </select>
                        </div>

                        <div class="form-group col-12">
                            <label class="" for="password"
                                   >Password</label
                            >
                            <input
                                type="password"
                                class="form-control form-control-sm mr-1"
                                id="password"
                                name="password"
                                placeholder="Password"
                                required
                                />
                        </div>

                        <div class="form-group col-12">
                            <label class="" for="confirm-password"
                                   >Confirm Password</label
                            >
                            <input
                                type="confirm-password"
                                class="form-control form-control-sm mr-1"
                                id="confirm-password"
                                placeholder="Confirm Password"
                                required
                                />
                        </div>
                        <div style="color: red; display: none;" id="checkPass">
                            <p>Password does not match</p>
                        </div>

                    </div>
                    <div class="form-row">
                        <button class="btn btn-primary btn-sm ml-1 login-btn" onclick="checkForm('signupForm')">
                            Sign up
                        </button>
                        //button tu dong gui form?
                    </div>
                    <div class = "mt-2" style = "color:red;">
                        <p>Already have account? <a class= "text-primary" href="login.jsp">Log in </a></p>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function checkForm(id) {
            var form = document.getElementById(id);
            var pass = document.getElementById("password");
            var rePass = document.getElementById("confirm-password");

            if (pass !== rePass) {
                document.getElementById("checkPass").style.display = "block";
                rePass.value = "";
            } else {
                form.submit();
            }
        }
    </script>
</body>
</html>
