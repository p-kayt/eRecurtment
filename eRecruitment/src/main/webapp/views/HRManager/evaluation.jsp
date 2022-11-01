<%-- 
    Document   : evaluation
    Created on : Nov 1, 2022, 11:25:18 AM
    Author     : Savoy
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Evaluation</title>
    </head>
    <body>
        <c:if test="${requestScope.FirstName != null && requestScope.LastName != null && requestScope.Email != null}">
            <h4>Interview Result of ${requestScope.FirstName} ${requestScope.LastName} (Email: ${requestScope.Email})</h4>
        </c:if>
        <form action = "./ManagerViewCandidates" method = "POST" id = "Back"></form>
        <input type = "hidden" name = "txtSearch" value = "${requestScope.SearchValue}" form = "Back">
        <input type = "SUBMIT" name = "action" value = "Back to Candidate List" form = "Back">
        <table border="1">
            <thead>
                <tr>
                    <th>Interview ID</th>
                    <th>Interviewer ID</th>
                    <th>Score</th>
                    <th>Comment</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var = "current" items="${requestScope.Evaluations}" varStatus = "status" >
                    <tr>
                        <td> ${current.getInterviewID()} </td>
                        <td> ${current.getInterviewerID()} </td>
                        <td> ${current.getScore()} </td>
                        <td> ${current.getComment()} </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <form action = "./ManagerAcceptDecline" method = "POST" id = "Change Status"></form>
        <input type = "HIDDEN" name = "Email" value= "${requestScope.Email}" form = "Change Status">
        <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Change Status">
        <input type = "SUBMIT" name = "action" value = "Accept" form = "Change Status">
        <input type = "SUBMIT" name = "action" value = "Decline" form = "Change Status">
    </body>
</html>
