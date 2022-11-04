<%-- 
    Document   : cv-read
    Created on : Sep 24, 2022, 11:42:28 AM
    Author     : Huu Minh
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.t404notfound.erecruitment.bean.cv.CVDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>

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

        <div class="container-xxl bg-white p-0">
            <!-- navi -->
            <c:if test="${empty user}">
                <jsp:include page="../header/header_loginbtn.jsp" />
            </c:if>

            <c:if test="${not empty user}">
                <jsp:include page="../header/header_logoutbtn.jsp" />
            </c:if>

            <%!CVDTO cv;%>
            <%cv = (CVDTO) request.getAttribute("cv");%>
            <script src="js/cv-write.js"></script>

            <c:if test="${not empty cv}">

                <form id="f" action="cv" method="post" enctype="multipart/form-data" onsubmit="updateAlert()">
                </c:if>
                <c:if test="${empty cv}">
                    <form id="f" action="cv" method="post" enctype="multipart/form-data" onsubmit="createAlert()">
                    </c:if>
                    <div class="cv">
                        <div class="cv-column">
                            <div class="cv-element image-upload">

                                <input id="file-input" type="file" name="file" accept="image/png" value="${cv.avatar != null ? cv.avatar : 'image/avatar/default.png'}"
                                       onchange="document.getElementById('output').src = window.URL.createObjectURL(this.files[0])"/>

                            </div>
                            <c:if test="${not empty cv}"><input type="hidden"
                                   value="${requestScope.cv.CVID}"
                                   name="CVID"></c:if>

                                <div class="cv-element">
                                    <label for="file-input">
                                        <img id="output" class="ava_img" src="${cv.avatar != null ? cv.avatar : 'image/avatar/default.png'}" alt="avatar"/>
                                </label>
                            </div>

                            <div class="cv-element">
                                <h3> Introduction </h3>
                                <input type="text"
                                       value="${requestScope.cv.introduction}"
                                       placeholder="Say something about yourself"
                                       name="introduction">
                                <br>
                                <!-- Basic information -->
                                <div><b>First name: </b> <input
                                        type="text"
                                        id="firstName"
                                        name="firstName"
                                        value="${requestScope.cv.firstName}"
                                        placeholder="Enter your first name"
                                        /></div>
                                <div><b>Last name: </b> <input
                                        type="text"
                                        id="lastName"
                                        name="lastName"
                                        value="${requestScope.cv.lastName}"
                                        placeholder="Enter your last name"
                                        /></div>
                                <div><b>Gender: </b> 

                                    <select name="gender" id="status-select">

                                        <option value="" disabled="">--Please choose a gender--</option>

                                        <option value="1" <c:if test="${cv.gender == 1}">selected</c:if>>Male</option>
                                        <option value="2"<c:if test="${cv.gender == 2}">selected</c:if>>Female</option>
                                        <option value="3"<c:if test="${cv.gender == 3}">selected</c:if>>Other</option>
                                        </select>



                                    </div>
                                    <div><b>Day of birth: </b> <input type="date" name="date" value="${requestScope.cv.dob}"> <br/></div>
                                <div><b>Email: </b> <input
                                        type="email"
                                        id="email"
                                        name="email"
                                        value="${requestScope.cv.email}"
                                        placeholder="Enter your email"
                                        /></div>
                                <div><b>Phone number: </b> <input
                                        type="text"
                                        id="phoneNumber"
                                        name="phoneNumber"
                                        value="${requestScope.cv.phoneNumber}"
                                        placeholder="Enter your phone number"
                                        pattern="^[0-9\-\+]{9,15}$"/></div>
                                <div><b>Address: </b> <input
                                        type="text"
                                        id="address"
                                        name="address"
                                        value="${requestScope.cv.address}"
                                        placeholder="Enter your address"
                                        /></div>
                                <div><b>City: </b> <input
                                        type="text"
                                        id="city"
                                        name="city"
                                        value="${requestScope.cv.city}"
                                        placeholder="Enter your city"
                                        /></div>
                            </div>
                            <div class="cv-element">
                                <h3> Education </h3>
                                <div id="education">
                                    <c:forEach var="i" items="${requestScope.cv.educations}" varStatus="loop">
                                        <div id="education${loop.count}">
                                            <b>Course ${loop.count}: </b> <input type="text" placeholder="What was you learning there?" name="educationName" value="${i.educationName}">
                                            <b>Organization: </b> <input type="text" placeholder="Enter your school/univercity/... name" name="organizationName" value="${i.organizationName}">
                                            <div>
                                                <b>Status: </b> 
                                                <select name="status" id="status-select">

                                                    <option value="" disabled="">--Please choose a status--</option>

                                                    <option value="1" <c:if test="${i.status==1}">selected</c:if>>Complete</option>
                                                    <option value="2"<c:if test="${i.status==2}">selected</c:if>>In-progress</option>
                                                    </select>
                                                </div>

                                                <br><br>
                                            </div>
                                    </c:forEach>
                                    <script>educationCount = ${cv.getEducations().size()};</script>

                                </div>
                                <span class="fa fa-plus-circle fa-2x" onclick="addEducation()"></span>
                                <span class="fa fa-minus-circle fa-2x" onclick="removeEducation()"></span>

                            </div>
                            <div class="cv-element">
                                <h3> Skill </h3>

                                <div id="skill">

                                    <c:forEach var="i"  items="${requestScope.cv.skills}" varStatus="loop">
                                        <div id="skill${loop.count}">
                                            <b>Skill ${loop.count}: </b> <input type="text" placeholder="What is your skill?" name="skillName" value="${i.skillName}">
                                            <b>Description: </b> <input type="text" placeholder="Tell something about that skill" name="skillDescription" value="${i.skillDescription}">
                                            <br><br>
                                        </div>
                                    </c:forEach>
                                    <script>skillCount = ${cv.getSkills().size()};</script>

                                </div>

                                <span class="fa fa-plus-circle fa-2x" onclick="addSkill()"></span>
                                <span class="fa fa-minus-circle fa-2x" onclick="removeSkill()"></span>
                            </div>



                        </div>

                        <div class="cv-column" style="background: #80bdff">

                            <div class="cv-element">
                                <h3> Interest </h3>
                                <div id="interest">
                                    <c:forEach var="i"  items="${requestScope.cv.interests}" varStatus="loop">


                                        <div id="interest${loop.count}">
                                            <div><b>Interest ${loop.count}: </b> <input type="text" placeholder="What is your interest?" name="interestName" value="${i.interestName}"></div>
                                            <br>
                                        </div>


                                    </c:forEach>
                                    <script>interestCount = ${cv.getInterests().size()};</script>
                                </div>

                                <span class="fa fa-plus-circle fa-2x" onclick="addInterest()"></span>
                                <span class="fa fa-minus-circle fa-2x" onclick="removeInterest()"></span>

                            </div>
                            <div class="cv-element">
                                <h3> Experience </h3>

                                <div id="experience">
                                    <c:forEach var="i"  items="${requestScope.cv.experiences}" varStatus="loop">
                                        <div id="experience${loop.count}">
                                            <div><b>Activity ${loop.count}: </b> <input type="text" placeholder="Enter your activity name" name="jobTitle" value="${i.jobTitle}"></div>
                                            <div><b>Organization: </b> <input type="text" placeholder="Enter your organization name" name="experienceOrganizationName" value="${i.experienceOrganizationName}">
                                            </div>
                                            <div><b>Description: </b> <input type="text" placeholder="Tell something about your job" name="experienceDescription" value="${i.experienceDescription}">
                                            </div>
                                            <div><b>Duration: </b> <input type="text" placeholder="How long did you work there?" name="experienceDuration" value="${i.experienceDuration}"></div>
                                        </div>
                                        <br>
                                    </c:forEach>
                                    <script>experienceCount = ${cv.getExperiences().size()};</script>
                                </div>

                                <span class="fa fa-plus-circle fa-2x" onclick="addExperience()"></span>
                                <span class="fa fa-minus-circle fa-2x" onclick="removeExperience()"></span>
                            </div>
                            <div class="cv-element">
                                <h3> Language </h3>
                                <div id="language">
                                    <c:forEach var="i"  items="${requestScope.cv.languages}" varStatus="loop">

                                        <div id="language${loop.count}">
                                            <div><b>Language ${loop.count}: </b> <input type="text" placeholder="Enter your language" name="languageName" value="${i.languageName}"/></div>
                                            <div><b>Description: </b> <input type="text"
                                                                             placeholder="Tell something about how you study and use that language"
                                                                             name="languageDescription"
                                                                             value="${i.languageDescription}"/></div>
                                        </div>

                                    </c:forEach>
                                    <br>
                                    <script>languageCount = ${cv.getLanguages().size()};</script>
                                </div>

                                <span class="fa fa-plus-circle fa-2x" onclick="addLanguage()"></span>
                                <span class="fa fa-minus-circle fa-2x" onclick="removeLanguage()"></span>
                            </div>
                            <div class="cv-element">
                                <h3> Certificate </h3>
                                <div id="certificate">
                                    <c:forEach var="i"  items="${requestScope.cv.certificates}" varStatus="loop">

                                        <div id="certificate${loop.count}">
                                            <div><b>Certificate ${loop.count}: </b> <input type="text" placeholder="Enter your certificate name" name="certificateName" value="${i.certificateName}">
                                            </div>
                                            <div><b>Link: </b> <input type="text" placeholder="Enter the link of it" name="certificateLink" value="${i.certificateLink}"></div>
                                        </div>
                                    </c:forEach>
                                    <br>
                                    <script>certificateCount = ${cv.getCertificates().size()};</script>
                                </div>

                                <span class="fa fa-plus-circle fa-2x" onclick="addCertificate()"></span>
                                <span class="fa fa-minus-circle fa-2x" onclick="removeCertificate()"></span>
                            </div>
                            <div class="cv-element">
                                <h3> Achievement </h3>
                                <div id="achievement">
                                    <c:forEach var="i"  items="${requestScope.cv.achievements}" varStatus="loop">

                                        <div id="achievement${loop.count}">
                                            <div><b>Achievement ${loop.count}: </b> <input type="text" placeholder="Enter your achievement name" name="achivementName" value="${i.achievementName}">
                                            </div>
                                            <div><b>Description: </b> <input type="text" placeholder="Tell something about your achievement"
                                                                             name="achievementDescription" value="${i.achievementDescription}"></div>

                                        </div>
                                    </c:forEach>
                                    <br>
                                    <script>achievementCount = ${cv.getAchievements().size()};</script>
                                </div>

                                <span class="fa fa-plus-circle fa-2x" onclick="addAchievement()"></span>
                                <span class="fa fa-minus-circle fa-2x" onclick="removeAchievement()"></span>
                            </div>
                            <div class="cv-element">
                                <h3> Social media </h3>
                                <div id="socialMedia">
                                    <c:forEach var="i"  items="${cv.socialMedias}" varStatus="loop">

                                        <div id="socialMedia${loop.count}">
                                            <div><b>Platform ${loop.count}: </b> 
                                                <select name="platformID">

                                                    <option value="" disabled="">--Please choose a platform--</option>

                                                    <option value="1" <c:if test="${i.platformID == 1}">selected</c:if>>LinkedIn</option>
                                                    <option value="2"<c:if test="${i.platformID == 2}">selected</c:if>>Facebook</option>
                                                    <option value="3"<c:if test="${i.platformID == 3}">selected</c:if>>Twitter</option>
                                                    <option value="4"<c:if test="${i.platformID == 4}">selected</c:if>>GitHub</option>
                                                    <option value="5"<c:if test="${i.platformID == 5}">selected</c:if>>Personal Website</option>
                                                    </select>
                                                </div>
                                                <div><b>Link: </b> <input type="text" placeholder="Enter the link of your personal page" name="socialMediaLink"
                                                                          value="${i.socialMediaLink}"></div>
                                        </div>
                                    </c:forEach>
                                    <br>
                                    <script>socialMediaCount = ${cv.getSocialMedias().size()};</script>
                                </div>
                                <span class="fa fa-plus-circle fa-2x" onclick="addSocialMedia()"></span>
                                <span class="fa fa-minus-circle fa-2x" onclick="removeSocialMedia()"></span>
                            </div>
                        </div>
                    </div>

                    <input type="hidden" name="action" value="${requestScope.action}">
                    <button type="submit">
                        Submit
                    </button>

                </form>


        </div>
<jsp:include page="../footer/footer.jsp" />
    </body>
</html>

