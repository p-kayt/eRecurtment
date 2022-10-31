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
        <title>Thêm Vị Trí Mới</title>
    </head>
    <body>
        <div>
            <div>
                <h3>Thêm Vị Trí Mới</h3>
            </div>
        </div>
        <div>
            <div>
                <form action="./job" method="post">
                    <label for="name">Tên</label> <input type="text" id="name" name="name" value="" placeholder="Nhập tên vị trí..."/>
                    </br>
                    <label for="description">Mô Tả</label> <input type="text" id="description" name="description" value="" placeholder="Nhập mô tả vị trí..."/>
                    </br>
                    <label for="quantity">Số Lượng Tuyển</label> <input type="number" id="quantity" name="quantity" value="" min="0" max="999999" placeholder="Nhập số lượng tuyển"/>
                    </br>
                    <label for="date">Ngày Tạo</label> <input type="date" id="date" name="date" value=""/>
                    </br>
                    <label for="status">Trạng Thái </label>
                    <select id="status" name="status">
                        <option value="1">inActive</option>
                        <option value="2">Pending</option>
                        <option value="3" selected>Hiring</option>
                        <option value="4">Closed</option>
                    </select>
                    </br>
                    <input type="hidden" name="action" value="add-position">
                    <input type="submit" value="Thêm Vị Trí">
                </form>
            </div>
        </div>
    </body>
</html>
