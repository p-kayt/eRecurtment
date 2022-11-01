/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

var requirementCount = 0;
function addRequirement() {
    requirementCount++;
    const div = document.createElement("div");
    div.id = 'requirementContainer' + requirementCount;
    div.innerHTML = '<label for="requirement">Yêu Cầu ' + requirementCount.toString() + '</label><input type="text" id="requirement" name="requirement" value="" placeholder="">';
    root = document.getElementById("requirementList");
    root.appendChild(div);
}
;

function removeRequirement() {
    if (requirementCount > 0) {
        var element = document.getElementById("requirementContainer" + requirementCount);
        element.parentNode.removeChild(element);
        requirementCount--;
    }
}
;

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
        reqDiv.innerHTML = '<label for="requirement">Yêu Cầu</label><input type="text" id="requirement" name="requirement" value="" placeholder="">';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(reqDiv);


        submitDiv.innerHTML = '<div><span class="fa fa-minus-circle fa-2x" onclick="removeRequirementFromEditPost()"></span></div>';
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
    reqDiv.innerHTML = '<label for="requirement">Yêu Cầu</label><input type="text" id="requirement" name="requirement" value="" placeholder="">';
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
        beneDiv.innerHTML = '<label for="benefit">Quyền Lợi</label><input type="text" id="benefit" name="benefit" value="" placeholder="">';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(beneDiv);


        submitDiv.innerHTML = '<div><span class="fa fa-minus-circle fa-2x" onclick="removeBenefitFromEditPost()"></span></div>';
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
    beneDiv.innerHTML = '<label for="benefit">Quyền Lợi</label><input type="text" id="benefit" name="benefit" value="" placeholder="">';
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
        beneDiv.innerHTML = '<label for="benefit">Quyền Lợi</label><input type="text" id="benefit" name="benefit" value="" placeholder="">';

        const submit = document.createElement('input');
        submit.type = 'submit';
        submit.value = 'Thêm';

        inputDiv.appendChild(input1);
        inputDiv.appendChild(input2);
        inputDiv.appendChild(input3);
        inputDiv.appendChild(beneDiv);


        submitDiv.innerHTML = '<div><span class="fa fa-minus-circle fa-2x" onclick="removeBenefitFromEditPost()"></span></div>';
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
    beneDiv.innerHTML = '<label for="benefit">Quyền Lợi</label><input type="text" id="benefit" name="benefit" value="" placeholder="">';
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
        postBene--;
    }
}

