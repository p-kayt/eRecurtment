/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.application.ApplicationDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDTO;
import com.t404notfound.erecruitment.bean.applicationpost.PostStageDTO;
import com.t404notfound.erecruitment.bean.interview.InterviewDAO;
import com.t404notfound.erecruitment.bean.interview.InterviewDTO;
import com.t404notfound.erecruitment.bean.interview.InterviewerDAO;
import com.t404notfound.erecruitment.bean.interview.InterviewerDTO;
import com.t404notfound.erecruitment.bean.interview.ParticipantDAO;
import com.t404notfound.erecruitment.bean.interview.ParticipantDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MINH TRI
 */
@WebServlet(name = "HRInterviewController", urlPatterns = {"/interview"})
public class HRInterviewController extends HttpServlet {

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
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        String format = request.getParameter("format");
        String link = request.getParameter("link");
        String address = request.getParameter("address");
        String date = request.getParameter("date");
        String hour = request.getParameter("time");
        String maxCandidateString = request.getParameter("maxCandidate");
        String stage = request.getParameter("stage");
        String description = request.getParameter("description");
        String action = request.getParameter("action");
        String status = request.getParameter("statusID");
        int postID = 0;
        if (request.getParameter("postID") != null) {
            postID = Integer.parseInt(request.getParameter("postID"));
        } else {
            postID = 1;
        }

        int stageID;
        try {
            stageID = Integer.parseInt(stage);
        } catch (Exception e) {
            stageID = 0;
        }

        if (action != null && !action.equals("")) {
            if (action.equalsIgnoreCase("bookInteview")) {
                int formatID = Integer.parseInt(format);
                int maxCandidate = Integer.parseInt(maxCandidateString);
                int bookerID = user.getUserID();
                String time = date + " " + hour;
                InterviewDAO iDAO = new InterviewDAO();
                boolean create = false;
                create = iDAO.createAnInterview(description, link, address, time, maxCandidate, stageID, postID, formatID, bookerID);
                if (create) {
                    int interviewID = iDAO.getNewestInterview();
                    InterviewDTO interview = iDAO.getInterview(interviewID);
                    request.setAttribute("interview", interview);
                    request.setAttribute("interviewID", interviewID);
                    request.setAttribute("postID", postID);

                    //set action attribute to load interview detail
//                    request.setAttribute("action", "interviewDetail");
                    //set action attribute to load interview detail
                    InterviewDAO dao = new InterviewDAO();
                    ArrayList<String> interviewStage = dao.getInterviewStage(postID);
                    ArrayList<String> interviewStatus = dao.getInterviewStatus();
                    ArrayList<String> interviewFormat = dao.getInterviewFormat();
                    request.setAttribute("interviewFormat", interviewFormat);
                    request.setAttribute("interviewStatus", interviewStatus);
                    request.setAttribute("interviewStage", interviewStage);

                    request.setAttribute("booker", user);
                    request.getRequestDispatcher("/views/interview/interview-detail.jsp").forward(request, response);
                    return;
                } else {

                    //save input in case of create interview fail
                    request.setAttribute("format", format);
                    request.setAttribute("link", link);
                    request.setAttribute("address", address);
                    request.setAttribute("stage", stageID);
                    request.setAttribute("date", date);
                    request.setAttribute("time", hour);
                    request.setAttribute("maxCandidate", maxCandidate);
                    request.setAttribute("description", description);
                    request.setAttribute("postID", postID);

                    InterviewDAO dao = new InterviewDAO();
                    String interviewStage = dao.getInterviewStageNameByID(stageID);
                    ArrayList<String> interviewStatus = dao.getInterviewStatus();
                    ArrayList<String> interviewFormat = dao.getInterviewFormat();
                    request.setAttribute("interviewFormat", interviewFormat);
                    request.setAttribute("interviewStatus", interviewStatus);
                    request.setAttribute("interviewStage", interviewStage);

                    request.getRequestDispatcher("/views/interview/interview-create.jsp").forward(request, response);
                }
            } else if (action.equalsIgnoreCase("interviewDetail")) {

                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ParticipantDAO participantDAO = new ParticipantDAO();
                //get interview ID
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));

                InterviewDAO iDAO = new InterviewDAO();
                InterviewDTO interview = iDAO.getInterview(interviewID);
                request.setAttribute("interview", interview);

                //get booker
                UserDAO uDAO = new UserDAO();
                UserDTO booker = uDAO.getUserByID(interview.getBookerID());
                request.setAttribute("booker", booker);
                //get booker

                //get Interviewer of this interview
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);
                //get list interviewer
                request.setAttribute("listMainInterviewer", listInterviewer);

                ArrayList<ParticipantDTO> listParticipant = participantDAO.getParticipant(interviewID);
                request.setAttribute("listParticipant", listParticipant);

                //get list candidate
                ArrayList<UserDTO> listCandidate = participantDAO.getListInterviewCandidate(interviewID, 2);
                request.setAttribute("listMainCandidate", listCandidate);
                //get list candidate

                //get list candidate that have not to interview
                ArrayList<UserDTO> listNoInterviewCandidate = participantDAO.getListCandidateByResult(interviewID, 2);
                request.setAttribute("listNoInterviewCandidate", listNoInterviewCandidate);
                //get list candidate that have not to interview

                InterviewDAO dao = new InterviewDAO();
                ArrayList<String> interviewStage = dao.getInterviewStage(postID);
                ArrayList<String> interviewStatus = dao.getInterviewStatus();
                ArrayList<String> interviewFormat = dao.getInterviewFormat();
                request.setAttribute("interviewFormat", interviewFormat);
                request.setAttribute("interviewStatus", interviewStatus);
                request.setAttribute("interviewStage", interviewStage);

                request.setAttribute("postID", postID);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/interview-detail.jsp").forward(request, response);
                return;
            } else if (action.equalsIgnoreCase("showListInterviewer")) {

                InterviewerDAO iDAO = new InterviewerDAO();
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                ArrayList<UserDTO> listInterviewer = iDAO.getAvailableInterviewer(interviewID);
                request.setAttribute("postID", postID);
                request.setAttribute("listInterviewer", listInterviewer);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/interviewer-list.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("addInterviewer")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                InterviewerDAO iDAO = new InterviewerDAO();
                iDAO.addInterviewer(userID, interviewID);

                /*reload list interview page*/
                request.getRequestDispatcher("interview?action=showListInterviewer").forward(request, response);
                /*reload list interview page*/

            } else if (action.equalsIgnoreCase("removeInterviewer")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                InterviewerDAO iDAO = new InterviewerDAO();
                boolean check = iDAO.removeInterviewer(userID, interviewID);
                if (!check) {
                    request.setAttribute("deleteMess", "X??a ng?????i ph???ng v???n kh??ng th??nh c??ng v?? ng?????i n??y ???? ????nh gi?? ???ng vi??n");
                }

                /*reload detail page*/
                request.getRequestDispatcher("interview?action=interviewDetail").forward(request, response);
                /*reload detail page*/
            } else if (action.equalsIgnoreCase("updateInterview")) {
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                int formatID = Integer.parseInt(format);
                int maxCandidate = Integer.parseInt(maxCandidateString);
                int statusID = Integer.parseInt(status);
                String time = date + " " + hour;
                InterviewDAO iDAO = new InterviewDAO();
                InterviewDTO update = iDAO.updateInterview(interviewID, description, link, address, time, maxCandidate, stageID, formatID, statusID);

                //Reload interview detail
                request.getRequestDispatcher("interview?action=interviewDetail").forward(request, response);
                //Reload interview detail
            } else if (action.equalsIgnoreCase("showListCandidate")) {
                ParticipantDAO pDAO = new ParticipantDAO();
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                InterviewDAO interviewDAO = new InterviewDAO();
                InterviewDTO interview = interviewDAO.getInterview(interviewID);

                int iPostID = interview.getPostID();
                int iStageID = interview.getStageID();
                ArrayList<UserDTO> listCandidate = pDAO.getAvailablePariticipant(iPostID, iStageID);

                request.setAttribute("postID", postID);
                request.setAttribute("interview", interview);
                request.setAttribute("listCandidate", listCandidate);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/candidate-list.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("addCandidate")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                ParticipantDAO pDAO = new ParticipantDAO();

                String cTime;

                int resultID = Integer.parseInt(request.getParameter("interviewResultID"));

                String cHour = (String) request.getParameter("time");
                String cDay = (String) request.getParameter("day");
                cTime = cDay + " " + cHour;

                pDAO.addCandidate(userID, interviewID, cTime, resultID);

                /*reload list candidate page*/
                request.getRequestDispatcher("interview?action=showListCandidate").forward(request, response);
                /*reload list candidate page*/

            } else if (action.equalsIgnoreCase("addExemptCandidate")) {
                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                InterviewDAO interviewDAO = new InterviewDAO();
                InterviewDTO interview = interviewDAO.getInterview(interviewID);

                // increase stage 
                postID = interview.getPostID();
                stageID = interview.getStageID();
                ApplicationDAO appDAO = new ApplicationDAO();
                ApplicationPostDAO postDAO = new ApplicationPostDAO();

                //get applicationID
                int appID = interviewDAO.getApplicationID(userID, postID);
                //get ApplicationID

                int nextStageID = postDAO.getIDOfNextStage(postID, stageID);
                appDAO.approveToNextStage(nextStageID, appID);
                // increase stage 

                String time = interview.getTime();
                ParticipantDAO pDAO = new ParticipantDAO();

                int resultID = Integer.parseInt(request.getParameter("interviewResultID"));

                pDAO.addCandidate(userID, interviewID, time, 2);
                //need to do more  thing here to update stage of user 

                /*reload list candidate page*/
                request.getRequestDispatcher("interview?action=showListCandidate").forward(request, response);
                /*reload list candidate page*/
            } else if (action.equalsIgnoreCase("removeCandidate")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                ParticipantDAO pDAO = new ParticipantDAO();
                boolean check = pDAO.removeCandidate(userID, interviewID);
                String mess = null;
                if (!check) {
                    mess = "X??a ???ng vi??n kh??ng th??nh c??ng v?? ???ng vi??n ???? c?? k???t qu??? ????nh gi?? t??? ng?????i ph???ng v???n";
                }

                //Reload interview detail
                request.getRequestDispatcher("interview?action=interviewDetail").forward(request, response);
                //Reload interview detail
            } else if (action.equalsIgnoreCase("removeExemptCandidate")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                InterviewDAO interviewDAO = new InterviewDAO();
                InterviewDTO interview = interviewDAO.getInterview(interviewID);

                
                // decrease stage 
                postID = interview.getPostID();
                stageID = interview.getStageID();
                ApplicationDAO appDAO = new ApplicationDAO();
                ApplicationPostDAO postDAO = new ApplicationPostDAO();

                //get applicationID
                int appID = interviewDAO.getApplicationID(userID, postID);
                //get ApplicationID

                int preStage = interview.getStageID();
                appDAO.rollbackToPreviousStage(preStage, appID);
                // decrease stage 

                
                ParticipantDAO pDAO = new ParticipantDAO();
                boolean check = pDAO.removeCandidate(userID, interviewID);
                String mess = null;
                if (!check) {
                    mess = "X??a ???ng vi??n kh??ng th??nh c??ng v?? ???ng vi??n ???? c?? k???t qu??? ????nh gi?? t??? ng?????i ph???ng v???n";
                }

                //Reload interview detail
                request.getRequestDispatcher("interview?action=interviewDetail").forward(request, response);
                //Reload interview detail
            } else if (action.equalsIgnoreCase("showCreatedInterview")) {

                int bookerID = user.getUserID();
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<String> listInterviewStatus = new ArrayList<>();
                ArrayList<String> listInterviewStage = new ArrayList<>();

                ArrayList<InterviewDTO> createdInterviewList = interviewDAO.getCreatedInterview(bookerID);

                for (int i = 0; i < createdInterviewList.size(); i++) {
                    int interviewStageID = createdInterviewList.get(i).getStageID();
                    int statusID = createdInterviewList.get(i).getInteviewStatusID();

                    String stageName = interviewDAO.getInterviewStageByID(interviewStageID);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                }

                request.setAttribute("action", action);
                request.setAttribute("listInterviewStatus", listInterviewStatus);
                request.setAttribute("listInterviewStage", listInterviewStage);

                request.setAttribute("createdInterviewList", createdInterviewList);
                request.getRequestDispatcher("/views/HRStaff/created-inteview-list.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("showPendingInterview")) {
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<InterviewDTO> InterviewList = interviewDAO.getInterviewByStatus(1);
                ArrayList<String> listInterviewStatus = new ArrayList<>();
                ArrayList<String> listInterviewStage = new ArrayList<>();

                for (int i = 0; i < InterviewList.size(); i++) {
                    int interviewStageID = InterviewList.get(i).getStageID();
                    int statusID = InterviewList.get(i).getInteviewStatusID();

                    String stageName = interviewDAO.getInterviewStageByID(interviewStageID);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                }

                request.setAttribute("action", action);
                request.setAttribute("userID", user.getUserID());
                request.setAttribute("listInterviewStatus", listInterviewStatus);
                request.setAttribute("listInterviewStage", listInterviewStage);

                request.setAttribute("InterviewList", InterviewList);
                request.getRequestDispatcher("/views/HRStaff/interview-list.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showInterviewHisory")) {
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<InterviewDTO> InterviewList = interviewDAO.getInterviewByStatus(3);
                ArrayList<String> listInterviewStatus = new ArrayList<>();
                ArrayList<String> listInterviewStage = new ArrayList<>();

                for (int i = 0; i < InterviewList.size(); i++) {
                    int satgeID = InterviewList.get(i).getStageID();
                    int statusID = InterviewList.get(i).getInteviewStatusID();

                    String stageName = interviewDAO.getInterviewStageByID(satgeID);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                }

                request.setAttribute("action", action);
                request.setAttribute("userID", user.getUserID());
                request.setAttribute("listInterviewStatus", listInterviewStatus);
                request.setAttribute("listInterviewStage", listInterviewStage);

                request.setAttribute("InterviewList", InterviewList);
                request.getRequestDispatcher("/views/HRStaff/interview-list.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showInterviewByPostStage")) {
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<InterviewDTO> InterviewList = interviewDAO.getInterviewByStageID(stageID);
                ArrayList<String> listInterviewStatus = new ArrayList<>();
                ArrayList<String> listInterviewStage = new ArrayList<>();

                for (int i = 0; i < InterviewList.size(); i++) {
                    int satgeID = InterviewList.get(i).getStageID();
                    int statusID = InterviewList.get(i).getInteviewStatusID();

                    String stageName = interviewDAO.getInterviewStageByID(satgeID);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                }

                request.setAttribute("userID", user.getUserID());
                request.setAttribute("listInterviewStatus", listInterviewStatus);
                request.setAttribute("listInterviewStage", listInterviewStage);

                request.setAttribute("InterviewList", InterviewList);
                request.getRequestDispatcher("/views/HRStaff/interview-list-of-a-post-stage.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showInterviewDetail")) {

                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ParticipantDAO participantDAO = new ParticipantDAO();
                //get interview ID
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));

                InterviewDAO iDAO = new InterviewDAO();
                InterviewDTO interview = iDAO.getInterview(interviewID);
                request.setAttribute("interview", interview);
                postID = interview.getPostID();

                //get booker
                UserDAO uDAO = new UserDAO();
                UserDTO booker = uDAO.getUserByID(interview.getBookerID());
                request.setAttribute("booker", booker);
                //get booker

                //get Interviewer of this interview
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);
                request.setAttribute("listInterviewer", listInterviewer);
                //get list interviewer

                ArrayList<ParticipantDTO> listParticipant = participantDAO.getParticipant(interviewID);
                request.setAttribute("listParticipant", listParticipant);

                //get list candidate
                ArrayList<UserDTO> listCandidate = participantDAO.getListInterviewCandidate(interviewID, 2);
                request.setAttribute("listCandidate", listCandidate);
                //get list candidate

                //get result of candidate
                ArrayList<String> result = new ArrayList<>();

                for (UserDTO c : listCandidate) {
                    String rs = participantDAO.getCandidateResult(interviewID, c.getUserID());
                    result.add(rs);
                }
                request.setAttribute("result", result);
                //get result of candidate

                //get list candidate that have not to interview
                ArrayList<UserDTO> listNoInterviewCandidate = participantDAO.getListCandidateByResult(interviewID, 2);
                request.setAttribute("listNoInterviewCandidate", listNoInterviewCandidate);
                //get list candidate that have not to interview

                String interviewStage = iDAO.getInterviewStageByID(interview.getStageID());
                String interviewStatus = iDAO.getInterviewStatus(interview.getInteviewStatusID());
                String interviewFormat = iDAO.getInterviewFormat(interview.getFormatID());
                request.setAttribute("interviewFormat", interviewFormat);
                request.setAttribute("interviewStatus", interviewStatus);
                request.setAttribute("interviewStage", interviewStage);

                request.setAttribute("postID", interview.getPostID());
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/HRStaff/interview-detail.jsp").forward(request, response);
                return;

            } else if (action.equalsIgnoreCase("deleteInterview")) {

                //get interview ID
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                InterviewDAO interviewDAO = new InterviewDAO();
                boolean check = interviewDAO.deleteInterview(interviewID);
                if (!check) {
                    request.setAttribute("deleteMess", "B???n kh??ng th??? x??a cu???c ph???ng v???n v?? cu???c ph???ng v???n ??ang ???????c s??? d???ng");
                    //Reload interview detail
                    request.getRequestDispatcher("interview?action=interviewDetail").forward(request, response);
                    //Reload interview detail
                } else {
                    request.setAttribute("deleteMess", "X??a cu???c ph???ng v???n th??nh c??ng");

                    //reload created interview
                    request.getRequestDispatcher("interview?action=showCreatedInterview").forward(request, response);
                }
            } else {
                InterviewDAO dao = new InterviewDAO();
                String interviewStage = dao.getInterviewStageNameByID(stageID);
                ArrayList<String> interviewStatus = dao.getInterviewStatus();
                ArrayList<String> interviewFormat = dao.getInterviewFormat();

                request.setAttribute("postID", postID);
                request.setAttribute("interviewFormat", interviewFormat);
                request.setAttribute("interviewStatus", interviewStatus);
                request.setAttribute("interviewStage", interviewStage);
                request.getRequestDispatcher("/views/interview/interview-create.jsp").forward(request, response);
            }
        } else {
            InterviewDAO dao = new InterviewDAO();
            String interviewStage = dao.getInterviewStageNameByID(stageID);
            ArrayList<String> interviewStatus = dao.getInterviewStatus();
            ArrayList<String> interviewFormat = dao.getInterviewFormat();

            request.setAttribute("postID", postID);
            request.setAttribute("interviewFormat", interviewFormat);
            request.setAttribute("interviewStatus", interviewStatus);
            request.setAttribute("interviewStage", interviewStage);
            request.getRequestDispatcher("/views/interview/interview-create.jsp").forward(request, response);
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
