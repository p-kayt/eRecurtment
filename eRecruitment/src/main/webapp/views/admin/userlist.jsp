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

        <h3>${requestScope.errorMsg}</h3>

        <c:if test = "${not empty requestScope.Users}">
            <table border="1">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>Email</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Gender</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var = "current" items="${requestScope.Users}" varStatus = "status" >
                        <tr>
                            <td> ${current.getUserID()} </td>
                            <td> ${current.getEmail()} </td>
                            <td> ${current.getFirstName()} </td>
                            <td> ${current.getLastName()} </td>
                            <td> ${current.getGender()} </td>
                            <td><c:choose>
                                    <c:when test = "${current.getUserRole() == 'System Admin'}">
                                        ${current.getUserRole()}
                                    </c:when>
                                    <c:otherwise>
                                        <div>
                                            <label for="isCandidate">Candidate </label>
                                            <input type="checkbox" onclick="return false;" id="isCandidate" name="isCandidate" value="true" form = "Assign Role_${current.getEmail()}" 
                                                   <c:if test="${current.isIsCandidate()}">
                                                       checked
                                                   </c:if>
                                                   >
                                        </div>
                                        <div>
                                            <label for="isHRStaff">HR Staff </label>
                                            <input type="checkbox" id="isHRStaff" name="isHRStaff" value="true" form = "Assign Role_${current.getEmail()}"
                                                   <c:if test="${current.isIsHRStaff()}">
                                                       checked
                                                   </c:if>
                                                   >
                                        </div>
                                        <div>
                                            <label for="isHRManager">HR Manager </label>
                                            <input type="checkbox" id="isHRManager" name="isHRManager" value="true" form = "Assign Role_${current.getEmail()}"
                                                   <c:if test="${current.isIsHRManager()}">
                                                       checked
                                                   </c:if>
                                                   >
                                        </div>
                                        <div>
                                            <label for="isInterviewer">Interviewer </label>
                                            <input type="checkbox" id="isInterviewer" name="isInterviewer" value="true" form = "Assign Role_${current.getEmail()}"
                                                   <c:if test="${current.isIsInterviewer()}">
                                                       checked
                                                   </c:if>
                                                   >
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td> ${current.getStatus()} </td>
                            <td>
                                <c:choose> 
                                    <c:when test = "${current.getUserRole() == 'System Admin'}">
                                    </c:when>
                                    <c:otherwise>
                                        <div>
                                            <form action = "./adminUpdateUsers" method = "POST" id = "Change Status_${current.getEmail()}"></form>
                                            <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "Change Status_${current.getEmail()}">
                                            <input type = "HIDDEN" name = "Status" value= "${current.getStatus()}" form = "Change Status_${current.getEmail()}">
                                            <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Change Status_${current.getEmail()}">
                                            <c:choose> 
                                                <c:when test = "${current.getStatus() == 'Active'}">
                                                    <input type = "SUBMIT" name = "action" value = "Set to inActive" form = "Change Status_${current.getEmail()}">
                                                </c:when>
                                                <c:otherwise>
                                                    <input type = "SUBMIT" name = "action" value = "Set to Active" form = "Change Status_${current.getEmail()}">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div>
                                            <form action = "./AdminAssignRoles" method = "POST" id = "Assign Role_${current.getEmail()}"></form>
                                            <input type = "HIDDEN" name = "ID" value= "${current.getUserID()}" form = "Assign Role_${current.getEmail()}">
                                            <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "Assign Role_${current.getEmail()}">
                                            <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Assign Role_${current.getEmail()}">
                                            <input type = "SUBMIT" name = "action" value = "Submit Role Change" form = "Assign Role_${current.getEmail()}">
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>                
        </c:if>
    </body>
</html>
