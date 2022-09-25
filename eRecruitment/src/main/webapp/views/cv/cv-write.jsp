<%-- 
    Document   : cv-read
    Created on : Sep 24, 2022, 11:42:28 AM
    Author     : Huu Minh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">        
        <!-- Css Styles -->
        <link rel="stylesheet" href="../../css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="../../css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="../../css/style_cv.css" type="text/css">
    </head>
    <body>
        <form class="cv">      
            <div class="cv-column">
                <div class="cv-element">
                    <!-- Avatar -->
                    <img src="../../image/sample-avatar.jpg" alt="alt"/>
                </div>
                <div class="cv-element">
                    <h3> Introduction </h3>
                    <input type="text" placeholder="Say something about yourself" name="">
                    <br>
                    <!-- Basic information -->
                    <div><b>First name: </b> <input type="text" placeholder="Enter your first name" name=""></div>
                    <div><b>Last name: </b> <input type="text" placeholder="Enter your last name" name=""></div>
                    <div><b>Gender: </b> <!-- Need to change to options --><input type="text" placeholder="Enter your gender" name=""></div> 
                    <div><b>Day of birth: </b> <input type="text" placeholder="Enter your birthday" name=""></div> 
                    <div><b>Email: </b> <input type="text" placeholder="Enter your email" name=""></div>
                    <div><b>Phone number: </b> <input type="text" placeholder="Enter your phone number" name=""></div>
                    <div><b>Address: </b> <input type="text" placeholder="Enter your address" name=""></div>
                    <div><b>City: </b> <input type="text" placeholder="Enter your city name" name=""></div>
                </div>
                <div class="cv-element">
                    <h3> Education </h3>
                    <div>
                        <div><b>Course: </b> <input type="text" placeholder="What was you learning there?" name=""></div>
                        <div><b>Organization: </b> <input type="text" placeholder="Enter your school/univercity/... name" name=""></div>
                        <div><b>Status: </b> <!-- Need to change to options --></div>
                    </div>
                    <span class="fa fa-plus-circle fa-2x"></span>
                </div>
            </div>
            <div class="cv-column" style="background: #80bdff">
                <div class="cv-element">
                    <h3> Skill </h3>
                    <div>
                        <div><b>Name: </b> <input type="text" placeholder="Enter your skill's name" name=""></div>
                        <div><b>Description: </b> <input type="text" placeholder="Tell something about that skill" name=""></div>
                    </div>
                    <span class="fa fa-plus-circle fa-2x"></span>
                </div>
                <div class="cv-element">
                    <h3> Interest </h3>
                    <div>
                        <div><b>Name: </b> <input type="text" placeholder="What is your interest?" name=""></div>
                        <div><b>Description: </b> <input type="text" placeholder="Tell something about that interest" name=""></div>
                    </div>
                    <span class="fa fa-plus-circle fa-2x"></span>
                </div>
                <div class="cv-element">
                    <h3> Experience </h3>
                    <div>
                        <div><b>Job title: </b> <input type="text" placeholder="Enter your job name" name=""></div>
                        <div><b>Organization: </b> <input type="text" placeholder="Enter your organization name" name=""></div>
                        <div><b>Description: </b> <input type="text" placeholder="Tell something about your job" name=""></div>
                        <div><b>Duration: </b> <input type="text" placeholder="How long did you work there?" name=""></div>
                    </div>
                    <span class="fa fa-plus-circle fa-2x"></span>
                </div>
                <div class="cv-element">
                    <h3> Language </h3>
                    <div>
                        <div><b>Language: </b> <input type="text" placeholder="Enter your language" name=""></div>
                        <div><b>Description: </b> <input type="text" placeholder="Tell something about how you study and use that language" name=""></div>
                    </div>
                    <span class="fa fa-plus-circle fa-2x"></span>
                </div>
                <div class="cv-element">
                    <h3> Certificate </h3>
                    <div>
                        <div><b>Name: </b> <input type="text" placeholder="Enter your certificate name" name=""></div>
                        <div><b>Link: </b> <input type="text" placeholder="Enter the link of it" name=""></div>
                    </div>
                    <span class="fa fa-plus-circle fa-2x"></span>
                </div> 
                <div class="cv-element">
                    <h3> Achievement </h3>
                    <div>
                        <div><b>Name: </b> <input type="text" placeholder="Enter your achievement name" name=""></div>
                        <div><b>Description: </b> <input type="text" placeholder="Tell something about your achievement" name=""></div>
                    </div>
                    <span class="fa fa-plus-circle fa-2x"></span>
                </div>
                <div class="cv-element">
                    <h3> Social media </h3>
                    <div>
                        <div><b>Platform: </b><!-- Choose platform --> </div>
                        <div><b>Link: </b> <input type="text" placeholder="Enter the link of your personal page" name=""></div>
                    </div>
                    <span class="fa fa-plus-circle fa-2x"></span>
                </div>
            </div>
        </form>
    </body>
</html>

