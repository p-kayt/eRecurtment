/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var requirementCount = 0;
function addRequirement() {
    requirementCount++;
    const div = document.createElement("div");
    div.id = 'requirementContainer' + requirementCount;
    div.innerHTML = '<label for="requirement">Yêu Cầu ' + requirementCount.toString() + '</label><input type="text" id="requirement" name="requirement" value="" placeholder="Nhập yêu cầu công việc...">';
    root = document.getElementById("requirementList");
    root.appendChild(div);
}


function removeRequirement() {
    if (requirementCount > 0) {
        var element = document.getElementById("requirementContainer" + requirementCount);
        element.parentNode.removeChild(element);
        requirementCount--;
    }
}

var benefitCount = 0;
function addBenefit() {
    benefitCount++;
    const div = document.createElement("div");
    div.id = 'benefitContainer' + benefitCount;
    div.innerHTML = '<label for="benefit">Quyền Lợi ' + benefitCount.toString() + '</label><input type="text" id="benefit" name="benefit" value="" placeholder="Nhập quyền lợi...">';
    root = document.getElementById("benefitList");
    root.appendChild(div);
}


function removeBenefit() {
    if (benefitCount > 0) {
        var element = document.getElementById("benefitContainer" + benefitCount);
        element.parentNode.removeChild(element);
        benefitCount--;
    }
}

var skillCount = 0;
function addSkill() {
    skillCount++;
    const div = document.createElement("div");
    div.id = 'skillContainer' + skillCount;
    div.innerHTML = '<div><label for="skillName">Kỹ Năng ' + skillCount.toString() + '</label><input type="text" id="skillName" name="skillName" value="" placeholder="Nhập tên kỹ năng..."></div><div><label for="skillDescription">Mô Tả ' + skillCount.toString() + '</label><input type="text" id="skillDescription" name="skillDescription" value="" placeholder="Nhập mô tả kỹ năng..."></div>'
    root = document.getElementById("skillList");
    root.appendChild(div);
}


function removeSkill() {
    if (skillCount > 0) {
        var element = document.getElementById("skillContainer" + skillCount);
        element.parentNode.removeChild(element);
        skillCount--;
    }
}

var stageCount = 0;
function addStage() {
    stageCount++;
    const div = document.createElement("div");
    div.id = 'stageContainer' + stageCount;
    div.innerHTML = '<div><label for="stageID">Vòng Ứng Tuyển ' + stageCount.toString() + '</label><select id="stageID" name="stageID"><option value="1" selected>CV Applying</option><option value="2">Interview</option><option value="3">Finish</option><option value="4">Final Evaluation</option></select></div><div><label for="description">Mô Tả ' + stageCount.toString() + '</label><input type="text" id="description" name="description" value="" placeholder="Nhập mô tả vòng ứng tuyển..."></div>';
    root = document.getElementById("stageList");
    root.appendChild(div);
}


function removeStage() {
    if (stageCount > 0) {
        var element = document.getElementById("stageContainer" + stageCount);
        element.parentNode.removeChild(element);
        stageCount--;
    }
}

//===============================================================
var postReq = 0;
function addRequirementFromEditPost(postID, positionID) {
    if (postReq == 0) {
        postReq++;
        const div = document.createElement("div");
        div.id = 'addRequirementFromEditPostContainer';

        const inputDiv = document.createElement("div");
        inputDiv.id = 'inputRequirementContainer';

        const submitDiv = document.createElement("div");
        submitDiv.id = 'submitRequirementContainer';

        const form = document.createElement("form");
        form.action = './job';
        form.method = 'post';
        form.id = 'addRequirementForm';

        const input1 = document.createElement("input");
        input1.type = 'hidden';
        input1.name = 'postID';
        input1.value = postID;

        const input2 = document.createElement("input");
        input2.type = 'hidden';
        input2.name = 'positionID';
        input2.value = positionID;

        const input3 = document.createElement("input");
        input3.type = 'hidden';
        input3.name = 'action';
        input3.value = 'add-requirements';

        const reqDiv = document.createElement("div");
        reqDiv.id = 'requirementContainer' + postReq;
        reqDiv.innerHTML = '<label for="requirement">Yêu Cầu</label><input type="text" id="requirement" name="requirement" value="" placeholder="Nhập yêu cầu công việc...">';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(reqDiv);

        root = document.getElementById("addRequirementButton");
        root.innerHTML = '<div><span class="fa fa-minus-circle fa-2x" onclick="removeRequirementFromEditPost()"></span></div>';
        
        submitDiv.appendChild(submit);
        form.appendChild(inputDiv);
        form.appendChild(submitDiv);
        div.appendChild(form);
        root = document.getElementById("addRequirementList");
        root.appendChild(div);
    } else {
        postReq++;
        addMoreRequirement(postReq);
    }
}

function addMoreRequirement(postReq) {
    const reqDiv = document.createElement("div");
    reqDiv.id = 'requirementContainer' + postReq;
    reqDiv.innerHTML = '<label for="requirement">Yêu Cầu</label><input type="text" id="requirement" name="requirement" value="" placeholder="Nhập yêu cầu công việc...">';
    root = document.getElementById("inputRequirementContainer");
    root.appendChild(reqDiv);
}

function removeRequirementFromEditPost() {
    if (postReq > 1) {
        var element = document.getElementById("requirementContainer" + postReq);
        element.parentNode.removeChild(element);
        postReq--;
    } else if (postReq == 1) {
        var element = document.getElementById("addRequirementFromEditPostContainer");
        element.parentNode.removeChild(element);
        var elementBtn = document.getElementById("addRequirementButton");
        elementBtn.innerHTML = '';
        postReq--;
    }
}

//==================================================
var postBene = 0;
function addBenefitFromEditPost(postID, positionID) {
    if (postBene == 0) {
        postBene++;
        const div = document.createElement("div");
        div.id = 'addBenefitFromEditPostContainer';

        const inputDiv = document.createElement("div");
        inputDiv.id = 'inputBenefitContainer';

        const submitDiv = document.createElement("div");
        submitDiv.id = 'submitBenefitContainer';

        const form = document.createElement("form");
        form.action = './job';
        form.method = 'post';
        form.id = 'addBenefitForm';

        const input1 = document.createElement("input");
        input1.type = 'hidden';
        input1.name = 'postID';
        input1.value = postID;

        const input2 = document.createElement("input");
        input2.type = 'hidden';
        input2.name = 'positionID';
        input2.value = positionID;

        const input3 = document.createElement("input");
        input3.type = 'hidden';
        input3.name = 'action';
        input3.value = 'add-benefits';

        const beneDiv = document.createElement("div");
        beneDiv.id = 'benefitContainer' + postBene;
        beneDiv.innerHTML = '<label for="benefit">Quyền Lợi</label><input type="text" id="benefit" name="benefit" value="" placeholder="Nhập quyền lợi...">';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(beneDiv);
        
        root = document.getElementById("addBenefitButton");
        root.innerHTML = '<div><span class="fa fa-minus-circle fa-2x" onclick="removeBenefitFromEditPost()"></span></div>';
        
        submitDiv.appendChild(submit);
        form.appendChild(inputDiv);
        form.appendChild(submitDiv);
        div.appendChild(form);
        root = document.getElementById("addBenefitList");
        root.appendChild(div);
    } else {
        postBene++;
        addMoreBenefit(postBene);
    }
}

function addMoreBenefit(postBene) {
    const beneDiv = document.createElement("div");
    beneDiv.id = 'benefitContainer' + postBene;
    beneDiv.innerHTML = '<label for="benefit">Quyền Lợi</label><input type="text" id="benefit" name="benefit" value="" placeholder="Nhập quyền lợi...">';
    root = document.getElementById("inputBenefitContainer");
    root.appendChild(beneDiv);
}

function removeBenefitFromEditPost() {
    if (postBene > 1) {
        var element = document.getElementById("benefitContainer" + postBene);
        element.parentNode.removeChild(element);
        postBene--;
    } else if (postBene == 1) {
        var element = document.getElementById("addBenefitFromEditPostContainer");
        element.parentNode.removeChild(element);
        var elementBtn = document.getElementById("addBenefitButton");
        elementBtn.innerHTML = '';
        postBene--;
    }
}


//==================================================
var postSkill = 0;
function addSkillFromEditPost(postID, positionID) {
    if (postSkill == 0) {
        postSkill++;
        const div = document.createElement("div");
        div.id = 'addSkillFromEditPostContainer';

        const inputDiv = document.createElement("div");
        inputDiv.id = 'inputSkillContainer';

        const submitDiv = document.createElement("div");
        submitDiv.id = 'submitSkillContainer';

        const form = document.createElement("form");
        form.action = './job';
        form.method = 'post';
        form.id = 'addSkillForm';

        const input1 = document.createElement("input");
        input1.type = 'hidden';
        input1.name = 'postID';
        input1.value = postID;

        const input2 = document.createElement("input");
        input2.type = 'hidden';
        input2.name = 'positionID';
        input2.value = positionID;

        const input3 = document.createElement("input");
        input3.type = 'hidden';
        input3.name = 'action';
        input3.value = 'add-skills';

        const skillDiv = document.createElement("div");
        skillDiv.id = 'skillContainer' + postSkill;
        skillDiv.innerHTML = '<div><label for="skillName">Kỹ Năng</label><input type="text" id="skillName" name="skillName" value="" placeholder="Nhập tên kỹ năng..."></div><div><label for="skillDescription">Mô Tả</label><input type="text" id="skillDescription" name="skillDescription" value="" placeholder="Nhập mô tả kỹ năng..."></div>';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(skillDiv);

        root = document.getElementById("addSkillButton");
        root.innerHTML = '<div><span class="fa fa-minus-circle fa-2x" onclick="removeSkillFromEditPost()"></span></div>';

        submitDiv.appendChild(submit);
        form.appendChild(inputDiv);
        form.appendChild(submitDiv);
        div.appendChild(form);
        root = document.getElementById("addSkillList");
        root.appendChild(div);
    } else {
        postSkill++;
        addMoreSkill(postSkill);
    }
}

function addMoreSkill(postSkill) {
    const skillDiv = document.createElement("div");
    skillDiv.id = 'skillContainer' + postSkill;
    skillDiv.innerHTML = '<div><label for="skillName">Kỹ Năng</label><input type="text" id="skillName" name="skillName" value="" placeholder="Nhập tên kỹ năng..."></div><div><label for="skillDescription">Mô Tả</label><input type="text" id="skillDescription" name="skillDescription" value="Nhập mô tả kỹ năng..." placeholder=""></div>';
    root = document.getElementById("inputSkillContainer");
    root.appendChild(skillDiv);
}

function removeSkillFromEditPost() {
    if (postSkill > 1) {
        var element = document.getElementById("skillContainer" + postSkill);
        element.parentNode.removeChild(element);
        postSkill--;
    } else if (postSkill == 1) {
        var element = document.getElementById("addSkillFromEditPostContainer");
        element.parentNode.removeChild(element);
        var elementBtn = document.getElementById("addSkillButton");
        elementBtn.innerHTML = '';
        postSkill--;
    }
}


//==================================================
var postStage = 0;
function addStageFromEditPost(postID, positionID) {
    if (postStage == 0) {
        postStage++;
        const div = document.createElement("div");
        div.id = 'addStageFromEditPostContainer';

        const inputDiv = document.createElement("div");
        inputDiv.id = 'inputStageContainer';

        const submitDiv = document.createElement("div");
        submitDiv.id = 'submitStageContainer';

        const form = document.createElement("form");
        form.action = './job';
        form.method = 'post';
        form.id = 'addStageForm';

        const input1 = document.createElement("input");
        input1.type = 'hidden';
        input1.name = 'postID';
        input1.value = postID;

        const input2 = document.createElement("input");
        input2.type = 'hidden';
        input2.name = 'positionID';
        input2.value = positionID;

        const input3 = document.createElement("input");
        input3.type = 'hidden';
        input3.name = 'action';
        input3.value = 'add-stages';

        const stageDiv = document.createElement("div");
        stageDiv.id = 'stageContainer' + postStage;
        stageDiv.innerHTML = '<div><label for="stageID">Vòng Ứng Tuyển</label><select id="stageID" name="stageID"><option value="1" selected>CV Applying</option><option value="2">Interview</option><option value="3">Finish</option><option value="4">Final Evaluation</option></select></div><div><label for="description">Mô Tả</label><input type="text" id="description" name="description" value="" placeholder="Nhập mô tả vòng ứng tuyển..."></div>';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(stageDiv);

        root = document.getElementById("addStageButton");
        root.innerHTML = '<div><span class="fa fa-minus-circle fa-2x" onclick="removeStageFromEditPost()"></span></div>';

        submitDiv.appendChild(submit);
        form.appendChild(inputDiv);
        form.appendChild(submitDiv);
        div.appendChild(form);
        root = document.getElementById("addStageList");
        root.appendChild(div);
    } else {
        postStage++;
        addMoreStage(postStage);
    }
}

function addMoreStage(postStage) {
    const stageDiv = document.createElement("div");
    stageDiv.id = 'stageContainer' + postStage;
    stageDiv.innerHTML = '<div><label for="stageID">Vòng Ứng Tuyển</label><select id="stageID" name="stageID"><option value="1" selected>CV Applying</option><option value="2">Interview</option><option value="3">Finish</option><option value="4">Final Evaluation</option></select></div><div><label for="description">Mô Tả</label><input type="text" id="description" name="description" value="" placeholder="Nhập mô tả vòng ứng tuyển..."></div>';
    root = document.getElementById("inputStageContainer");
    root.appendChild(stageDiv);
}

function removeStageFromEditPost() {
    if (postStage > 1) {
        var element = document.getElementById("stageContainer" + postStage);
        element.parentNode.removeChild(element);
        postStage--;
    } else if (postStage == 1) {
        var element = document.getElementById("addStageFromEditPostContainer");
        element.parentNode.removeChild(element);
        var elementBtn = document.getElementById("addStageButton");
        elementBtn.innerHTML = '';
        postStage--;
    }
}
