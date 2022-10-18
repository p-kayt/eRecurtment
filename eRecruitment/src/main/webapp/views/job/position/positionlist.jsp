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
        <title>Position List</title>
    </head>
    <body>
        <c:if test = "${not empty requestScope.list}">
            <table border="1">
                <thead>
                    <tr>
                        <th>Position ID</th>
                        <th>Position Name</th>
                        <th>Position Description</th>
                        <th>Hiring Quantity</th>
                        <th>Created Date</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var = "current" items="${requestScope.list}" varStatus = "status" >
                        <tr>
                            <td> ${current.positionID} </td>
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
        </c:if>
    </body>
</html>
