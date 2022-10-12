<%-- 
    Document   : cv-read
    Created on : Sep 24, 2022, 11:42:28 AM
    Author     : Huu Minh
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.t404notfound.erecruitment.bean.CVDTO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">        
        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/style_cv.css" type="text/css">
    </head>
    <body>
        <!-- Declare attributes from servlet -->
        <%!CVDTO cv;%>
        <%cv = (CVDTO) request.getAttribute("cv");%>
        <div class="cv">      
            <div class="cv-column">
                <div class="cv-element">
                    <!-- Avatar -->
                    <img src="../../image/sample-avatar.jpg" alt="alt"/>
                </div>
                <div class="cv-element">
                    <h3> Introduction </h3>
                    <span><%=cv.getIntroduction()%></span>
                    <br>
                    <!-- Basic information -->
                    <div><b>First name: </b> <%=cv.getFirstName()%></div>
                    <div><b>Last name: </b> <%=cv.getLastName()%></div>
                    <div><b>Gender: </b> <%=cv.getGender()%></div> 
                    <div><b>Day of birth: </b> <%=cv.getDob()%></div> 
                    <div><b>Email: </b> <%=cv.getEmail()%></div>
                    <div><b>Phone number: </b> <%=cv.getPhoneNumber()%></div>
                    <div><b>Address: </b> <%=cv.getAddress()%></div>
                    <div><b>City: </b> <%=cv.getCity()%></div>
                </div>
                <div class="cv-element">
                    <h3> Education </h3>
                    <div>
                        <div><b>Course: </b> </div>
                        <div><b>Organization: </b> </div>
                        <div><b>Status: </b> </div>
                    </div>
                </div>
            </div>
            <div class="cv-column" style="background: #80bdff">
                <div class="cv-element">
                    <h3> Skill </h3>
                    <div>
                        <div><b>Name: </b> </div>
                        <div><b>Description: </b> </div>
                    </div>
                </div>
                <div class="cv-element">
                    <h3> Interest </h3>
                    <div>
                        <div><b>Name: </b> </div>
                        <div><b>Description: </b> </div>
                    </div>
                </div>
                <div class="cv-element">
                    <h3> Experience </h3>
                    <div>
                        <div><b>Job title: </b> </div>
                        <div><b>Organization: </b> </div>
                        <div><b>Description: </b> </div>
                        <div><b>Duration: </b> </div>
                    </div>
                </div>
                <div class="cv-element">
                    <h3> Language </h3>
                    <div>
                        <div><b>Language: </b> </div>
                        <div><b>Description: </b> </div>
                    </div>
                </div>
                <div class="cv-element">
                    <h3> Certificate </h3>
                    <div>
                        <div><b>Name: </b> </div>
                        <div><b>Link: </b> </div>
                    </div>
                </div> 
                <div class="cv-element">
                    <h3> Achievement </h3>
                    <div>
                        <div><b>Name: </b> </div>
                        <div><b>Description: </b> </div>
                    </div>
                </div>
                <div class="cv-element">
                    <h3> Social media </h3>
                    <div>
                        <div><b>Platform: </b> </div>
                        <div><b>Link: </b> </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
