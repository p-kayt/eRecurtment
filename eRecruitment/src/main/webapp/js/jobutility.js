/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var requirementCount = 0;
function addRequirement() {
    requirementCount++;
    var div = document.createElement("div");
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
    var div = document.createElement("div");
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
    var div = document.createElement("div");
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
    var div = document.createElement("div");
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
        var div = document.createElement("div");
        div.id = 'addRequirementFromEditPostContainer';
        div.classList.add('m-2');
        div.classList.add('px-3');

        var inputDiv = document.createElement("div");
        inputDiv.id = 'inputRequirementContainer';
        inputDiv.classList.add('d-flex');
        inputDiv.classList.add('flex-column');
        inputDiv.classList.add('m-2');
        inputDiv.classList.add('px-3');
        inputDiv.innerHTML = '<label for="requirement">Yêu Cầu</label>';


        var submitDiv = document.createElement("div");
        submitDiv.id = 'submitRequirementContainer';
        submitDiv.classList.add('col-1');
        submitDiv.classList.add('mx-4');


        var form = document.createElement("form");
        form.action = './job';
        form.method = 'post';
        form.id = 'addRequirementForm';

        var input1 = document.createElement("input");
        input1.type = 'hidden';
        input1.name = 'postID';
        input1.value = postID;

        var input2 = document.createElement("input");
        input2.type = 'hidden';
        input2.name = 'positionID';
        input2.value = positionID;

        var input3 = document.createElement("input");
        input3.type = 'hidden';
        input3.name = 'action';
        input3.value = 'add-requirements';

        var reqDiv = document.createElement("div");
        reqDiv.id = 'requirementContainer' + postReq;
        reqDiv.classList.add('d-flex');
        reqDiv.classList.add('justify-content-center');
        reqDiv.innerHTML = '<input class="col-12 mx-5 p-1" type="text" id="requirement" name="requirement" value="" placeholder="Nhập yêu cầu công việc">';

        var submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';
        submit.className = "btn btn-primary";

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(reqDiv);

        root = document.getElementById("addRequirementButton");
        root.innerHTML = '<lable class="bi bi-dash" onclick="removeRequirementFromEditPost()"><span class="m-2">Xoá yêu cầu</span></lable>';

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
    var reqDiv = document.createElement("div");
    reqDiv.id = 'requirementContainer' + postReq;
    reqDiv.classList.add('d-flex');
    reqDiv.classList.add('my-2');
    reqDiv.classList.add('justify-content-center');
    reqDiv.innerHTML = '<input class="col-12 mx-5 p-1" type="text" id="requirement" name="requirement" value="" placeholder="Nhập yêu cầu công việc">';
//    reqDiv.innerHTML = '<label for="requirement">Yêu Cầu</label><input class="col-12 m-1" type="text" id="requirement" name="requirement" value="" placeholder="Nhập yêu cầu công việc...">';

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
        div.classList.add('m-2');
        div.classList.add('px-3');

        const inputDiv = document.createElement("div");
        inputDiv.id = 'inputBenefitContainer';
        inputDiv.classList.add('d-flex');
        inputDiv.classList.add('flex-column');
        inputDiv.classList.add('m-2');
        inputDiv.classList.add('px-3');
        inputDiv.innerHTML = '<label for="requirement">Quyền lợi</label>';

        const submitDiv = document.createElement("div");
        submitDiv.id = 'submitBenefitContainer';
        submitDiv.classList.add('col-1');
        submitDiv.classList.add('mx-4');

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
        beneDiv.classList.add('d-flex');
        beneDiv.classList.add('justify-content-center');
        beneDiv.innerHTML = '<input class="col-12 mx-5 p-1" type="text" id="benefit" name="benefit" value="" placeholder="Nhập quyền lợi...">';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';
        submit.className = "btn btn-primary";

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(beneDiv);

        root = document.getElementById("addBenefitButton");

        root.innerHTML = '<lable class="bi bi-dash" onclick="removeBenefitFromEditPost()"><span class="m-2">Xoá quyền lợi</span></lable>';

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
    beneDiv.classList.add('d-flex');
    beneDiv.classList.add('my-2');
    beneDiv.classList.add('justify-content-center');
    beneDiv.innerHTML = '<input class="col-12 mx-5 p-1" type="text"id="benefit" name="benefit" value="" placeholder="Nhập quyền lợi...">';

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
        div.classList.add('m-2');
        div.classList.add('px-3');

        const inputDiv = document.createElement("div");
        inputDiv.id = 'inputSkillContainer';
        inputDiv.classList.add('d-flex');
        inputDiv.classList.add('justify-content-center');
        inputDiv.classList.add('m-2');
        inputDiv.classList.add('px-3');
        inputDiv.classList.add('row');
        inputDiv.classList.add('g-1');

        const submitDiv = document.createElement("div");
        submitDiv.id = 'submitSkillContainer';
        submitDiv.classList.add('col-1');
        submitDiv.classList.add('mx-4');


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
        skillDiv.classList.add('d-flex');
        skillDiv.classList.add('flex-row');
        skillDiv.classList.add('row');
        skillDiv.classList.add('g-2');
        skillDiv.innerHTML = '<div class="d-flex flex-column col-6"><label for="skillName">Kỹ Năng</label><input class="p-1" type="text" id="skillName" name="skillName" value="" placeholder="Nhập tên kỹ năng..."></div><div class="d-flex flex-column col-6"><label for="skillDescription">Mô Tả</label><input class="p-1" type="text" id="skillDescription" name="skillDescription" value="" placeholder="Nhập mô tả kỹ năng..."></div>';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';
        submit.className = "btn btn-primary";

        inputDiv.appendChild(skillDiv);
        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);


        root = document.getElementById("addSkillButton");
        root.innerHTML = '<lable class="bi bi-dash" onclick="removeSkillFromEditPost()"><span class="m-2">Xoá kỹ năng</span></lable>';

        submitDiv.appendChild(submit);
        form.appendChild(inputDiv);
//        form.appendChild(skillDiv);
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
    skillDiv.classList.add('d-flex');
    skillDiv.classList.add('flex-row');
    skillDiv.classList.add('row');
    skillDiv.classList.add('g-2');
    skillDiv.innerHTML = '<div class="d-flex flex-column col-6"><input class="p-1" type="text" id="skillName" name="skillName" value="" placeholder="Nhập tên kỹ năng..."></div><div class="d-flex flex-column col-6"><input class="p-1" type="text" id="skillDescription" name="skillDescription" value="" placeholder="Nhập mô tả kỹ năng..."></div>';

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
        div.classList.add('m-2');
        div.classList.add('px-3');

        const inputDiv = document.createElement("div");
        inputDiv.id = 'inputStageContainer';
        inputDiv.classList.add('d-flex');
        inputDiv.classList.add('justify-content-center');
        inputDiv.classList.add('m-2');
        inputDiv.classList.add('px-3');
        inputDiv.classList.add('row');
        inputDiv.classList.add('g-1');

        const submitDiv = document.createElement("div");
        submitDiv.id = 'submitStageContainer';
        submitDiv.classList.add('col-1');
        submitDiv.classList.add('mx-4');

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
        stageDiv.classList.add('d-flex');
        stageDiv.classList.add('flex-row');
        stageDiv.classList.add('row');
        stageDiv.classList.add('g-2');
        stageDiv.innerHTML = '<div class="col-3 m-1 d-flex flex-column"><label for="stageID">Vòng Ứng Tuyển</label><select class="p-1" id="stageID" name="stageID"><option value="1" selected>CV Applying</option><option value="2">Interview</option><option value="3">Finish</option><option value="4">Final Evaluation</option></select></div><div class="col-8 m-1 d-flex flex-column"><label for="description">Mô Tả</label><input class="p-1" type="text" id="description" name="description" value="" placeholder="Nhập mô tả vòng ứng tuyển..."></div>';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';
        submit.className = "btn btn-primary";

        inputDiv.appendChild(stageDiv);
        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);


        root = document.getElementById("addStageButton");
        root.innerHTML = '<lable class="bi bi-dash" onclick="removeStageFromEditPost()"><span class="m-2">Xoá quy trình</span></lable>';

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
    stageDiv.classList.add('d-flex');
    stageDiv.classList.add('flex-row');
    stageDiv.classList.add('row');
    stageDiv.classList.add('g-2');
    stageDiv.innerHTML = '<div class="col-3 m-1 d-flex flex-column"><select class="p-1" id="stageID" name="stageID"><option value="1" selected>CV Applying</option><option value="2">Interview</option><option value="3">Finish</option><option value="4">Final Evaluation</option></select></div><div class="col-8 m-1 d-flex flex-column"><input class="p-1" type="text" id="description" name="description" value="" placeholder="Nhập mô tả vòng ứng tuyển..."></div>';
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

//=====================================================================
function showPositionDeleteForm() {
    document.getElementById("delete-position-form-container").style.display = "block";
}

function hidePositionDeleteForm() {
    document.getElementById("delete-position-form-container").style.display = "none";
}

function showPostDeleteForm() {
    document.getElementById("delete-post-form-container").style.display = "block";
}

function hidePostDeleteForm() {
    document.getElementById("delete-post-form-container").style.display = "none";
}