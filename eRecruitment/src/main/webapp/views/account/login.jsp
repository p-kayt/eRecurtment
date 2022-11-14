<%-- 
    Document   : login
    Created on : Sep 28, 2022, 10:56:11 AM
    Author     : MINH TRI
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <c:if test="${empty sessionScope.user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>
            <div class="login-form">
                <h2 class="d-flex justify-content-center mb-4">Đăng Nhập</h2>
                <c:if test="${not empty requestScope.msg}">
                    <p class="text-danger justify-content-center">${requestScope.msg}</p>
                </c:if>
                <form action="./login" method = "post">
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
                                value = "${email}"
                                placeholder="Email"
                                required
                                />
                        </div>
                        <div class="form-group col-12">
                            <label class="" for="password"
                                   >Mật Khẩu</label
                            >
                            <input
                                type="password"
                                class="form-control form-control-sm mr-1"
                                name ="password"
                                id="password"
                                placeholder="Mật khẩu"
                                required
                                />

                            <input type="hidden" name = "action" value="login">

                           
                        </div>
                    </div>
                    <div class="form-row">
                        <button type="submit" class="btn btn-primary btn-sm ml-1 login-btn">
                            Đăng nhập
                        </button>
                    </div>
                    <div class="justify-content-center">
                        <p class="text-danger">${errorMessage}</p>
                    </div>
                    <div class="form-row justify-content-center m-2">
                        <a href="./signup">Đăng ký</a>
                    </div>
                </form>
            </div>
            <jsp:include page="../footer/footer.jsp" />
        </div>
    </body>
</html>
