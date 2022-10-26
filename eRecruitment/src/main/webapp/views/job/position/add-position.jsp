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
        <h3>Add a New Position For Recruiting</h3>
        <form action="../../../job" method="post">
            <label for="name">Name:</label> <input type="text" id="name" name="name" value="" />
            </br>
            <label for="description">Description:</label> <input type="text" id="description" name="description" value="" />
            </br>
            <label for="quantity">Hiring Quantity:</label> <input type="number" id="quantity" name="quantity" value="" min="0" max="999999"/>
            </br>
            <label for="date">Created Date:</label> <input type="date" id="date" name="date" value=""/>
            </br>
            <label for="status">Status: </label>
            <select id="status" name="status">
                <option value="1">inActive</option>
                <option value="2">Pending</option>
                <option value="3" selected>Hiring</option>
                <option value="4">Closed</option>
            </select>
            </br>
            <input type="hidden" name="action" value="add-position">
            <input type="submit" value="Submit">
        </form>
    </body>
</html>
