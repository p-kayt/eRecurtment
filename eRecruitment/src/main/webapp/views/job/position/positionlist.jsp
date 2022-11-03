<%-- 
    Document   : positionlist
    Created on : Oct 18, 2022, 11:07:54 AM
    Author     : MSI GF63
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta charset="utf-8" />
        <title>Danh sách vị trí</title>
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
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Danh sách vị trí</h1>
                </div>
            </div>
            <div class="d-flex flex-row justify-content-between m-4">
                <div class="col-3">
                    <form action="./job" method="post">
                        <input class="btn btn-primary" type="submit" value="Thêm Vị Trí">
                        <input type="hidden" name="action" value="load-add-position">
                    </form>
                </div>

                <div class="col-3">
                    <form class=" d-flex flex-row" action="./job" method="post">
                        <input class="form-control rounded" type="text" name="keyword" value="${requestScope.keyword}" placeholder="Nhập tên vị trí...">
                        <input class="btn btn-primary"   type="submit" value="Tìm Kiếm">
                        <input type="hidden" name="action" value="search-position">
                    </form>
                </div>
            </div>

            <c:if test = "${not empty requestScope.list}">
                <div>
                    <!-- Thong bao khi add vi tri moi, Se xuat hien sau khi add vi tri vao -->
                    <c:if test="${not empty requestScope.msg}">
                        <div>
                            <h4>${requestScope.msg}</h4>
                        </div>
                    </c:if>
                    <!--  -->
                    <div class="border border-1 shadow m-1 p-3">
                        <table class="table table-hover table-bordered">
                            <thead>
                                <tr class="tb_head col-12 rounded-9 justify-content-around">
                                    <th scope="col" class="col-1 text-center align-middle">ID</th>
                                    <th scope="col" class="col-2 align-middle">Tên</th>
                                    <th scope="col" class="col-6 align-middle">Mô tả</th>
                                    <th scope="col" class="col-1 text-center align-middle" >Số lượng tuyển</th>
                                    <th scope="col" class="col-1 text-center align-middle">Ngày tạo</th>
                                    <th scope="col" class="col-1 text-center align-middle">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var = "current" items="${requestScope.list}" varStatus = "status" >
                                    <tr class="table-row" onclick="document.getElementById('${current.positionID}').submit()">

                                        <td scope="row" class="align-middle text-center">
                                            <form action="./job" method="post" id="${current.positionID}">
                                                <input type="hidden" name="id" value="${current.positionID}">
                                                <input type="hidden" name="action" value="position-detail">
                                                <input class="border-0 bg-transparent btn btn-light" type="submit" value="${current.positionID}">
                                            </form>
                                        </td>
                                        <td class="align-middle"> ${current.positionName} </td>
                                        <td class="overflow-auto"> ${current.positionDescription} </td>
                                        <td class="align-middle text-center"> ${current.hiringQuantity} </td>
                                        <td class="align-middle text-center"> ${current.createdDate} </td>
                                        <c:if test = "${current.statusID == 1}">
                                            <td class="align-middle text-center"> inActive </td>
                                        </c:if>
                                        <c:if test = "${current.statusID == 2}">
                                            <td class="align-middle text-center"> Pending </td>
                                        </c:if>
                                        <c:if test = "${current.statusID == 3}">
                                            <td class="align-middle text-center"> Hiring </td>
                                        </c:if>
                                        <c:if test = "${current.statusID == 4}">
                                            <td class="align-middle text-center"> Closed </td>
                                        </c:if>       
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table> 
                    </div>
                </div>
            </c:if>
        </div>
        <jsp:include page="../../footer/footer.jsp" />

    </body>
</html>
