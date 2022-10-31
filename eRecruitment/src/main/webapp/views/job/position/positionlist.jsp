<%-- 
    Document   : positionlist
    Created on : Oct 18, 2022, 11:07:54 AM
    Author     : MSI GF63
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vn">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh Sách Vị Trí</title>
    </head>
    <body>
        <div>
            <div>
                <h3>Danh Sách Vị Trí</h3>
            </div>
        </div>
        <div>
            <div>
                <form action="./job" method="post">
                    <input type="submit" value="Thêm Vị Trí">
                    <input type="hidden" name="action" value="load-add-position">
                </form>
            </div>
        </div>
        </br>
        <div>
            <div>
                <form action="./job" method="post">
                    <input type="text" name="keyword" value="${requestScope.keyword}" placeholder="Nhập tên vị trí...">
                    <input type="submit" value="Tìm Kiếm">
                    <input type="hidden" name="action" value="search-position">
                </form>
            </div>
        </div>
        </br>
        <c:if test = "${not empty requestScope.list}">
            <div>
                <!-- Thong bao khi add vi tri moi, Se xuat hien sau khi add vi tri vao -->
                <c:if test="${not empty requestScope.msg}">
                    <div>
                        <h4>${requestScope.msg}</h4>
                    </div>
                </c:if>
                <!--  -->
                <div>
                    <table border="1">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Tên</th>
                                <th>Mô Tả</th>
                                <th>Số Lượng Tuyển</th>
                                <th>Ngày Tạo</th>
                                <th>Trạng Thái</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var = "current" items="${requestScope.list}" varStatus = "status" >
                                <tr>
                                    <td>
                                        <form action="./job" method="post">
                                            <input type="hidden" name="id" value="${current.positionID}">
                                            <input type="hidden" name="action" value="position-detail">
                                            <input type="submit" value="${current.positionID}">
                                        </form>
                                    </td>
                                    <td> ${current.positionName} </td>
                                    <td> ${current.positionDescription} </td>
                                    <td> ${current.hiringQuantity} </td>
                                    <td> ${current.createdDate} </td>
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
    </body>
</html>
