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
        <title>Kết quả phỏng vấn</title>
    </head>
    <body>
        <c:if test="${requestScope.FirstName != null && requestScope.LastName != null && requestScope.Email != null}">
            <h4>Interview Result of ${requestScope.FirstName} ${requestScope.LastName} (Email: ${requestScope.Email})</h4>
        </c:if>
        <form action = "./ManagerViewCandidates" method = "POST" id = "Back"></form>
        <input type = "hidden" name = "txtSearch" value = "${requestScope.SearchValue}" form = "Back">
        <input type = "SUBMIT" name = "action" value = "Back to Candidate List" form = "Back">
        <c:if test="${requestScope.Evaluations.size() == 0}">
            <h4>Currently unavailable because this candidate has cancelled their application or been disabled by System Admin.</h4>
        </c:if>
        <c:if test="${requestScope.Evaluations.size() != 0}">
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
                            <c:if test = "${status.count % 2 == 1}">
                                <td rowspan=2> ${current.getInterviewID()} </td>
                            </c:if>
                            <td> ${current.getInterviewerID()} </td>
                            <td> ${current.getScore()} </td>
                            <td> ${current.getComment()} </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <form action = "./ManagerAcceptDecline" method = "POST" id = "Change Status"></form>
            <input type = "HIDDEN" name = "Email" value= "${requestScope.Email}" form = "Change Status">
            <input type = "HIDDEN" name = "FirstName" value= "${requestScope.FirstName}" form = "Change Status">
            <input type = "HIDDEN" name = "LastName" value= "${requestScope.LastName}" form = "Change Status">
            <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Change Status">
            <input type = "SUBMIT" name = "action" value = "Accept" form = "Change Status">
            <input type = "SUBMIT" name = "action" value = "Decline" form = "Change Status">
        </c:if>
    </body>
</html>
