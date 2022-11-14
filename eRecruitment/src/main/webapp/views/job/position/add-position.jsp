<%-- 
    Document   : add-position
    Created on : Oct 26, 2022, 11:50:53 AM
    Author     : MSI GF63
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta charset="utf-8" />
        <title>Thông tin vị trí</title>
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
        <!--css/style-dltemp.css-->
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

            <div class="container-xxl py-5 bg-dark page-header mb-5">
                <div class="container my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Thêm Vị Trí Mới</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb text-uppercase">
                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Thêm Vị Trí</li>
                        </ol>
                    </nav> 
                </div>
            </div>
            <form action="./job" method="post">
                <div class="d-flex flex-column w-75 m-5 m-auto border border-1">
                    <div class="d-flex flex-row justify-content-center m-2">
                        <label class="col-2" for="name">Tên</label>
                        <input class="col-4" type="text" id="name" name="name" value="" placeholder="Nhập tên vị trí..." required/>
                        <span class="col-4"></span>
                    </div>

                    <div class="d-flex flex-row justify-content-center m-2">
                        <label class="col-2" for="description">Mô Tả</label>
                        <textarea class="col-8" rows="5" type="text" id="description" name="description" value="" placeholder="Nhập mô tả vị trí..." required></textarea>
                    </div>

                    <div class="d-flex flex-row justify-content-center m-2">

                        <label class="col-2" for="quantity">Số Lượng Tuyển</label>
                        <input class="col-4" type="number" id="quantity" name="quantity" value="" min="0" max="999999" placeholder="Nhập số lượng tuyển" required=""/>
                        <span class="col-4"></span>
                    </div>

                    <div class="d-flex flex-row justify-content-center m-2">

                        <label class="col-2" for="date">Ngày Tạo</label>
                        <input class="col-4" type="date" id="date" name="date" value="" readonly/>
                        <span class="col-4"></span>
                    </div>

                    <div class="d-flex flex-row justify-content-center m-2">

                        <label class="col-2" for="status">Trạng Thái </label>
                        <select class="col-4" id="status" name="status">
                            <option value="1">inActive</option>
                            <option value="2">Pending</option>
                            <option value="3" selected>Hiring</option>
                            <option value="4">Closed</option>
                        </select>
                        <span class="col-4"></span>
                    </div>
                    <div class="d-flex flex-row justify-content-around m-2">
                        <input type="hidden" name="action" value="add-position">
                        <input class="btn btn-primary" type="submit" value="Thêm Vị Trí">
                    </div>
                </div>
            </form>
        </div>
        <jsp:include page="../../footer/footer.jsp" />
        <script type="text/javascript">
            function getCurrentDate() {
                var currentDate = new Date().toJSON().slice(0, 10);
                return currentDate;
            }
            var createdDate = document.getElementById("date");
            createdDate.value = getCurrentDate();
            
        </script>
    </body>
</html>
