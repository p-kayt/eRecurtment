<%-- 
    Document   : userlist
    Created on : Oct 9, 2022, 2:59:04 PM
    Author     : Savoy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View User List</title>
    </head>
    <body>
        <form action = "./adminViewUser" method = "POST">
            Search: <input type = "TEXT" name = "txtSearch" value = "${requestScope.SearchValue}">   
            <input type = "SUBMIT" name = "action" value = "Search">
            <input type = "SUBMIT" name = "action" value = "All">
        </form>


        <p style="font-weight: bold; font-size: 20px">${nullMess}</p>
        <c:if test = "${not empty requestScope.Users}">
            <table border="1">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Email</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var = "current" items="${requestScope.Users}" varStatus = "status" >
                        <tr>
                            <td> ${current.getUserID()} </td>
                            <td> ${current.getEmail()} </td>
                            <td> ${current.getFirstName()} </td>
                            <td> ${current.getLastName()} </td>
                            <td> ${current.getGenderID()} </td>
                            <td> ${current.getStatusID()} </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>                
        </c:if>
    </body>
</html>
