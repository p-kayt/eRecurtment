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

            <c:if test="${not empty requestScope.position}">
                <div class="container-xxl py-5 bg-dark page-header mb-5">
                    <div class="container my-5 pt-5 pb-4">
                        <h1 class="display-3 text-white mb-3 animated slideInDown">Thông tin vị trí</h1>
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb text-uppercase">
                                <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                                <li class="breadcrumb-item text-white active" aria-current="page">Chi tiết</li>
                            </ol>
                        </nav> 
                    </div>
                </div>
                <div>
                    <!-- Thong bao khi chinh sua thong tin vi tri -->
                    <!-- Xuat hien khi bam vao chinh sua vi tri -->
                    <c:if test="${not empty requestScope.msg}">
                        <div class="alert alert-success" role="alert">
                            <h4>${requestScope.msg}</h4>
                        </div>
                    </c:if>
                    <!--  -->

                    <form action="./job" method="post">
                        <div class="d-flex flex-column w-75 m-5 m-auto border border-1">
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="id">ID</label>
                                <input class="col-4" type="text" id="id" name="id" value="${requestScope.position.positionID}" readonly=""/>
                                <span class="col-4"></span>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="name">Tên</label>
                                <input class="col-4" type="text" id="name" name="name" value="${requestScope.position.positionName}" />
                                <span class="col-4"></span>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="description">Mô Tả</label>
                                <textarea class="col-8" rows="5" type="text" id="description" name="description" value="${requestScope.position.positionDescription}">${requestScope.position.positionDescription}</textarea>

                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="quantity">Số Lượng Tuyển</label>
                                <input class="col-2" type="number" id="quantity" name="quantity" value="${requestScope.position.hiringQuantity}" min="0" max="999999"/>
                                <span class="col-6"></span>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="date">Ngày Tạo</label>
                                <input class="col-2" type="date" id="date" name="date" value="${requestScope.position.createdDate}" readonly=""/>
                                <span class="col-6"></span>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="status">Trạng Thái</label>
                                <select class="col-2" id="status" name="status">
                                    <option value="1" <c:if test = "${requestScope.position.statusID == 1}">selected</c:if> >inActive</option>
                                    <option value="2" <c:if test = "${requestScope.position.statusID == 2}">selected</c:if> >Pending</option>
                                    <option value="3" <c:if test = "${requestScope.position.statusID == 3}">selected</c:if> >Hiring</option>
                                    <option value="4" <c:if test = "${requestScope.position.statusID == 4}">selected</c:if> >Closed</option>
                                    </select>
                                    <span class="col-6"></span>

                                </div>
                                <div class="d-flex flex-row justify-content-around m-2">
                                    <input type="hidden" name="action" value="edit-position">
                                    <input class="btn btn-primary" type="submit" value="Cập Nhật">
                                </div>
                                <div id="show-delete-position-form">
                                    <span onclick="showPositionDeleteForm()">Xóa</span>
                                </div>
                            </div>
                        </form>
                    </div>
            </c:if>
            <c:if test="${empty requestScope.position}">
                <div class="alert alert-danger" role="alert">
                    <h3>Cannot load position</h3>
                </div>
            </c:if>
            <div class="container-xxl py-1 bg-light page-header mb-5 mt-5">
                <div class="container my-5 pt-5 pb-4">
                    <h4 class="display-5 text-dark mb-3">Danh Sách Bài Đăng Tuyển Dụng</h4>
                </div>
            </div>
            <c:if test="${not empty requestScope.postList}">

                <div class="border border-1 shadow m-1 p-3">
                    <table class="table table-hover table-bordered">
                        <thead>
                            <tr class="col-12 rounded-9 justify-content-around">
                                <th scope="col" class="col-1 text-center align-middle">ID</th>
                                <th scope="col" class="col-2 align-middle">Ngày Tạo</th>
                                <th scope="col" class="col-2 align-middle">Ngày Bắt Đầu</th>
                                <th scope="col" class="col-2 align-middle">Ngày Kết Thúc</th>
                                <th scope="col" class="col-2 text-center">Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var = "current" items="${requestScope.postList}" varStatus = "status" >
                                <tr>
                                    <td scope="row" class="align-middle text-center">
                                        <form action="./job" method="post">
                                            <input type="hidden" name="postID" value="${current.postID}">
                                            <input type="hidden" name="positionID" value="${current.positionID}">
                                            <input type="hidden" name="action" value="staff-post-detail">
                                            <input class="border-0 bg-white btn btn-light" type="submit" value="${current.postID}">
                                        </form>
                                    </td>
                                    <td class="align-middle text-center"> ${current.createdDate} </td>
                                    <td class="align-middle text-center"> ${current.startDate} </td>
                                    <td class="align-middle text-center"> ${current.expiredDate} </td>
                                    <c:if test = "${current.statusID == 1}">
                                        <td class="align-middle text-center">InActive</td>
                                    </c:if>
                                    <c:if test = "${current.statusID == 2}">
                                        <td class="align-middle text-center">Pending</td>
                                    </c:if>
                                    <c:if test = "${current.statusID == 3}">
                                        <td class="align-middle text-center">Hiring</td>
                                    </c:if>
                                    <c:if test = "${current.statusID == 4}">
                                        <td class="align-middle text-center">Closed</td>
                                    </c:if>       
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <div class="d-flex justify-content-end mb-5 p-3">
                <form action="./job" method="post">
                    <input class="btn btn-primary" type="submit" value="Tạo Bài Đăng">
                    <input type="hidden" name="action" value="load-add-post">
                    <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                </form>
            </div>
        </div>
                <div class="d-none" id="delete-position-form-container">
            <form action="./job" method="post">
                <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                <input type="hidden" name="action" value="delete-position">
                <div>
                    <p>Bạn có chắc chắn muốn xóa vị trí này không?</p>
                </div>
                <div id="option-no">
                    <span onclick="hidePositionDeleteForm()">Không</span>
                </div>
                <div id="option-yes">
                    <input type="submit" value="Có">
                </div>
            </form>
        </div>
        <script src="js/jobutility.js"></script>
        <jsp:include page="../../footer/footer.jsp" />
    </body>
</html>
