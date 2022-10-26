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
                        <th>Information</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var = "current" items="${requestScope.Users}" varStatus = "status" >
                        <tr>
                            <td> ${current.getUserID()} </td>
                            <td><div> Email: ${current.getEmail()} </div>
                                <div> Name: ${current.getFirstName()} ${current.getLastName()} </div>
                                <div> Gender: ${current.getGender()} </div> </td>
                            <td><c:choose>
                                    <c:when test = "${current.getUserRole() == 'System Admin'}">
                                        ${current.getUserRole()}
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test = "${current.getUserRole() == 'Candidate'}">
                                            <select name = "Role" form = "Assign Role_${current.getEmail()}">
                                                <option value="Candidate">Candidate</option>
                                                <option value="HR Staff">HR Staff</option>
                                                <option value="HR Manager">HR Manager</option>
                                                <option value="Interviewer">Interviewer</option>
                                                <option disabled value="System Admin">System Admin</option>
                                            </select>
                                        </c:if>
                                        <c:if test = "${current.getUserRole() == 'HR Staff'}">
                                            <select name = "Role" form = "Assign Role_${current.getEmail()}">
                                                <option value="HR Staff">HR Staff</option>
                                                <option value="Candidate">Candidate</option>
                                                <option value="HR Manager">HR Manager</option>
                                                <option value="Interviewer">Interviewer</option>
                                                <option disabled value="System Admin">System Admin</option>
                                            </select>
                                        </c:if>
                                        <c:if test = "${current.getUserRole() == 'HR Manager'}">
                                            <select name = "Role" form = "Assign Role_${current.getEmail()}">
                                                <option value="HR Staff">HR Manager</option>
                                                <option value="Candidate">Candidate</option>
                                                <option value="HR Manager">HR Staff</option>
                                                <option value="Interviewer">Interviewer</option>
                                                <option disabled value="System Admin">System Admin</option>
                                            </select>
                                        </c:if>
                                        <c:if test = "${current.getUserRole() == 'Interviewer'}">
                                            <select name = "Role" form = "Assign Role_${current.getEmail()}">
                                                <option value="Interviewer">Interviewer</option>
                                                <option value="Candidate">Candidate</option>
                                                <option value="HR Manager">HR Staff</option>
                                                <option value="HR Staff">HR Manager</option>
                                                <option disabled value="System Admin">System Admin</option>
                                            </select>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td> ${current.getStatus()}
                            </td>
                            <td>
                                <c:choose> 
                                    <c:when test = "${current.getUserRole() == 'System Admin'}">
                                    </c:when>
                                    <c:otherwise>
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
                                        <form action = "./AdminAssignRoles" method = "POST" id = "Assign Role_${current.getEmail()}"></form>
                                        <input type = "HIDDEN" name = "Email" value= "${current.getEmail()}" form = "Assign Role_${current.getEmail()}">
                                        <input type = "HIDDEN" name = "SearchValue" value= "${requestScope.SearchValue}" form = "Assign Role_${current.getEmail()}">
                                        <input type = "SUBMIT" name = "action" value = "Submit Role Change" form = "Assign Role_${current.getEmail()}">
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
