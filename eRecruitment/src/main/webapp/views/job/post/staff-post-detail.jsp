<%-- 
    Document   : staff-post-detail
    Created on : Oct 31, 2022, 1:57:25 PM
    Author     : MSI GF63
--%>

<%@page import="com.t404notfound.erecruitment.bean.UserDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta charset="utf-8" />
        <title>Thông Tin Bài Đăng Tuyển Dụng</title>
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
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Thông Tin Bài Đăng Tuyển Dụng</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb text-uppercase">
                            <li class="breadcrumb-item"><a href="job?action=position-list">Danh sách vị trí</a></li>
                            <li class="breadcrumb-item"><a href="job?id=${requestScope.position.positionID}&action=position-detail">Chi tiết</a></li>
                            <li class="breadcrumb-item text-white active" aria-current="page">Thông Tin Bài Đăng Tuyển Dụng</li>
                        </ol>
                    </nav> 
                </div>
            </div>
            <c:if test="${not empty requestScope.post and not empty requestScope.position}">
                <div class="d-flex flex-column mb-4">
                    <!-- Thong bao ket qua cap nhat bai dang, Se xuat hien sau khi cap nhat bai dang -->
                    <c:if test="${not empty requestScope.msg}">
                        <div class="alert alert-secondary alert-dismissible fade show d-flex flex-row justify-content-between" role="alert">
                            <span>${requestScope.msg}</span>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>
                    <!--  -->

                    <div class="m-auto">
                        <h2>Thông Tin Chính</h2>
                    </div>

                    <form action="./job" method="post">
                        <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="postID">ID</label>
                                <input class="col-6" type="text" id="postID" name="postID" value="${requestScope.post.postID}" readonly=""/>

                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="name">Tên Vị Trí</label>
                                <input class="col-6" type="text" id="name" name="name" value="${requestScope.position.positionName}" readonly=""/>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="postDescription">Mô Tả</label>
                                <textarea class="col-6" rows="5" type="text" id="postDescription" name="postDescription" value="${requestScope.post.postDescription}">${requestScope.post.postDescription}</textarea>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="salary">Mức Lương</label>
                                <input class="col-3" type="text" id="salary" name="salary" value="${requestScope.post.salary}"/>
                                <span class="col-3"></span>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="hiringQuantity">Số Lượng Tuyển</label>
                                <input class="col-3" type="number" id="hiringQuantity" name="hiringQuantity" value="${requestScope.post.hiringQuantity}" min="0" max="${requestScope.position.hiringQuantity}"/>
                                <span class="col-3"></span>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="createdDate">Ngày Tạo</label>
                                <input class="col-3" type="date" id="createdDate" name="createdDate" value="${requestScope.post.createdDate}" readonly=""/>
                                <span class="col-3"></span>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="startDate">Ngày Bắt Đầu</label>
                                <input class="col-3" type="date" id="startDate" name="startDate" value="${requestScope.post.startDate}"/>
                                <span class="col-3"></span>
                            </div> 
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="expiredDate">Ngày Kết Thúc</label>
                                <input class="col-3" type="date" id="expiredDate" name="expiredDate" value="${requestScope.post.expiredDate}"/>
                                <span class="col-3"></span>
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <label class="col-2" for="formID">Hình Thức</label>
                                <select class="col-3" id="formID" name="formID">
                                    <option value="1" <c:if test = "${requestScope.post.formID == 1}">selected</c:if> >Full Time - Offline</option>
                                    <option value="2" <c:if test = "${requestScope.post.formID == 2}">selected</c:if> >Full Time - Online</option>
                                    <option value="3" <c:if test = "${requestScope.post.formID == 3}">selected</c:if> >Full Time - Hybrid</option>
                                    <option value="4" <c:if test = "${requestScope.post.formID == 4}">selected</c:if> >Part Time - Offline</option>
                                    <option value="5" <c:if test = "${requestScope.post.formID == 5}">selected</c:if> >Part Time - Online</option>
                                    <option value="6" <c:if test = "${requestScope.post.formID == 6}">selected</c:if> >Part Time - Hybrid</option>
                                    </select>
                                    <span class="col-3"></span>
                                </div>
                                <div class="d-flex flex-row justify-content-center m-2">
                                    <label class="col-2" for="statusID">Trạng Thái</label>
                                    <select class="col-3" id="statusID" name="statusID">
                                        <option value="1" <c:if test = "${requestScope.post.statusID == 1}">selected</c:if> >inActive</option>
                                    <option value="2" <c:if test = "${requestScope.post.statusID == 2}">selected</c:if> >Pending</option>
                                    <option value="3" <c:if test = "${requestScope.post.statusID == 3}">selected</c:if> >Hiring</option>
                                    <option value="4" <c:if test = "${requestScope.post.statusID == 4}">selected</c:if> >Closed</option>
                                    </select>
                                    <span class="col-3"></span>
                                    <input type="hidden" name="positionID" value="${requestScope.post.positionID}">
                                <input type="hidden" name="action" value="edit-post">
                            </div>
                            <div class="d-flex flex-row justify-content-center m-2">
                                <div class="col-3 m-1 text-center">
                                    <input class="btn btn-primary" type="submit" value="Cập nhật bài đăng">
                                </div>
                                <div class="col-3 m-1 text-center" id="show-delete-post-form">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#confirmModal">
                                        Xóa bài đăng
                                    </button>
                                </div>
                                <!-- Form chua thong tin de tao buoi phong van Interview -->
                                <div class="col-3 m-1 text-center">
                                    <span class="btn btn-primary" onclick="document.getElementById('createInterviewForm').submit()">Tạo buổi phỏng vấn</span>
                                </div>
                                <!--  -->
                                <c:if test="${requestScope.post.statusID == 4}">
                                    <div class="col-3 m-1 text-center">
                                        <span class="btn btn-primary" onclick="document.getElementById('managing-applications').submit()">Quản lý ứng tuyển</span>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </form>

                    <form class="col-2 m-3" action="interview" method="get" id="createInterviewForm">
                        <input type="hidden" name="postID" value="${requestScope.post.postID}">

                        <input class="d-none" type="submit" value="Tạo buổi phỏng vấn">
                    </form>

                    <form class="col-2 m-3" action="./job" method="post" id="managing-applications">
                        <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                        <input type="hidden" name="action" value="managing-applications">
                        <input class="d-none" type="submit" value="Quản lý ứng tuyển">
                    </form>
                </div>
                <div  class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h2>Yêu Cầu Công Việc</h2>
                    </div>

                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">
                        <form action="./job" method="post">
                            <div class="d-flex flex-column m-2 p-3">
                                <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                <input type="hidden" name="action" value="edit-post-requirements">
                                <c:forEach var="req" items="${requestScope.post.requirementList}" varStatus="status">
                                    <div class="d-flex flex-row justify-content-center">
                                        <input type="hidden" name="requirementID" value="${req.requirementID}">
                                        <input class="col-10 m-1" type="text" name="requirement" value="${req.requirement}">
                                        <a class="col-1 m-1 btn btn-danger" href="./job?action=delete-a-requirement&postID=${requestScope.post.postID}&positionID=${requestScope.position.positionID}&requirementID=${req.requirementID}">Xóa</a>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="col-4 m-auto text-center">
                                <c:if test="${not empty requestScope.post.requirementList}">

                                    <input class="btn btn-primary" type="submit" value="Cập Nhật Yêu Cầu Công Việc">

                                </c:if>
                            </div>
                        </form>
                        <div class="d-flex flex-column">
                            <div class=" mx-5 px-1 col-2">
                                <lable class="bi bi-plus-square-dotted" onclick="addRequirementFromEditPost(${requestScope.post.postID}, ${requestScope.position.positionID})"><span class="m-2">Thêm yêu cầu</span></lable>
                            </div>
                            <div class=" mx-5 px-1 col-2" id="addRequirementButton">

                            </div>

                            <div class="d-flex flex-column" id="addRequirementList">
                                <!--                                <div class=" m-2 px-3" id="addRequirementFromEditPostContainer-example">
                                                                    <form action="#" method="post" id="addRequirementForm">
                                                                        <div class="d-flex flex-column justify-content-center m-2 px-3" id="inputRequirementContainer-example">
                                                                            <input type="hidden">
                                                                            <input type="hidden">
                                                                            <input type="hidden">
                                
                                                                            <label>Yêu Cầu</label>
                                                                            <div class="d-flex justify-content-center" id="requirementContainer-example">
                                                                                
                                                                                <input class="col-12 mx-5 p-1" type="text" id="requirement" name="requirement" value="" placeholder="Nhập yêu cầu công việc...">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-1 mx-4" id="submitRequirementContainer-example">
                                                                            <input class="btn btn-primary" type="submit" value="Thêm">
                                                                        </div>
                                                                    </form>
                                                                </div>-->
                            </div>
                        </div>


                    </div>


                </div>
                <div class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h3>Kỹ Năng Cần Thiết</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">

                        <form action="./job" method="post">
                            <div class="d-flex flex-column m-2 p-3">
                                <div class="d-flex flex-row justify-content-center">
                                    <label class="col-5 m-1" for="skillName">Kỹ Năng</label>
                                    <label class="col-5 m-1" for="skillDescription">Mô Tả</label>
                                    <span class="col-1"></span>
                                </div>
                                <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                <input type="hidden" name="action" value="edit-post-skills">
                                <c:forEach var="skill" items="${requestScope.post.skillList}" varStatus="status">
                                    <input type="hidden" name="skillID" value="${skill.skillID}">

                                    <div class="d-flex flex-row justify-content-center">

                                        <input class="col-5 m-1" type="text" name="skillName" value="${skill.skillName}">

                                        <input class="col-5 m-1" type="text" name="skillDescription" value="${skill.skillDescription}">
                                        <a class="col-1 m-1 btn btn-danger" href="./job?action=delete-a-skill&postID=${requestScope.post.postID}&positionID=${requestScope.position.positionID}&skillID=${skill.skillID}">Xóa</a>
                                    </div>
                                </c:forEach>

                            </div>
                            <div class="col-4 m-auto text-center">
                                <c:if test="${not empty requestScope.post.skillList}">
                                    <input class="btn btn-primary" type="submit" value="Cập Nhật Kỹ Năng Cần Thiết">
                                </c:if>
                            </div>
                        </form>
                        <div class="d-flex flex-column">
                            <div class=" mx-5 px-1 col-2">
                                <label class="bi bi-plus-square-dotted" onclick="addSkillFromEditPost(${requestScope.post.postID}, ${requestScope.position.positionID})"><span class="m-2">Thêm kỹ năng</span></label>
                            </div>
                            <div class=" mx-5 px-1 col-2" id="addSkillButton">
                            </div>
                            <div class="d-flex flex-column" id="addSkillList">
                                <!--                                <div class="m-2 px-3" id="addSkillFromEditPostContainer-example">
                                                                    <form action="#" method="post" id="addSkillForm">
                                                                        <div class="d-flex flex-column justify-content-center m-2 px-3" id="inputSkillContainer-example">
                                                                            <div class="d-flex flex-row row g-2" id="skillContainer-example">
                                                                                <div class="d-flex flex-column col-6">
                                                                                    <label for="skillName">Kỹ Năng</label>
                                                                                    <input class="p-1" type="text" id="skillName" name="skillName" value="" placeholder="Nhập tên kỹ năng...">
                                                                                </div>
                                                                                <div class="d-flex flex-column col-6">
                                                                                    <label for="skillDescription">Mô Tả</label>
                                                                                    <input class="p-1" type="text" id="skillDescription" name="skillDescription" value="" placeholder="Nhập mô tả kỹ năng...">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-1 mx-4" id="submitSkillContainer-example">
                                                                            <input class="btn btn-primary" type="submit" value="Thêm">
                                                                        </div>
                                                                    </form>
                                                                </div>-->
                            </div>
                        </div>


                    </div>
                </div>
                <div class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h3>Quyền Lợi Công Việc</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">
                        <form action="./job" method="post">
                            <div class="d-flex flex-column m-2 p-3">
                                <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                <input type="hidden" name="action" value="edit-post-benefits">
                                <c:forEach var="bene" items="${requestScope.post.benefitList}" varStatus="status">
                                    <div class="d-flex flex-row justify-content-center">
                                        <input type="hidden" name="benefitID" value="${bene.benefitID}">
                                        <input class="col-10 m-1" type="text" name="benefit" value="${bene.benefit}">
                                        <a class="col-1 m-1 btn btn-danger" href="./job?action=delete-a-benefit&postID=${requestScope.post.postID}&positionID=${requestScope.position.positionID}&benefitID=${bene.benefitID}">Xóa</a>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="col-4 m-auto text-center">
                                <c:if test="${not empty requestScope.post.benefitList}">
                                    <input class="btn btn-primary" type="submit" value="Cập Nhật Quyền Lợi Công Việc"> 
                                </c:if>
                            </div>
                        </form>   
                        <div class="d-flex flex-column">
                            <div class=" mx-5 px-1 col-2">
                                <lable class="bi bi-plus-square-dotted" onclick="addBenefitFromEditPost(${requestScope.post.postID}, ${requestScope.position.positionID})"><span class="m-2">Thêm quyền Lợi</span></lable>
                            </div>
                            <div class=" mx-5 px-1 col-2" id="addBenefitButton">
                            </div>
                            <div class="d-flex flex-column" id="addBenefitList">
                            </div>
                        </div>


                    </div>
                </div>

                <div class="d-flex flex-column mb-4">
                    <div class="m-auto">
                        <h3>Quy Trình Ứng Tuyển</h3>
                    </div>
                    <div class="d-flex flex-column m-auto col-10 border border-1 shadow p-4">
                        <form action="./job" method="post">
                            <div class="d-flex flex-column m-2 p-3">
                                <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                <input type="hidden" name="action" value="edit-post-stages">
                                <c:forEach var="stage" items="${requestScope.post.stageList}" varStatus="status">
                                    <div class="d-flex flex-row justify-content-center">
                                        <input type="hidden" name="id" value="${stage.id}">
                                        <select class="col-2 m-1" id="stageID" name="stageID">
                                            <option value="1" <c:if test="${stage.stageID == 1}">selected</c:if>>CV Applying</option>
                                            <option value="2" <c:if test="${stage.stageID == 2}">selected</c:if>>Interview</option>
                                            <option value="3" <c:if test="${stage.stageID == 3}">selected</c:if>>Finish</option>
                                            <option value="4" <c:if test="${stage.stageID == 4}">selected</c:if>>Final Evaluation</option>
                                            </select>
                                            <input class="col-8 m-1" type="text" name="description" value="${stage.description}">
                                        <a class="col-1 btn btn-danger m-1" href="./job?action=delete-a-stage&postID=${requestScope.post.postID}&positionID=${requestScope.position.positionID}&id=${stage.id}">Xóa</a>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="col-4 m-auto text-center">
                                <c:if test="${not empty requestScope.post.stageList}">
                                    <input class="btn btn-primary" type="submit" value="Cập Nhật Quy Trình Ứng Tuyển">
                                </c:if>
                            </div>
                        </form> 
                        <div class="d-flex flex-column">
                            <div class=" mx-5 px-1 col-2">
                                <label class="bi bi-plus-square-dotted" onclick="addStageFromEditPost(${requestScope.post.postID}, ${requestScope.position.positionID})"><span class="m-2">Thêm quy trình</span></label>
                            </div>
                            <div class=" mx-5 px-1 col-2" id="addStageButton">
                            </div>
                            <div class="d-flex flex-column" id="addStageList">


                            </div>  
                        </div>


                    </div>
                </div>
            </c:if>
            <!--modal-->

            <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <form action="./job" method="post">
                            <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                            <input type="hidden" name="postID" value="${requestScope.post.postID}">
                            <input type="hidden" name="action" value="delete-post">
                            <div class="modal-header">
                                <h5 class="modal-title">Bạn có chắc chắn muốn xóa bài đăng này không?</h5> 
                            </div>
                            <div class="modal-footer">
                                <input class="btn btn-primary" type="submit" value="Có">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Không</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>            

            <!--            <div id="delete-post-form-container">
                            <form action="./job" method="post">
                                <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                                <input type="hidden" name="postID" value="${requestScope.post.postID}">
                                <input type="hidden" name="action" value="delete-post">
                                <div>
                                    <p>Bạn có chắc chắn muốn xóa bài đăng này không?</p>
                                </div>
                                <div id="option-no">
                                    <span onclick="hidePostDeleteForm()">Không</span>
                                </div>
                                <div id="option-yes">
                                    <input type="submit" value="Có">
                                </div>
                            </form>
                        </div>-->


        </div>
        <jsp:include page="../../footer/footer.jsp" />


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"
           ><i class="bi bi-arrow-up"></i
            ></a>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/jobutility.js"></script>

    </body>
</html>
