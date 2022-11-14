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
        <div class="container-xxl bg-white p-0">
            <jsp:include page="../header/header_loginbtn.jsp" />

            <div class="login-form">
                <form action = "signup" method="post" id="signupForm">
                    <h2 class="d-flex justify-content-center mb-4">Đăng Ký</h2>
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label class="form-control form-control-sm mr-1" for="email"
                                   >Email
                                <input
                                    type="email"

                                    id="email"
                                    name = "email"
                                    value= "${email}"
                                    placeholder="@gmail.com"
                                    required
                                    />
                            </label
                            >
                        </div>
                        <div id="emailError" class="text-danger" >
                            <p>${EmailErrorMess}</p>
                        </div>

                        <div class="form-group col-12">
                            <label class="form-control form-control-sm mr-1" for="firstName">
                                Họ

                                <input
                                    type="text"

                                    id="firstName"
                                    name = "firstName"
                                    value = "${firstName}"
                                    placeholder="Họ"
                                    required
                                    />
                            </label>
                        </div>

                        <div class="form-group col-12">
                            <label class="form-control form-control-sm mr-1" for="lastName">
                                Tên
                                <input
                                    type="text"

                                    id="lastName"
                                    name="lastName"
                                    value="${lastName}"
                                    placeholder="Tên"
                                    required
                                    />
                            </label>
                        </div>

                        <div class="form-group col-12  d-flex flex-row">
                            Giới tính
                            <div class="col-8  d-flex flex-row">
                                <input type="radio" id="male" name="gender" value="Nam" checked>
                                <label for="male">Nam</label>

                                <input type="radio" id="female" name="gender" value="Nữ">
                                  <label for="female">Nữ</label>
                                  
                                <input type="radio" id="other" name="gender" value="Khác">
                                  <label for="other">Khác</label>
                            </div>
                        </div>

                        <div class="form-group col-12">
                            <label class="form-control form-control-sm mr-1" for="password">
                                Mật khẩu
                                <input
                                    type="password"

                                    id="password"
                                    name="password"
                                    placeholder="Mật khẩu"
                                    required
                                    />
                            </label>
                        </div>

                        <div class="form-group col-12">
                            <label class="form-control form-control-sm mr-1" for="confirm-password">
                                Xác nhận mật khẩu
                                <input
                                    type= "password"

                                    id="confirm-password"
                                    placeholder="Xác nhận mật khẩu"
                                    required
                                    />
                            </label>
                        </div>
                        <div class="text-danger " id="checkPass" style="display: none;">
                            <p>Mật khẩu không trùng khớp</p>
                        </div>

                    </div>
                    <div class="form-row">
                        <button type="button" class="btn btn-primary btn-sm ml-1 login-btn" onclick="checkForm()"> 
                            Đăng ký
                        </button>
                    </div>
                    <div class = "mt-2 text-danger">
                        <p>Đã có tài khoản? <a class= "text-primary" href="login?action=login">Đăng nhập</a></p>
                    </div>
                </form>
            </div>
            <jsp:include page="../footer/footer.jsp" />
        </div>

    <script>
        function checkForm() {
            var form = document.getElementById("signupForm");
            var pass = document.getElementById("password");
            var rePass = document.getElementById("confirm-password");

            if (pass.value !== rePass.value) {
                document.getElementById("emailError").style.display = "none";
                document.getElementById("checkPass").style.display = "block";
                repass.value = "";
            } else {
                document.getElementById("checkPass").style.display = "none";
                form.submit();
            }
        }
    </script>
</body>
</html>
