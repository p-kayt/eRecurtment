<%-- 
    Document   : cv-read
    Created on : Sep 24, 2022, 11:42:28 AM
    Author     : Huu Minh
--%>

<%@page import="com.t404notfound.erecruitment.bean.cv.SocialMediaDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.cv.AchievementDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.cv.CertificateDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.cv.LanguageDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.cv.ExperienceDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.cv.InterestDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.cv.SkillDTO"%>
<%@page import="com.t404notfound.erecruitment.bean.cv.EducationDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.t404notfound.erecruitment.bean.cv.CVDTO"%>
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
        <c:choose>
            <c:when test = "${not empty cv}">
                <div id="element" class="cv m-auto d"> 

                    <div class="cv-column border border-1 shadow">
                        <div class="cv-element">
                            <!-- Avatar -->
                            <img src="${cv.getAvatar() != null ? cv.getAvatar() : 'image/avatar/default.png'}"/>
                        </div>
                        <div class="cv-element border-bottom shadow">
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
                        <div class="cv-element  border-bottom shadow">
                            <h3> Education </h3>
                            <% for (int i = 0; i < cv.getEducations().size(); i += 1) {%>
                            <div>
                                <%!EducationDTO education;%>
                                <%education = (EducationDTO) cv.getEducations().get(i);%>
                                <div><b>Course: </b> <%=education.getEducationName()%></div>
                                <div><b>Organization: </b> <%=education.getOrganizationName()%></div>
                                <div><b>Status: </b> <%=education.getStatus()%></div>
                            </div>
                            <br>
                            <% }%>                    
                        </div>
                        <div class="cv-element">
                            <h3> Skill </h3>
                            <% for (int i = 0; i < cv.getSkills().size(); i += 1) {%>
                            <div>
                                <%SkillDTO skill;%>
                                <%skill = (SkillDTO) cv.getSkills().get(i);%>
                                <div><b>Skill <%=i + 1%>: </b> <%=skill.getSkillName()%></div>
                                <div><b>Description: </b> <%=skill.getSkillDescription()%></div>
                            </div>
                            <br>
                            <% }%>  
                        </div>
                    </div>
                    <div class="cv-column" style="background: #80bdff">
                        <div class="cv-element border-bottom-dark shadow">
                            <h3> Interest </h3>
                            <% for (int i = 0; i < cv.getInterests().size(); i += 1) {%>
                            <div>
                                <%InterestDTO interest;%>
                                <%interest = (InterestDTO) cv.getInterests().get(i);%>
                                <div><b>Interest <%=i + 1%>: </b> <%=interest.getInterestName()%></div>
                            </div>
                            <br>
                            <% }%> 
                        </div>
                        <div class="cv-element border-bottom-dark shadow">
                            <h3> Experience </h3>
                            <% for (int i = 0; i < cv.getExperiences().size(); i += 1) {%>
                            <div>
                                <%ExperienceDTO experience;%>
                                <%experience = (ExperienceDTO) cv.getExperiences().get(i);%>
                                <div><b>Job <%=i + 1%>: </b> <%=experience.getJobTitle()%></div>
                                <div><b>Organization: </b> <%=experience.getOrganizationName()%></div>
                                <div><b>Description: </b> <%=experience.getExperienceDescription()%></div>
                                <div><b>Duration: </b> <%=experience.getExperienceDuration()%></div>
                            </div>
                            <% }%> 
                        </div>
                        <div class="cv-element border-bottom-dark shadow">
                            <h3> Language </h3>
                            <% for (int i = 0; i < cv.getExperiences().size(); i += 1) {%>
                            <div>
                                <%LanguageDTO language;%>
                                <%language = (LanguageDTO) cv.getLanguages().get(i);%>
                                <div><b>Language <%=i + 1%>: </b> <%=language.getLanguageName()%></div>
                                <div><b>Description: </b> <%=language.getLanguageDescription()%></div>
                            </div>
                            <br>
                            <% }%> 
                        </div>
                        <div class="cv-element border-bottom-dark shadow">
                            <h3> Certificate </h3>
                            <% for (int i = 0; i < cv.getCertificates().size(); i += 1) {%>
                            <div>
                                <%CertificateDTO certificate;%>
                                <%certificate = (CertificateDTO) cv.getCertificates().get(i);%>
                                <div><b>Certificate <%=i + 1%>: </b> <%=certificate.getCertificateName()%></div>
                                <div><b>Link: </b> <%=certificate.getCertificateLink()%></div>
                            </div>
                            <br>
                            <% }%> 
                        </div> 
                        <div class="cv-element border-bottom-dark shadow">
                            <h3> Achievement </h3>
                            <% for (int i = 0; i < cv.getAchievements().size(); i += 1) {%>
                            <div>
                                <%AchievementDTO achievement;%>
                                <%achievement = (AchievementDTO) cv.getAchievements().get(i);%>
                                <div><b>Achievement <%=i + 1%>: </b> <%=achievement.getAchievementName()%></div>
                                <div><b>Description: </b> <%=achievement.getAchievementDescription()%></div>
                            </div>
                            <br>
                            <% }%> 
                        </div>
                        <div class="cv-element">
                            <h3> Social media </h3>
                            <% for (int i = 0; i < cv.getSocialMedias().size(); i += 1) {%>
                            <div>
                                <%SocialMediaDTO socialMedia;%>
                                <%socialMedia = (SocialMediaDTO) cv.getSocialMedias().get(i);%>
                                <div><b>Platform <%=i + 1%>: </b> <%=socialMedia.getPlatformID()%></div>
                                <div><b>Link: </b> <%=socialMedia.getSocialMediaLink()%></div>
                            </div>
                            <br>
                            <% }%> 
                        </div>
                    </div>
                </div>
                <div class="html2pdf__page-break"></div>
                <button onclick="saveCV()">Save to your device</button>
            </c:when>  
            <c:otherwise>
                <h3>CV not found</h3>
            </c:otherwise>
        </c:choose>

    </body>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.8.0/html2pdf.bundle.js"></script>
</html>

<script>
                function saveCV() {
                    var element = document.getElementById('element');
                    html2pdf(element, {
                        filename: 'yourCV.pdf',
                        image: {type: 'png', quality: 0.98},
                        html2canvas: {scale: 2, logging: true, dpi: 192, letterRendering: true},
                        jsPDF: {unit: 'mm', format: 'a4', orientation: 'portrait'}
                    })
                }
</script>
</html>
