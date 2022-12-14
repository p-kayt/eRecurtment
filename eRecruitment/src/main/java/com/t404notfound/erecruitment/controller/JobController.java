/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.application.ApplicationDAO;
import com.t404notfound.erecruitment.bean.application.ApplicationDTO;
import com.t404notfound.erecruitment.bean.applicationposition.ApplicationPositionDAO;
import com.t404notfound.erecruitment.bean.applicationposition.ApplicationPositionDTO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDTO;
import com.t404notfound.erecruitment.bean.applicationpost.PostBenefitDTO;
import com.t404notfound.erecruitment.bean.applicationpost.PostRequirementDTO;
import com.t404notfound.erecruitment.bean.applicationpost.PostSkillDTO;
import com.t404notfound.erecruitment.bean.applicationpost.PostStageDTO;
import com.t404notfound.erecruitment.bean.cv.CVDAO;
import com.t404notfound.erecruitment.bean.cv.CVDTO;
import com.t404notfound.erecruitment.bean.interview.EvaluateDAO;
import com.t404notfound.erecruitment.bean.interview.EvaluateDTO;
import com.t404notfound.erecruitment.bean.interview.InterviewDTO;
import com.t404notfound.erecruitment.bean.interview.InterviewerDAO;
import com.t404notfound.erecruitment.bean.interview.InterviewerDTO;
import com.t404notfound.erecruitment.bean.interview.ParticipantDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MSI GF63
 */
@WebServlet(name = "JobController", urlPatterns = {"/job"})
public class JobController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ApplicationPositionDAO positionDAO = new ApplicationPositionDAO();
            ApplicationPostDAO postDAO = new ApplicationPostDAO();
            ApplicationDAO appDAO = new ApplicationDAO();
            ParticipantDAO parDAO = new ParticipantDAO();
            InterviewerDAO itvrDAO = new InterviewerDAO();
            EvaluateDAO evaDAO = new EvaluateDAO();
            String msg = "";
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");
            // User is NOT LOGGED-IN
            if (user == null) {
                msg = "B???n C???n Ph???i ????ng Nh???p ????? S??? D???ng T??nh N??ng N??y";
                request.setAttribute("msg", msg);
                request.getRequestDispatcher("./login").forward(request, response);
            } // User's role is NOT HR STAFF or HR MANAGER
            else if (user.getUserRole() != 2 && user.getUserRole() != 3) {
                msg = "B???n Kh??ng C?? Quy???n S??? D???ng T??nh N??ng N??y";
                request.setAttribute("msg", msg);
                request.getRequestDispatcher("./home").forward(request, response);
            }
            switch (action) {
                case "load-add-position":
                    request.getRequestDispatcher("views/job/position/add-position.jsp").forward(request, response);
                    break;
                case "load-add-post":
                    int positionID = Integer.parseInt(request.getParameter("positionID"));
                    ApplicationPositionDTO position = positionDAO.loadApplicationPositions(positionID);
                    request.setAttribute("position", position);
                    request.getRequestDispatcher("views/job/post/add-post.jsp").forward(request, response);
                    break;
                case "position-list":
                    ArrayList<ApplicationPositionDTO> list = positionDAO.listApplicationPositions();
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("views/job/position/positionlist.jsp").forward(request, response);
                    break;
                case "search-position":
                    String keyword = request.getParameter("keyword");
                    request.setAttribute("keyword", keyword);
                    list = positionDAO.searchApplicationPositions(keyword);
                    if (list != null) {
                        request.setAttribute("list", list);
                        request.getRequestDispatcher("views/job/position/positionlist.jsp").forward(request, response);
                    } else {
                        log("SEARCH POSITION FAILED!");
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }
                    break;
                case "add-position":
                    String name = request.getParameter("name");
                    String description = request.getParameter("description");
                    int quantity = Integer.parseInt(request.getParameter("quantity"));
                    Date date = Date.valueOf(request.getParameter("date"));
                    int status = Integer.parseInt(request.getParameter("status"));

                    ApplicationPositionDTO dto = new ApplicationPositionDTO();
                    dto.setPositionName(name);
                    dto.setPositionDescription(description);
                    dto.setHiringQuantity(quantity);
                    dto.setCreatedDate(date);
                    dto.setStatusID(status);

                    int result = positionDAO.addApplicationPosition(dto);
                    if (result == 1) {
                        msg = "Th??m V??? Tr?? Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    } else {
                        // ko add duoc se gui error mesage
                        msg = "Th??m V??? Tr?? Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }

                    break;
                case "position-detail":
                    int id = Integer.parseInt(request.getParameter("id"));
                    position = positionDAO.loadApplicationPositions(id);
                    ArrayList<ApplicationPostDTO> postList = postDAO.listByPosition(id);

                    if (position != null && postList != null) {
                        request.setAttribute("position", position);
                        request.setAttribute("postList", postList);
                        request.getRequestDispatcher("views/job/position/position-detail.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }

                    break;
                case "edit-position":
                    id = Integer.parseInt(request.getParameter("id"));
                    name = request.getParameter("name");
                    description = request.getParameter("description");
                    quantity = Integer.parseInt(request.getParameter("quantity"));
                    date = Date.valueOf(request.getParameter("date"));
                    status = Integer.parseInt(request.getParameter("status"));

                    dto = new ApplicationPositionDTO();
                    dto.setPositionID(id);
                    dto.setPositionName(name);
                    dto.setPositionDescription(description);
                    dto.setHiringQuantity(quantity);
                    dto.setCreatedDate(date);
                    dto.setStatusID(status);

                    result = positionDAO.updateApplicationPosition(dto);
                    if (result == 1) {
                        msg = "C???p Nh???t V??? Tr?? Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-detail&id=" + id + "").forward(request, response);
                    } else {
                        msg = "C???p Nh???t V??? Tr?? Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }
                    break;
                case "staff-post-detail":
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    position = positionDAO.loadApplicationPositions(positionID);
                    int postID = Integer.parseInt(request.getParameter("postID"));
                    ApplicationPostDTO post = postDAO.loadApplicationPost(postID);

                    if (position != null && post != null) {
                        request.setAttribute("position", position);
                        request.setAttribute("post", post);
                        request.getRequestDispatcher("views/job/post/staff-post-detail.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }
                    break;
                case "edit-post":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    String postDescription = request.getParameter("postDescription");
                    String salary = request.getParameter("salary");
                    int hiringQuantity = Integer.parseInt(request.getParameter("hiringQuantity"));
                    Date createdDate = Date.valueOf(request.getParameter("createdDate"));
                    Date startDate = Date.valueOf(request.getParameter("startDate"));
                    Date expiredDate = Date.valueOf(request.getParameter("expiredDate"));
                    int formID = Integer.parseInt(request.getParameter("formID"));
                    int statusID = Integer.parseInt(request.getParameter("statusID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));

                    log(postDescription.toUpperCase());

                    ApplicationPostDTO editingPost = new ApplicationPostDTO();
                    editingPost.setPostID(postID);
                    editingPost.setPostDescription(postDescription);
                    editingPost.setSalary(salary);
                    editingPost.setHiringQuantity(hiringQuantity);
                    editingPost.setCreatedDate(createdDate);
                    editingPost.setStartDate(startDate);
                    editingPost.setExpiredDate(expiredDate);
                    editingPost.setFormID(formID);
                    editingPost.setStatusID(statusID);
                    editingPost.setPositionID(positionID);

                    result = postDAO.updatePost(editingPost);
                    log("RESULT AFTER DO UPDATE REQUIREMENTS: " + result);
                    if (result == 1) {
                        msg = "C???p Nh???t B??i ????ng Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);

                    } else {
                        msg = "C???p Nh???t B??i ????ng Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }

                    break;
                case "edit-post-requirements":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    String[] requirements = request.getParameterValues("requirement");
                    String[] requirementIDs = request.getParameterValues("requirementID");

                    ArrayList<Integer> reqIDs = new ArrayList<>();
                    for (int i = 0; i < requirementIDs.length; i++) {
                        reqIDs.add(Integer.parseInt(requirementIDs[i]));
                    }

                    ArrayList<PostRequirementDTO> reqList = new ArrayList<>();
                    for (int i = 0; i < requirements.length; i++) {
                        reqList.add(new PostRequirementDTO(reqIDs.get(i), requirements[i], postID));
                    }

                    result = postDAO.updatePostRequirements(reqList);
                    if (result != 0) {
                        msg = "C???p Nh???t Y??u C???u C??ng Vi???c Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "C???p Nh???t Y??u C???u C??ng Vi???c Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "edit-post-skills":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));

                    String[] skillName = request.getParameterValues("skillName");
                    String[] skillDescription = request.getParameterValues("skillDescription");
                    String[] skillIDs = request.getParameterValues("skillID");

                    ArrayList<Integer> skillIDsList = new ArrayList<>();
                    for (int i = 0; i < skillIDs.length; i++) {
                        skillIDsList.add(Integer.parseInt(skillIDs[i]));
                    }

                    ArrayList<PostSkillDTO> skillList = new ArrayList<>();
                    for (int i = 0; i < skillName.length; i++) {
                        skillList.add(new PostSkillDTO(skillIDsList.get(i), skillName[i], skillDescription[i], postID));
                    }
                    result = postDAO.updatePostSkills(skillList);
                    if (result != 0) {
                        msg = "C???p Nh???t K??? N??ng C???n Thi???t Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "C???p Nh???t K??? N??ng C???n Thi???t Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "edit-post-benefits":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    String[] benefits = request.getParameterValues("benefit");
                    String[] benefitIDs = request.getParameterValues("benefitID");

                    ArrayList<Integer> beneIDs = new ArrayList<>();
                    for (int i = 0; i < benefitIDs.length; i++) {
                        beneIDs.add(Integer.parseInt(benefitIDs[i]));
                    }

                    ArrayList<PostBenefitDTO> benefitList = new ArrayList<>();
                    for (int i = 0; i < benefits.length; i++) {
                        benefitList.add(new PostBenefitDTO(beneIDs.get(i), benefits[i], postID));
                    }

                    result = postDAO.updatePostBenefits(benefitList);
                    if (result != 0) {
                        msg = "C???p Nh???t Quy???n L???i C??ng Vi???c Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "C???p Nh???t Quy???n L???i C??ng Vi???c Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "edit-post-stages":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    String[] ids = request.getParameterValues("id");
                    String[] stageIDs = request.getParameterValues("stageID");
                    String[] descriptions = request.getParameterValues("description");

                    ArrayList<Integer> idList = new ArrayList<>();
                    ArrayList<Integer> stageIDList = new ArrayList<>();
                    for (int i = 0; i < ids.length; i++) {
                        idList.add(Integer.parseInt(ids[i]));
                        stageIDList.add(Integer.parseInt(stageIDs[i]));
                    }

                    ArrayList<PostStageDTO> stageList = new ArrayList<>();
                    for (int i = 0; i < descriptions.length; i++) {
                        stageList.add(new PostStageDTO(idList.get(i), descriptions[i], postID, stageIDList.get(i)));
                    }

                    result = postDAO.updatePostStages(stageList);
                    if (result != 0) {
                        msg = "C???p Nh???t Quy Tr??nh ???ng Tuy???n Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "C???p Nh???t Quy Tr??nh ???ng Tuy???n Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "delete-a-requirement":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    int requirementID = Integer.parseInt(request.getParameter("requirementID"));

                    result = postDAO.deleteARequirement(requirementID);
                    if (result != 0) {
                        msg = "X??a Y??u C???u C??ng Vi???c Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "X??a Y??u C???u C??ng Vi???c Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "delete-a-skill":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    int skillID = Integer.parseInt(request.getParameter("skillID"));

                    result = postDAO.deleteASkill(skillID);
                    if (result != 0) {
                        msg = "X??a K??? N??ng C???n Thi???t Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "X??a K??? N??ng C???n Thi???t Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "delete-a-benefit":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    int benefitID = Integer.parseInt(request.getParameter("benefitID"));

                    result = postDAO.deleteABenefit(benefitID);
                    if (result != 0) {
                        msg = "X??a Quy???n L???i C??ng Vi???c Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "X??a Quy???n L???i C??ng Vi???c Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "delete-a-stage":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    id = Integer.parseInt(request.getParameter("id"));

                    result = postDAO.deleteAStage(id);
                    if (result != 0) {
                        msg = "X??a Quy Tr??nh ???ng Tuy???n Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "X??a Quy Tr??nh ???ng Tuy???n Th???t B???i - Th??ng Tin N??y ??ang ???????c S??? D???ng Cho Qu?? Tr??nh Tuy???n D???ng C???a ???ng Vi??n";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "add-requirements":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));

                    requirements = request.getParameterValues("requirement");

                    reqList = new ArrayList<>();
                    for (int i = 0; i < requirements.length; i++) {
                        reqList.add(new PostRequirementDTO(0, requirements[i], postID));
                    }
                    result = postDAO.addPostRequirements(reqList, postID);
                    if (result == 1) {
                        msg = "Th??m Y??u C???u C??ng Vi???c Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "Th??m Y??u C???u C??ng Vi???c Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "add-skills":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    skillName = request.getParameterValues("skillName");
                    skillDescription = request.getParameterValues("skillDescription");

                    skillList = new ArrayList<>();
                    for (int i = 0; i < skillName.length; i++) {
                        skillList.add(new PostSkillDTO(0, skillName[i], skillDescription[i], postID));
                    }
                    result = postDAO.addPostSkills(skillList, postID);
                    if (result == 1) {
                        msg = "Th??m K??? N??ng C???n Thi???t Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "Th??m K??? N??ng C???n Thi???t Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "add-benefits":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));

                    benefits = request.getParameterValues("benefit");

                    benefitList = new ArrayList<>();
                    for (int i = 0; i < benefits.length; i++) {
                        benefitList.add(new PostBenefitDTO(0, benefits[i], postID));
                    }
                    result = postDAO.addPostBenefits(benefitList, postID);
                    if (result == 1) {
                        msg = "Th??m Quy???n L???i C??ng Vi???c Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "Th??m Quy???n L???i C??ng Vi???c Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "add-stages":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));

                    String[] stageIDString = request.getParameterValues("stageID");
                    descriptions = request.getParameterValues("description");

                    stageIDList = new ArrayList<>();
                    for (int i = 0; i < stageIDString.length; i++) {
                        stageIDList.add(Integer.parseInt(stageIDString[i]));
                    }
                    stageList = new ArrayList<>();
                    for (int i = 0; i < descriptions.length; i++) {
                        stageList.add(new PostStageDTO(0, descriptions[i], postID, stageIDList.get(i)));
                    }
                    result = postDAO.addPostStages(stageList, postID);
                    if (result == 1) {
                        msg = "Th??m Quy Tr??nh ???ng Tuy???n Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "Th??m Quy Tr??nh ???ng Tuy???n Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "add-post":
                    positionID = Integer.parseInt(request.getParameter("positionID"));

                    postDescription = request.getParameter("postDescription");
                    request.setAttribute("postDescription", postDescription);
                    
                    salary = request.getParameter("salary");
                    request.setAttribute("salary", salary);
                    
                    hiringQuantity = Integer.parseInt(request.getParameter("hiringQuantity"));
                    request.setAttribute("hiringQuantity", hiringQuantity);
                    
                    createdDate = Date.valueOf(request.getParameter("createdDate"));
                    
                    startDate = Date.valueOf(request.getParameter("startDate"));
                    request.setAttribute("startDate", startDate);
                    
                    expiredDate = Date.valueOf(request.getParameter("expiredDate"));
                    request.setAttribute("expiredDate", expiredDate);
                    
                    formID = Integer.parseInt(request.getParameter("formID"));
                    
                    statusID = Integer.parseInt(request.getParameter("statusID"));

                    requirements = request.getParameterValues("requirement");
                    if(requirements == null){
                        msg = "T???o B??i ????ng Tuy???n D???ng Th???t B???i - B??i ????ng Ch??a C?? Y??u C???u C??ng Vi???c";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=load-add-post&positionID=" + positionID).forward(request, response);
                    }
                    reqList = new ArrayList<>();
                    for (int i = 0; i < requirements.length; i++) {
                        reqList.add(new PostRequirementDTO(0, requirements[i], 0));
                    }

                    String[] skillNames = request.getParameterValues("skillName");
                    String[] skillDescriptions = request.getParameterValues("skillDescription");
                    if(skillNames == null || skillDescriptions == null){
                        msg = "T???o B??i ????ng Tuy???n D???ng Th???t B???i - B??i ????ng Ch??a C?? K??? N??ng C???n Thi???t";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=load-add-post&positionID=" + positionID).forward(request, response);
                    }
                    skillList = new ArrayList<>();
                    for (int i = 0; i < skillNames.length; i++) {
                        skillList.add(new PostSkillDTO(0, skillNames[i], skillDescriptions[i], 0));
                    }

                    benefits = request.getParameterValues("benefit");
                    if(benefits == null){
                        msg = "T???o B??i ????ng Tuy???n D???ng Th???t B???i - B??i ????ng Ch??a C?? Quy???n L???i C??ng Vi???c";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=load-add-post&positionID=" + positionID).forward(request, response);
                    }
                    benefitList = new ArrayList<>();
                    for (int i = 0; i < benefits.length; i++) {
                        benefitList.add(new PostBenefitDTO(0, benefits[i], 0));
                    }

                    stageIDs = request.getParameterValues("stageID");
                    descriptions = request.getParameterValues("description");
                    if(stageIDs == null || descriptions == null){
                        msg = "T???o B??i ????ng Tuy???n D???ng Th???t B???i - B??i ????ng Ch??a C?? Quy Tr??nh ???ng Tuy???n";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=load-add-post&positionID=" + positionID).forward(request, response);
                    }
                    stageIDList = new ArrayList<>();
                    for (int i = 0; i < stageIDs.length; i++) {
                        stageIDList.add(Integer.parseInt(stageIDs[i]));
                    }
                    stageList = new ArrayList<>();
                    for (int i = 0; i < descriptions.length; i++) {
                        stageList.add(new PostStageDTO(0, descriptions[i], 0, stageIDList.get(i)));
                    }

                    post = new ApplicationPostDTO(0, postDescription, salary, hiringQuantity, createdDate, startDate, expiredDate, positionID, formID, statusID, benefitList, skillList, reqList, stageList);

                    result = postDAO.addPost(post);
                    if (result == 1) {
                        postID = postDAO.getLatestPostID();
                        msg = "T???o B??i ????ng Tuy???n D???ng Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    } else {
                        msg = "T???o B??i ????ng Tuy???n D???ng Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=load-add-post&positionID=" + positionID).forward(request, response);
                    }
                    break;
                case "delete-post":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));

                    result = postDAO.deleteApplicationPost(postID);
                    if (result == 1) {
                        msg = "X??a B??i ????ng Tuy???n D???ng Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-detail&id=" + positionID + "").forward(request, response);
                    } else {
                        msg = "X??a B??i ????ng Tuy???n D???ng Th???t B???i - B??i ????ng ??ang ???????c S??? D???ng Cho ???ng Tuy???n V??? Tr??";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    break;
                case "delete-position":
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    result = positionDAO.deleteApplicationPosition(positionID);
                    if (result == 1) {
                        msg = "X??a V??? Tr?? C??ng Vi???c Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    } else {
                        msg = "X??a V??? Tr?? C??ng Vi???c Th???t B???i - V??? Tr?? ??ang ???????c S??? D???ng Cho C??c B??i ????ng Tuy???n D???ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-detail&id=" + positionID + "").forward(request, response);
                    }
                    break;
                case "managing-applications":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));

                    position = positionDAO.loadApplicationPositions(positionID);
                    post = postDAO.loadApplicationPostWithName(postID);
                    for (PostStageDTO stage : post.getStageList()) {
                        stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                        for (InterviewDTO itv : stage.getInterviewList()) {
                            itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                        }
                    }
                    ArrayList<ApplicationDTO> appList = appDAO.listAllApplicationOfAPost(postID);

                    request.setAttribute("appList", appList);
                    request.setAttribute("post", post);
                    request.setAttribute("position", position);

                    request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    break;
                case "view-candidate-cv":
                    int userID = Integer.parseInt(request.getParameter("userID"));
                    CVDAO cvDAO = new CVDAO();
                    CVDTO cv = cvDAO.loadCVByUserID(userID);
                    request.setAttribute("cv", cv);
                    request.getRequestDispatcher("/views/cv/cv-read.jsp").forward(request, response);
                    break;
                case "reject-cv":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    int appID = Integer.parseInt(request.getParameter("appID"));

                    result = appDAO.rejectApplication(appID);

                    position = positionDAO.loadApplicationPositions(positionID);
                    post = postDAO.loadApplicationPostWithName(postID);
                    for (PostStageDTO stage : post.getStageList()) {
                        stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                        for (InterviewDTO itv : stage.getInterviewList()) {
                            itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                        }
                    }
                    appList = appDAO.listAllApplicationOfAPost(postID);

                    request.setAttribute("appList", appList);
                    request.setAttribute("post", post);
                    request.setAttribute("position", position);

                    if (result == 1) {
                        msg = "T??? Ch???i Th??nh C??ng H??? S?? ???ng Tuy???n V???i ID: " + appID;
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    } else {
                        msg = "T??? Ch???i Th???t B???i H??? S?? ???ng Tuy???n V???i ID: " + appID;
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    }
                    break;
                case "approve-cv":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    appID = Integer.parseInt(request.getParameter("appID"));
                    int stageOffset = Integer.parseInt(request.getParameter("stageOffset"));
                    
                    int nextStageID = appDAO.getNextStage(stageOffset, postID);
                    if (nextStageID != 0) {
                        result = appDAO.approveToNextStage(nextStageID, appID);
                    } else {
                        result = 0;
                    }

                    position = positionDAO.loadApplicationPositions(positionID);
                    post = postDAO.loadApplicationPostWithName(postID);
                    for (PostStageDTO stage : post.getStageList()) {
                        stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                        for (InterviewDTO itv : stage.getInterviewList()) {
                            itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                        }
                    }
                    appList = appDAO.listAllApplicationOfAPost(postID);

                    request.setAttribute("appList", appList);
                    request.setAttribute("post", post);
                    request.setAttribute("position", position);

                    if (result == 1) {
                        msg = "Duy???t H??? S?? ???ng Tuy???n V???i ID: " + appID + " ?????n V??ng Ti???p Theo Th??nh C??ng";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    } else {
                        msg = "Duy???t H??? S?? ???ng Tuy???n V???i ID: " + appID + " ?????n V??ng Ti???p Theo Th???t B???i";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    }
                    break;
                case "reject-pass-interview":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    appID = Integer.parseInt(request.getParameter("appID"));
                    userID = Integer.parseInt(request.getParameter("userID"));
                    int itvID = Integer.parseInt(request.getParameter("itvID"));

                    // Check if candidate have enough evaluations
                    ArrayList<UserDTO> interviewerList = itvrDAO.getInterviewer(itvID);
                    ArrayList<EvaluateDTO> evaluateList = evaDAO.getEvaluationOfCandidate(itvID, userID);
                    if (interviewerList.size() != evaluateList.size()) {
                        msg = "T??? Ch???i Th???t B???i H??? S?? ???ng Tuy???n V???i ID: " + appID + " - ???ng Vi??n Ch??a C?? ????? ????nh Gi?? Cho V??ng Ph???ng V???n ????? X??t Duy???t";
                        request.setAttribute("msg", msg);

                        position = positionDAO.loadApplicationPositions(positionID);
                        post = postDAO.loadApplicationPostWithName(postID);
                        for (PostStageDTO stage : post.getStageList()) {
                            stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                            for (InterviewDTO itv : stage.getInterviewList()) {
                                itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                            }
                        }
                        appList = appDAO.listAllApplicationOfAPost(postID);

                        request.setAttribute("appList", appList);
                        request.setAttribute("post", post);
                        request.setAttribute("position", position);

                        request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    } else {
                        result = appDAO.rejectApplication(appID);
                        int itvResult = parDAO.setFailInterview(userID, itvID);
                        if (result == 1 && itvResult == 1) {
                            msg = "T??? Ch???i Th??nh C??ng H??? S?? ???ng Tuy???n V???i ID: " + appID;
                            request.setAttribute("msg", msg);

                            position = positionDAO.loadApplicationPositions(positionID);
                            post = postDAO.loadApplicationPostWithName(postID);
                            for (PostStageDTO stage : post.getStageList()) {
                                stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                                for (InterviewDTO itv : stage.getInterviewList()) {
                                    itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                                }
                            }
                            appList = appDAO.listAllApplicationOfAPost(postID);

                            request.setAttribute("appList", appList);
                            request.setAttribute("post", post);
                            request.setAttribute("position", position);

                            request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                        } else {
                            msg = "T??? Ch???i Th???t B???i H??? S?? ???ng Tuy???n V???i ID: " + appID;
                            request.setAttribute("msg", msg);

                            position = positionDAO.loadApplicationPositions(positionID);
                            post = postDAO.loadApplicationPostWithName(postID);
                            for (PostStageDTO stage : post.getStageList()) {
                                stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                                for (InterviewDTO itv : stage.getInterviewList()) {
                                    itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                                }
                            }
                            appList = appDAO.listAllApplicationOfAPost(postID);

                            request.setAttribute("appList", appList);
                            request.setAttribute("post", post);
                            request.setAttribute("position", position);

                            request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                        }
                    }
                    break;
                case "approve-pass-interview":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    appID = Integer.parseInt(request.getParameter("appID"));
                    stageOffset = Integer.parseInt(request.getParameter("stageOffset"));
                    itvID = Integer.parseInt(request.getParameter("itvID"));
                    userID = Integer.parseInt(request.getParameter("userID"));

                    // Check if candidate have enough evaluations
                    interviewerList = itvrDAO.getInterviewer(itvID);
                    evaluateList = evaDAO.getEvaluationOfCandidate(itvID, userID);
                    if (interviewerList.size() != evaluateList.size()) {
                        msg = "Duy???t Th???t B???i H??? S?? ???ng Tuy???n V???i ID: " + appID + " - ???ng Vi??n Ch??a C?? ????? ????nh Gi?? Cho V??ng Ph???ng V???n ????? X??t Duy???t";
                        request.setAttribute("msg", msg);

                        position = positionDAO.loadApplicationPositions(positionID);
                        post = postDAO.loadApplicationPostWithName(postID);
                        for (PostStageDTO stage : post.getStageList()) {
                            stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                            for (InterviewDTO itv : stage.getInterviewList()) {
                                itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                            }
                        }
                        appList = appDAO.listAllApplicationOfAPost(postID);

                        request.setAttribute("appList", appList);
                        request.setAttribute("post", post);
                        request.setAttribute("position", position);

                        request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    } else {
                        nextStageID = appDAO.getNextStage(stageOffset, postID);
                        if (nextStageID != 0) {
                            result = appDAO.approveToNextStage(nextStageID, appID);
                        } else {
                            result = 0;
                        }

                        int itvResult = parDAO.setPassInterview(userID, itvID);

                        if (result == 1 && itvResult == 1) {
                            msg = "Duy???t Th??nh C??ng H??? S?? ???ng Tuy???n V???i ID: " + appID + " ?????n V??ng Ti???p Theo";
                            request.setAttribute("msg", msg);

                            position = positionDAO.loadApplicationPositions(positionID);
                            post = postDAO.loadApplicationPostWithName(postID);
                            for (PostStageDTO stage : post.getStageList()) {
                                stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                                for (InterviewDTO itv : stage.getInterviewList()) {
                                    itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                                }
                            }
                            appList = appDAO.listAllApplicationOfAPost(postID);

                            request.setAttribute("appList", appList);
                            request.setAttribute("post", post);
                            request.setAttribute("position", position);

                            request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                        } else {
                            msg = "Duy???t Th???t B???i H??? S?? ???ng Tuy???n V???i ID: " + appID + " ?????n V??ng Ti???p Theo";
                            request.setAttribute("msg", msg);

                            position = positionDAO.loadApplicationPositions(positionID);
                            post = postDAO.loadApplicationPostWithName(postID);
                            for (PostStageDTO stage : post.getStageList()) {
                                stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                                for (InterviewDTO itv : stage.getInterviewList()) {
                                    itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                                }
                            }
                            appList = appDAO.listAllApplicationOfAPost(postID);

                            request.setAttribute("appList", appList);
                            request.setAttribute("post", post);
                            request.setAttribute("position", position);

                            request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                        }
                    }
                    break;
                case "reject-final-evaluation":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    appID = Integer.parseInt(request.getParameter("appID"));
                    userID = Integer.parseInt(request.getParameter("userID"));

                    // Only HR Manager can reject candidate in final evaluation stage
                    // If user role is not HR Manager (3)
                    if (user.getUserRole() != 3) {
                        msg = "B???n Ph???i L?? Qu???n L?? Nh??n S??? (HR Manager) ????? ????nh Gi?? V??ng FInal Evaluation";
                        request.setAttribute("msg", msg);

                        position = positionDAO.loadApplicationPositions(positionID);
                        post = postDAO.loadApplicationPostWithName(postID);
                        for (PostStageDTO stage : post.getStageList()) {
                            stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                            for (InterviewDTO itv : stage.getInterviewList()) {
                                itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                            }
                        }
                        appList = appDAO.listAllApplicationOfAPost(postID);

                        request.setAttribute("appList", appList);
                        request.setAttribute("post", post);
                        request.setAttribute("position", position);

                        request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    } // If user role is HR Manager (3)
                    else {
                        result = appDAO.rejectApplication(appID);

                        position = positionDAO.loadApplicationPositions(positionID);
                        post = postDAO.loadApplicationPostWithName(postID);
                        for (PostStageDTO stage : post.getStageList()) {
                            stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                            for (InterviewDTO itv : stage.getInterviewList()) {
                                itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                            }
                        }
                        appList = appDAO.listAllApplicationOfAPost(postID);

                        request.setAttribute("appList", appList);
                        request.setAttribute("post", post);
                        request.setAttribute("position", position);

                        if (result == 1) {
                            msg = "T??? Ch???i Th??nh C??ng H??? S?? ???ng Tuy???n V???i ID: " + appID;
                            request.setAttribute("msg", msg);

                            request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                        } else {
                            msg = "T??? Ch???i Th???t B???i H??? S?? ???ng Tuy???n V???i ID: " + appID;
                            request.setAttribute("msg", msg);

                            request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                        }
                    }

                    break;
                case "approve-final-evaluation":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    appID = Integer.parseInt(request.getParameter("appID"));
                    stageOffset = Integer.parseInt(request.getParameter("stageOffset"));
                    userID = Integer.parseInt(request.getParameter("userID"));

                    // Only HR Manager can approve candidate in final evaluation stage
                    // If user role is not HR Manager (3)
                    if (user.getUserRole() != 3) {
                        msg = "B???n Ph???i L?? Qu???n L?? Nh??n S??? (HR Manager) ????? ????nh Gi?? V??ng FInal Evaluation";
                        request.setAttribute("msg", msg);

                        position = positionDAO.loadApplicationPositions(positionID);
                        post = postDAO.loadApplicationPostWithName(postID);
                        for (PostStageDTO stage : post.getStageList()) {
                            stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                            for (InterviewDTO itv : stage.getInterviewList()) {
                                itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                            }
                        }
                        appList = appDAO.listAllApplicationOfAPost(postID);

                        request.setAttribute("appList", appList);
                        request.setAttribute("post", post);
                        request.setAttribute("position", position);

                        request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                    } // If user role is HR Manager (3)
                    else {
                        nextStageID = appDAO.getNextStage(stageOffset, postID);
                        if (nextStageID != 0) {
                            result = appDAO.approveApplicationSuccess(nextStageID, appID);
                        } else {
                            result = 0;
                        }
                        position = positionDAO.loadApplicationPositions(positionID);
                        post = postDAO.loadApplicationPostWithName(postID);
                        for (PostStageDTO stage : post.getStageList()) {
                            stage.setInterviewList(postDAO.getStageInterviewsList(stage));
                            for (InterviewDTO itv : stage.getInterviewList()) {
                                itv.setParticipantList(parDAO.getParticipant(itv.getInterviewID()));
                            }
                        }
                        appList = appDAO.listAllApplicationOfAPost(postID);

                        request.setAttribute("appList", appList);
                        request.setAttribute("post", post);
                        request.setAttribute("position", position);

                        if (result == 1) {
                            msg = "T???ng ????nh Gi?? Th??nh C??ng H??? S?? ???ng Tuy???n V???i ID: " + appID;
                            request.setAttribute("msg", msg);

                            request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                        } else {
                            msg = "T???ng ????nh Gi?? Th???t B???i H??? S?? ???ng Tuy???n V???i ID: " + appID;
                            request.setAttribute("msg", msg);

                            request.getRequestDispatcher("views/job/post/managing-applications.jsp").forward(request, response);
                        }
                    }

                    break;
                default:
                    break;

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
