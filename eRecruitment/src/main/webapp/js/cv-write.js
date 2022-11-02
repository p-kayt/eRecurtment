/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
//for education element
var educationCount = 1;
function addEducation() {
    educationCount++;
    const div = document.createElement("div");
    div.id = 'education' + educationCount.toString();
    const div1 = document.createElement("div");
    div1.innerHTML = '<b>Course ' + educationCount + ': </b> <input type="text" placeholder="What was you learning there?" name="">';
    const div2 = document.createElement("div");
    div2.innerHTML = '<b>Organization: </b> <input type="text" placeholder="Enter your school/univercity/... name" name="">';
    const div3 = document.createElement("div");
    div3.innerHTML = '<b>Status: </b> <!-- Need to change to options --><br><br>';
    div.appendChild(div1);
    div.appendChild(div2);
    div.appendChild(div3);
    root = document.getElementById("education");
    root.appendChild(div);
}
function removeEducation() {
    if (educationCount > 0) {
        var element = document.getElementById('education' + educationCount.toString());
        element.parentNode.removeChild(element);
        educationCount--;
    }
}

//for skill element
var skillCount = 1;
function addSkill() {
    skillCount++;
    const div = document.createElement("div");
    div.id = 'skill' + skillCount.toString();
    const div1 = document.createElement("div");
    div1.innerHTML = '<b>Skill ' + skillCount + ': </b> <input type="text" placeholder="What is your skill?" name="">';
    const div2 = document.createElement("div");
    div2.innerHTML = '<b>Description: </b> <input type="text" placeholder="Tell something about that skill" name=""><br><br>';
    div.appendChild(div1);
    div.appendChild(div2);
    root = document.getElementById("skill");
    root.appendChild(div);
}
function removeSkill() {
    if (skillCount > 0) {
        var element = document.getElementById('skill' + skillCount.toString());
        element.parentNode.removeChild(element);
        skillCount--;
    }
}

//for interest element
var interestCount = 1;
function addInterest() {
    interestCount++;
    const div = document.createElement("div");
    div.id = 'interest' + interestCount.toString();
    const div1 = document.createElement("div");
    div1.innerHTML = '<b>Interest ' + interestCount + ': </b> <input type="text" placeholder="What is your interest?" name="">';
    const div2 = document.createElement("div");
    div2.innerHTML = '<b>Description: </b> <input type="text" placeholder="Tell something about that interest" name=""><br><br>';
    div.appendChild(div1);
    div.appendChild(div2);
    root = document.getElementById("interest");
    root.appendChild(div);
}
function removeInterest() {
    if (interestCount > 0) {
        var element = document.getElementById('interest' + interestCount.toString());
        element.parentNode.removeChild(element);
        interestCount--;
    }
}

//for experience element
var experienceCount = 1;
function addExperience() {
    experienceCount++;
    const div = document.createElement("div");
    div.id = 'experience' + experienceCount.toString();
    const div1 = document.createElement("div");
    div1.innerHTML = '<div><b>Job ' + experienceCount + ': </b> <input type="text" placeholder="Enter your job name" name=""></div>';
    const div2 = document.createElement("div");
    div2.innerHTML = '<div><b>Organization: </b> <input type="text" placeholder="Enter your organization name" name=""></div>';
    const div3 = document.createElement("div");
    div3.innerHTML = '<div><b>Description: </b> <input type="text" placeholder="Tell something about your job" name=""></div>';
    const div4 = document.createElement("div");
    div4.innerHTML = '<div><b>Duration: </b> <input type="text" placeholder="How long did you work there?" name=""></div>';
    div.appendChild(div1);
    div.appendChild(div2);
    div.appendChild(div3);
    div.appendChild(div4);
    root = document.getElementById("experience");
    root.appendChild(div);
}
function removeExperience() {
    if (experienceCount > 0) {
        var element = document.getElementById('experience' + experienceCount.toString());
        element.parentNode.removeChild(element);
        experienceCount--;
    }
}

//for language element
var languageCount = 1;
function addLanguage() {
    languageCount++;
    const div = document.createElement("div");
    div.id = 'language' + languageCount.toString();
    const div1 = document.createElement("div");
    div1.innerHTML = '<b>Language ' + languageCount + ': </b> <input type="text" placeholder="Enter your language" name="">';

    const div2 = document.createElement("div");
    div2.innerHTML = '<b>Description: </b> <input type="text" placeholder="Tell something about how you study and use that language" name=""><br><br>';

    div.appendChild(div1);
    div.appendChild(div2);
    root = document.getElementById("language");
    root.appendChild(div);
}
function removeLanguage() {
    if (languageCount > 0) {
        var element = document.getElementById('language' + languageCount.toString());
        element.parentNode.removeChild(element);
        languageCount--;
    }
}

//for certificate element
var certificateCount = 1;
function addCertificate() {
    certificateCount++;
    const div = document.createElement("div");
    div.id = 'certificate' + certificateCount.toString();
    const div1 = document.createElement("div");
    div1.innerHTML = '<b>Certificate: ' + certificateCount + ' </b> <input type="text" placeholder="Enter your certificate name" name="">';

    const div2 = document.createElement("div");
    div2.innerHTML = '<b>Link: </b> <input type="text" placeholder="Enter the link of it" name="">';

    div.appendChild(div1);
    div.appendChild(div2);
    root = document.getElementById("certificate");
    root.appendChild(div);
}
function removeCertificate() {
    if (certificateCount > 0) {
        var element = document.getElementById('certificate' + certificateCount.toString());
        element.parentNode.removeChild(element);
        certificateCount--;
    }
}

//for achievement element
var achievementCount = 1;
function addAchievement() {
    achievementCount++;
    const div = document.createElement("div");
    div.id = 'achievement' + achievementCount.toString();
    const div1 = document.createElement("div");
    div1.innerHTML = '<b>Achievement ' + achievementCount + ': </b> <input type="text" placeholder="Enter your achievement name" name="">';

    const div2 = document.createElement("div");
    div2.innerHTML = '<b>Description: </b> <input type="text" placeholder="Tell something about your achievement" name="">';

    div.appendChild(div1);
    div.appendChild(div2);
    root = document.getElementById("achievement");
    root.appendChild(div);
}
function removeAchievement() {
    if (achievementCount > 0) {
        var element = document.getElementById('achievement' + achievementCount.toString());
        element.parentNode.removeChild(element);
        achievementCount--;
    }
}

function submitFormImage() {
    document.getElementById("upload-image").submit();
}


