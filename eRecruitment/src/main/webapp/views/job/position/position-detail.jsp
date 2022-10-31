<%-- 
    Document   : add-position
    Created on : Oct 26, 2022, 11:50:53 AM
    Author     : MSI GF63
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông Tin Vị Trí</title>
    </head>
    <body>
        <c:if test="${not empty requestScope.position}">
            <div>
                <div>
                    <h3>Thông Tin Vị Trí</h3>
                </div>
            </div>
            <div>
                <div>
                    <form action="./job" method="post">
                        <label for="id">ID</label> <input type="text" id="id" name="id" value="${requestScope.position.positionID}" readonly=""/>
                        </br>
                        <label for="name">Tên</label> <input type="text" id="name" name="name" value="${requestScope.position.positionName}" />
                        </br>
                        <label for="description">Mô Tả</label> <input type="text" id="description" name="description" value="${requestScope.position.positionDescription}" />
                        </br>
                        <label for="quantity">Số Lượng Tuyển</label> <input type="number" id="quantity" name="quantity" value="${requestScope.position.hiringQuantity}" min="0" max="999999"/>
                        </br>
                        <label for="date">Ngày Tạo</label> <input type="date" id="date" name="date" value="${requestScope.position.createdDate}" readonly=""/>
                        </br>
                        <label for="status">Trạng Thái </label>
                        <select id="status" name="status">
                            <option value="1" <c:if test = "${requestScope.position.statusID == 1}">selected</c:if> >inActive</option>
                            <option value="2" <c:if test = "${requestScope.position.statusID == 2}">selected</c:if> >Pending</option>
                            <option value="3" <c:if test = "${requestScope.position.statusID == 3}">selected</c:if> >Hiring</option>
                            <option value="4" <c:if test = "${requestScope.position.statusID == 4}">selected</c:if> >Closed</option>
                            </select>
                            <input type="hidden" name="action" value="edit-position">
                            <input type="submit" value="Cập Nhật Vị Trí">
                        </form>
                    </div>
                </div>
        </c:if>
        <c:if test="${empty requestScope.position}">
            <h3>Cannot load position</h3>
        </c:if>
        <div>
            <div>
                <h4>Danh Sách Bài Đăng Tuyển Dụng</h4>
            </div>
        </div>
        <c:if test="${not empty requestScope.postList}">
            <div>
                <div>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Ngày Tạo</th>
                                <th>Ngày Bắt Đầu</th>
                                <th>Ngày Kết Thúc</th>
                                <th>Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var = "current" items="${requestScope.postList}" varStatus = "status" >
                                <tr>
                                    <td>
                                        <form action="./job" method="post">
                                            <input type="hidden" name="postID" value="${current.postID}">
                                            <input type="hidden" name="positionID" value="${current.positionID}">
                                            <input type="hidden" name="action" value="staff-post-detail">
                                            <input type="submit" value="${current.postID}">
                                        </form>
                                    </td>
                                    <td> ${current.createdDate} </td>
                                    <td> ${current.startDate} </td>
                                    <td> ${current.expiredDate} </td>
                                    <c:if test = "${current.statusID == 1}">
                                        <td> inActive </td>
                                    </c:if>
                                    <c:if test = "${current.statusID == 2}">
                                        <td> Pending </td>
                                    </c:if>
                                    <c:if test = "${current.statusID == 3}">
                                        <td> Hiring </td>
                                    </c:if>
                                    <c:if test = "${current.statusID == 4}">
                                        <td> Closed </td>
                                    </c:if>       
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:if>
        <div>
            <div>
                <form action="./job" method="post">
                    <input type="submit" value="Tạo Bài Đăng">
                    <input type="hidden" name="action" value="load-add-post">
                </form>
            </div>
        </div>
    </body>
</html>
