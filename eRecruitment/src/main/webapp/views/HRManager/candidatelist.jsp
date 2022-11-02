<%-- 
    Document   : candidatelist
    Created on : Oct 31, 2022, 3:08:50 PM
    Author     : Savoy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Danh sách ứng viên</title>
    </head>
    <body>
        <form action = "./ManagerViewCandidates" method = "POST">
            Search: <input type = "TEXT" name = "txtSearch" value = "${requestScope.SearchValue}">   
            <input type = "SUBMIT" name = "action" value = "Search">
            <input type = "SUBMIT" name = "action" value = "All">
        </form>

        <div>
            <h4>
                <c:if test = "${requestScope.AppResult != 'Undo' && requestScope.AppResult != null}">
                    Candidate ${requestScope.FirstName} ${requestScope.LastName}'s application has been ${requestScope.AppResult}
                </c:if>
            </h4>
        </div>

        <c:if test = "${empty requestScope.Candidates}">
            <h4>${requestScope.nullMsg}</h4>  
        </c:if>

        <c:if test = "${not empty requestScope.Candidates}">
            <table border="1">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Email</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Application Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var = "current" items="${requestScope.Candidates}" varStatus = "status" >
                        <tr>
                            <td> ${current.getUserID()} </td>
                            <td> ${current.getEmail()} </td>
                            <td> ${current.getFirstName()} </td>
                            <td> ${current.getLastName()} </td>
                            <td> ${current.getGender()} </td>
                            <td>${current.getAppStatus()} </td>
                            <td>
                                <form action = "./ManagerAcceptDecline" method = "POST" id = "Change Status_${current.getEmail()}"></form>
                                <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "Change Status_${current.getEmail()}">
                                <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Change Status_${current.getEmail()}">
                                <c:if test = "${current.getAppStatus() == 'In-progress'}">
                                    <form action = "./ManagerViewCandidateEvaluation" method ="POST" id = "View Evaluation_${current.getEmail()}"></form>
                                    <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "View Evaluation_${current.getEmail()}">
                                    <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "View Evaluation_${current.getEmail()}">
                                    <input type = "HIDDEN" name = "FirstName" value= "${current.getFirstName()}" form = "View Evaluation_${current.getEmail()}">
                                    <input type = "HIDDEN" name = "LastName" value= "${current.getLastName()}" form = "View Evaluation_${current.getEmail()}">
                                    <input type = "SUBMIT" name = "action" value = "View Interview Result" form = "View Evaluation_${current.getEmail()}">

                                    <input type = "HIDDEN" name = "FirstName" value= "${current.getFirstName()}" form = "Change Status_${current.getEmail()}">
                                    <input type = "HIDDEN" name = "LastName" value= "${current.getLastName()}" form = "Change Status_${current.getEmail()}">
                                    <input type = "SUBMIT" name = "action" value = "Accept" form = "Change Status_${current.getEmail()}">
                                    <input type = "SUBMIT" name = "action" value = "Decline" form = "Change Status_${current.getEmail()}">
                                </c:if>
                                <c:if test = "${current.getAppStatus() == 'Fail'}">
                                    <input type = "SUBMIT" name = "action" value = "Undo" form = "Change Status_${current.getEmail()}">
                                </c:if>
                                <c:if test = "${current.getAppStatus() == 'Success'}">
                                    <input type = "SUBMIT" name = "action" value = "Undo" form = "Change Status_${current.getEmail()}">
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>                

        </c:if>
    </body>
</html>
