<%-- 
    Document   : cv-read
    Created on : Sep 24, 2022, 11:42:28 AM
    Author     : Huu Minh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">        
        <!-- Css Styles -->
        <link rel="stylesheet" href="css/bootstrap.min.css" type="text/css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/elegant-icons.css" type="text/css">
        <link rel="stylesheet" href="css/style_cv.css" type="text/css">
    </head>
    <body>
        
        
        <form action="cv" method="get">    
            
            <div class="cv">
                
                <div class="cv-column">
                    <div class="cv-element">
                        <!-- Avatar -->
                        <img src="../../image/sample-avatar.jpg" alt="alt"/>
                    </div>
                    <div class="cv-element">
                        <h3> Introduction </h3>
                        <input type="text"
                               value = "${requestScope.cv.introduction}"
                               placeholder="Say something about yourself" 
                               name="introduction">
                        <br>
                        <!-- Basic information -->
                        <div><b>First name: </b> <input
                                type="text"
                                id="firstName"
                                name = "firstName"
                                value = "${firstName}"
                                placeholder="Enter your first name"
                                /></div>
                        <div><b>Last name: </b> <input
                                type="text"
                                id="lastName"
                                name = "lastName"
                                value = "${requestScope.cv.lastName}"
                                placeholder="Enter your last name"
                                /></div>
                        <div><b>Gender: </b> <input type="radio" id="male" name="gender" value="Male" checked>
                            <label for="male">Male</label>

                            <input type="radio" id="female" name="gender" value="Female">
                              <label for="female">Female</label>
                              
                            <input type="radio" id="other" name="gender" value="Other">
                              <label for="other">Other</label></div> 
                        <div><b>Day of birth: </b> <input type="date" name="date" value = "${dob}" > <br/></div> 
                        <div><b>Email: </b> <input
                                type="email"
                                id="email"
                                name = "email"
                                value= "${email}"
                                placeholder="Enter your email"
                                /></div>
                        <div><b>Phone number: </b>  <input
                                type="text"
                                id="phoneNumber"
                                name = "phoneNumber"
                                value= "${phoneNumber}"
                                placeholder="Enter your phone number"
                                /></div>
                        <div><b>Address: </b> <input
                                type="text"
                                id="address"
                                name = "address"
                                value= "${address}"
                                placeholder="Enter your address"
                                /></div>
                        <div><b>City: </b> <input
                                type="text"
                                id="city"
                                name = "city"
                                value= "${city}"
                                placeholder="Enter your city"
                                /></div>
                    </div>
                    <!--                    <div class="cv-element">
                                            <h3> Education </h3>
                                            <div id="education">
                                                <div id="education1">
                                                    <div><b>Course: 1 </b> <input type="text" placeholder="What was you learning there?" name=""></div>
                                                    <div><b>Organization: </b> <input type="text" placeholder="Enter your school/univercity/... name" name=""></div>
                                                    <div><b>Status: </b>  Need to change to options </div>
                                                    <br>
                                                </div>
                                            </div>
                                            <span class="fa fa-plus-circle fa-2x" onclick="addEducation()"></span>
                                            <span class="fa fa-minus-circle fa-2x" onclick="removeEducation()"></span>
                    
                                        </div>
                                        <div class="cv-element">
                                            <h3> Skill </h3>
                                            <div id="skill">
                                                <div id="skill1">
                                                    <div><b>Skill 1: </b> <input type="text" placeholder="What is your skill?" name=""></div>
                                                    <div><b>Description: </b> <input type="text" placeholder="Tell something about that skill" name=""><br><br></div>
                                                </div>
                                            </div>
                                            <span class="fa fa-plus-circle fa-2x" onclick="addSkill()"></span>
                                            <span class="fa fa-minus-circle fa-2x" onclick="removeSkill()"></span>
                    
                                        </div>-->
                </div>
                <!--                <div class="cv-column" style="background: #80bdff">
                
                                    <div class="cv-element">
                                        <div id="interest">
                                            <h3> Interest </h3>
                                            <div id="interest1">
                                                <div><b>Interest 1: </b> <input type="text" placeholder="What is your interest?" name=""></div>
                                                <div><b>Description: </b> <input type="text" placeholder="Tell something about that interest" name=""><br><br></div>
                                            </div>
                                        </div>
                                        <span class="fa fa-plus-circle fa-2x" onclick="addInterest()"></span>
                                        <span class="fa fa-minus-circle fa-2x" onclick="removeInterest()"></span>
                
                                    </div>
                                    <div class="cv-element">
                                        <h3> Experience </h3>
                                        <div id="experience">
                                            <div id="experience1">
                                                <div><b>Job 1: </b> <input type="text" placeholder="Enter your job name" name=""></div>
                                                <div><b>Organization: </b> <input type="text" placeholder="Enter your organization name" name=""></div>
                                                <div><b>Description: </b> <input type="text" placeholder="Tell something about your job" name=""></div>
                                                <div><b>Duration: </b> <input type="text" placeholder="How long did you work there?" name=""></div>
                                            </div>
                                        </div>
                                        <span class="fa fa-plus-circle fa-2x" onclick="addExperience()"></span>
                                        <span class="fa fa-minus-circle fa-2x" onclick="removeExperience()"></span>
                                    </div>
                                    <div class="cv-element">
                                        <h3> Language </h3>
                                        <div id="language">
                                            <div id="language1">
                                                <div><b>Language 1: </b> <input type="text" placeholder="Enter your language" name=""></div>
                                                <div><b>Description: </b> <input type="text" placeholder="Tell something about how you study and use that language" name=""></div>
                                            </div>
                
                                        </div>
                                        <span class="fa fa-plus-circle fa-2x" onclick="addLanguage()"></span>
                                        <span class="fa fa-minus-circle fa-2x" onclick="removeLanguage()"></span>
                                    </div>
                                    <div class="cv-element">
                                        <h3> Certificate </h3>
                                        <div id="certificate">
                                            <div id="certificate1">
                                                <div><b>Certificate 1: </b> <input type="text" placeholder="Enter your certificate name" name=""></div>
                                                <div><b>Link: </b> <input type="text" placeholder="Enter the link of it" name=""></div>
                                            </div>
                                        </div>
                                        <span class="fa fa-plus-circle fa-2x" onclick="addCertificate()"></span>
                                        <span class="fa fa-minus-circle fa-2x" onclick="removeCertificate()"></span>
                                    </div> 
                                    <div class="cv-element">
                                        <h3> Achievement </h3>
                                        <div id="achievement">
                                            <div id="achievement1">
                                                <div><b>Achievement 1: </b> <input type="text" placeholder="Enter your achievement name" name=""></div>
                                                <div><b>Description: </b> <input type="text" placeholder="Tell something about your achievement" name=""></div>
                                            </div>
                                        </div>
                                        <span class="fa fa-plus-circle fa-2x" onclick="addAchievement()"></span>
                                        <span class="fa fa-minus-circle fa-2x" onclick="removeAchievement()"></span>
                                    </div>
                                    <div class="cv-element">
                                        <h3> Social media </h3>
                                        <div id="socialmedia">
                                            <div id="socialmedia">
                                                <div><b>Platform 1: </b> Choose platform  </div>
                                                <div><b>Link: </b> <input type="text" placeholder="Enter the link of your personal page" name="" value=""></div>
                                            </div>
                                        </div>
                                        <span class="fa fa-plus-circle fa-2x"></span>
                                    </div>
                                </div>-->
            </div>
            <input type ="hidden" name="action" value="createCV">
            <button type="submit">
                Submit
            </button>
        </form>


        <script src="js/cv-write.js"></script>
    </body>
</html>

