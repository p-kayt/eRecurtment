<%-- 
    Document   : staff-post-detail
    Created on : Oct 31, 2022, 1:57:25 PM
    Author     : MSI GF63
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông Tin Bài Đăng Tuyển Dụng</title>
    </head>
    <body>
        <c:if test="${not empty requestScope.post and not empty requestScope.position}">
            <div>
                <div>
                    <h3>Thông Tin Bài Đăng Tuyển Dụng</h3>
                </div>
            </div>
            <div>
                <!-- Thong bao ket qua cap nhat bai dang, Se xuat hien sau khi cap nhat bai dang -->
                <c:if test="${not empty requestScope.msg}">
                    <div>
                        <h4>${requestScope.msg}</h4>
                    </div>
                </c:if>
                <!--  -->
                <div>
                    <form action="./job" method="post">
                        <label for="postID">ID</label> <input type="text" id="postID" name="postID" value="${requestScope.post.postID}" readonly=""/>
                        </br>
                        <label for="name">Tên Vị Trí</label> <input type="text" id="name" name="name" value="${requestScope.position.positionName}" readonly=""/>
                        </br>
                        <label for="postDescription">Mô Tả Bài Đăng</label> <input type="text" id="postDescription" name="postDescription" value="${requestScope.post.postDescription}"/>
                        </br>
                        <label for="salary">Mức Lương</label> <input type="text" id="salary" name="salary" value="${requestScope.post.salary}"/>
                        </br>
                        <label for="hiringQuantity">Số Lượng Tuyển</label> <input type="number" id="hiringQuantity" name="hiringQuantity" value="${requestScope.post.hiringQuantity}" min="0" max="${requestScope.position.hiringQuantity}"/>
                        </br>
                        <label for="createdDate">Ngày Tạo</label> <input type="date" id="createdDate" name="createdDate" value="${requestScope.post.createdDate}" readonly=""/>
                        </br>
                        <label for="startDate">Ngày Bắt Đầu</label> <input type="date" id="startDate" name="startDate" value="${requestScope.post.startDate}"/>
                        </br>
                        <label for="expiredDate">Ngày Kết Thúc</label> <input type="date" id="expiredDate" name="expiredDate" value="${requestScope.post.expiredDate}"/>
                        </br>
                        <select id="formID" name="formID">
                            <option value="1" <c:if test = "${requestScope.post.formID == 1}">selected</c:if> >Full Time - Offline</option>
                            <option value="2" <c:if test = "${requestScope.post.formID == 2}">selected</c:if> >Full Time - Online</option>
                            <option value="3" <c:if test = "${requestScope.post.formID == 3}">selected</c:if> >Full Time - Hybrid</option>
                            <option value="4" <c:if test = "${requestScope.post.formID == 4}">selected</c:if> >Part Time - Offline</option>
                            <option value="5" <c:if test = "${requestScope.post.formID == 5}">selected</c:if> >Part Time - Online</option>
                            <option value="6" <c:if test = "${requestScope.post.formID == 6}">selected</c:if> >Part Time - Hybrid</option>
                            </select>
                            </br>
                            <select id="statusID" name="statusID">
                                <option value="1" <c:if test = "${requestScope.post.statusID == 1}">selected</c:if> >inActive</option>
                            <option value="2" <c:if test = "${requestScope.post.statusID == 2}">selected</c:if> >Pending</option>
                            <option value="3" <c:if test = "${requestScope.post.statusID == 3}">selected</c:if> >Hiring</option>
                            <option value="4" <c:if test = "${requestScope.post.statusID == 4}">selected</c:if> >Closed</option>
                            </select>
                            <input type="hidden" name="positionID" value="${requestScope.post.positionID}">
                        <input type="hidden" name="action" value="edit-post">
                        </br>
                        <input type="submit" value="Cập Nhật Bài Đăng">
                    </form>
                </div>
            </div>
            <div>
                <div>
                    <h3>Yêu Cầu Công Việc</h3>
                </div>
                <div>
                    <form action="./job" method="post">
                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                        <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                        <input type="hidden" name="action" value="edit-post-requirements">
                        <c:forEach var="req" items="${requestScope.post.requirementList}" varStatus="status">
                            <div>
                                <input type="hidden" name="requirementID" value="${req.requirementID}">
                                <input type="text" name="requirement" value="${req.requirement}">
                            </div>
                        </c:forEach>
                        <input type="submit" value="Cập Nhật Yêu Cầu Công Việc">    
                    </form>   
                </div>
            </div>

            <div>
                <div>
                    <h3>Kỹ Năng Cần Thiết</h3>
                </div>
                <div>
                    <form action="./job" method="post">
                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                        <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                        <input type="hidden" name="action" value="edit-post-skills">
                        <c:forEach var="skill" items="${requestScope.post.skillList}" varStatus="status">
                            <input type="hidden" name="skillID" value="${skill.skillID}">
                            <input type="text" name="skillName" value="${skill.skillName}">
                            <input type="text" name="skillDescription" value="${skill.skillDescription}">
                            </br>
                        </c:forEach>
                        <input type="submit" value="Cập Nhật Kỹ Năng Cần Thiết">    
                    </form> 
                </div>
            </div>

            <div>
                <div>
                    <h3>Quyền Lợi Công Việc</h3>
                </div>
                <div>
                    <div>
                        <form action="./job" method="post">
                            <input type="hidden" name="postID" value="${requestScope.post.postID}">
                            <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                            <input type="hidden" name="action" value="edit-post-benefits">
                            <c:forEach var="bene" items="${requestScope.post.benefitList}" varStatus="status">
                                <div>
                                    <input type="hidden" name="benefitID" value="${bene.benefitID}">
                                    <input type="text" name="benefit" value="${bene.benefit}">
                                </div>
                            </c:forEach>
                            <input type="submit" value="Cập Nhật Quyền Lợi Công Việc">    
                        </form>   
                    </div>
                </div>
            </div>

            <div>
                <div>
                    <h3>Quy Trình Ứng Tuyển</h3>
                </div>
                <div>
                    <form action="./job" method="post">
                        <input type="hidden" name="postID" value="${requestScope.post.postID}">
                        <input type="hidden" name="positionID" value="${requestScope.position.positionID}">
                        <input type="hidden" name="action" value="edit-post-stages">
                        <c:forEach var="stage" items="${requestScope.post.stageList}" varStatus="status">
                            <input type="hidden" name="id" value="${stage.id}">
                            <select id="stageID" name="stageID">
                                <option value="1" <c:if test="${stage.stageID == 1}">selected</c:if>>CV Applying</option>
                                <option value="2" <c:if test="${stage.stageID == 2}">selected</c:if>>Interview</option>
                                <option value="3" <c:if test="${stage.stageID == 3}">selected</c:if>>Finish</option>
                                </select>
                                <input type="text" name="description" value="${stage.description}">
                            </br>
                        </c:forEach>
                        <input type="submit" value="Cập Nhật Quy Trình Ứng Tuyển">    
                    </form> 
                </div>
            </div>
        </c:if>
    </body>
</html>
