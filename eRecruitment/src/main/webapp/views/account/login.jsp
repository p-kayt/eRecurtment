<%-- 
    Document   : login
    Created on : Sep 28, 2022, 10:56:11 AM
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
                <form action="./login" method = "post">
                    <div class="form-row">
                        <div class="form-group col-12">
                            <label class="" for="email"
                                   >Username or Email</label
                            >
                            <input
                                type="email"
                                class="form-control form-control-sm mr-1"
                                id="email"
                                name = "email"
                                value = "${email}"
                                placeholder="Username or Email"
                                required
                                />
                        </div>
                        <div class="form-group col-12">
                            <label class="" for="password"
                                   >Password</label
                            >
                            <input
                                type="password"
                                class="form-control form-control-sm mr-1"
                                name ="password"
                                id="password"
                                placeholder="Password"
                                required
                                />

                            <input type="hidden" name = "action" value="login">

                            <a href="">Forgot password?</a>
                        </div>
                    </div>
                    <div class="form-row">
                        <button type="submit" class="btn btn-primary btn-sm ml-1 login-btn">
                            Login
                        </button>
                    </div>

                    <div style="color: red">
                        <p>${errorMessage}</p>
                    </div>

                    <div class="form-row justify-content-center m-2">
                        <a href="./signup">Sign up</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
