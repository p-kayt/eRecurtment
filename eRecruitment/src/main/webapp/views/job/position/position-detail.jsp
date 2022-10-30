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
        <title>Add Position</title>
    </head>
    <body>
        <c:if test="${not empty requestScope.position}">
            <div>
                <div>
                    <h3>Position Detail</h3>
                </div>
                <div>
                    <form action="./job" method="post">
                        <label for="id">ID:</label> <input type="text" id="id" name="id" value="${requestScope.position.positionID}" readonly=""/>
                        </br>
                        <label for="name">Name:</label> <input type="text" id="name" name="name" value="${requestScope.position.positionName}" />
                        </br>
                        <label for="description">Description:</label> <input type="text" id="description" name="description" value="${requestScope.position.positionDescription}" />
                        </br>
                        <label for="quantity">Hiring Quantity:</label> <input type="number" id="quantity" name="quantity" value="${requestScope.position.hiringQuantity}" min="0" max="999999"/>
                        </br>
                        <label for="date">Created Date:</label> <input type="date" id="date" name="date" value="${requestScope.position.createdDate}"/>
                        </br>
                        <label for="status">Status: </label>
                        <select id="status" name="status">
                            <option value="1" <c:if test = "${requestScope.position.statusID == 1}">selected</c:if> >inActive</option>
                            <option value="2" <c:if test = "${requestScope.position.statusID == 2}">selected</c:if> >Pending</option>
                            <option value="3" <c:if test = "${requestScope.position.statusID == 3}">selected</c:if> >Hiring</option>
                            <option value="4" <c:if test = "${requestScope.position.statusID == 4}">selected</c:if> >Closed</option>
                            </select>
                            <input type="hidden" name="action" value="edit-position">
                            <input type="submit" value="Update">
                        </form>
                    </div>
                </div>
        </c:if>
        <c:if test="${empty requestScope.position}">
            <h3>Cannot load position</h3>
        </c:if>


    </body>
</html>
