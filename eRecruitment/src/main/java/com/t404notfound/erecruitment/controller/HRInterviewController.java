/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDTO;
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

        if (action != null && !action.equals("")) {
            if (action.equalsIgnoreCase("bookInteview")) {
                int formatID = Integer.parseInt(format);
                int stageID = Integer.parseInt(stage);
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

                    request.setAttribute("booker", user.getFirstName() + " " + user.getLastName());
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
                    ArrayList<String> interviewStage = dao.getInterviewStage(postID);
                    ArrayList<String> interviewStatus = dao.getInterviewStatus();
                    ArrayList<String> interviewFormat = dao.getInterviewFormat();
                    request.setAttribute("interviewFormat", interviewFormat);
                    request.setAttribute("interviewStatus", interviewStatus);
                    request.setAttribute("interviewStage", interviewStage);

                    request.getRequestDispatcher("/views/interview/interview_create.jsp").forward(request, response);
                }
            } else if (action.equalsIgnoreCase("interviewDetail")) {

                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ParticipantDAO participantDAO = new ParticipantDAO();
                //get interview ID
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));

                InterviewDAO iDAO = new InterviewDAO();
                InterviewDTO interview = iDAO.getInterview(interviewID);
                request.setAttribute("interview", interview);
                //get Interviewer of this interview
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);
                request.setAttribute("booker", user.getFirstName() + " " + user.getLastName());
                //get list interviewer
                request.setAttribute("listMainInterviewer", listInterviewer);

                ArrayList<ParticipantDTO> listParticipant = participantDAO.getParticipant(interviewID);
                request.setAttribute("listParticipant", listParticipant);

                //get list candidate
                ArrayList<UserDTO> listCandidate = participantDAO.getListCandidateByResult(interviewID, 1);
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
                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getAvailableInterviewer(interviewID);
                request.setAttribute("postID", postID);
                request.setAttribute("listInterviewer", listInterviewer);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/interviewer-list.jsp").forward(request, response);
                /*reload list interview page*/

            } else if (action.equalsIgnoreCase("removeInterviewer")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                InterviewerDAO iDAO = new InterviewerDAO();
                iDAO.removeInterviewer(userID, interviewID);
                /*reload detail page*/
                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);

                InterviewDAO interviewDAO = new InterviewDAO();
                InterviewDTO interview = interviewDAO.getInterview(interviewID);

                InterviewDAO dao = new InterviewDAO();
                ArrayList<String> interviewStage = dao.getInterviewStage(postID);
                ArrayList<String> interviewStatus = dao.getInterviewStatus();
                ArrayList<String> interviewFormat = dao.getInterviewFormat();
                request.setAttribute("interviewFormat", interviewFormat);
                request.setAttribute("interviewStatus", interviewStatus);
                request.setAttribute("interviewStage", interviewStage);

                request.setAttribute("postID", postID);
                request.setAttribute("booker", user.getFirstName() + " " + user.getLastName());
                request.setAttribute("interview", interview);
                request.setAttribute("listMainInterviewer", listInterviewer);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/interview-detail.jsp").forward(request, response);
                /*reload detail page*/
            } else if (action.equalsIgnoreCase("updateInterview")) {
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                int formatID = Integer.parseInt(format);
                int stageID = Integer.parseInt(stage);
                int maxCandidate = Integer.parseInt(maxCandidateString);
                int bookerID = user.getUserID();
                int statusID = Integer.parseInt(status);
                String time = date + " " + hour;
                InterviewDAO iDAO = new InterviewDAO();
                InterviewDTO update = iDAO.updateInterview(interviewID, description, link, address, time, maxCandidate, stageID, formatID, statusID);

                /*Load list participant and interviewer*/
                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ParticipantDAO participantDAO = new ParticipantDAO();
                //get Interviewer of this interview
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);
                //get list interviewer
                request.setAttribute("listMainInterviewer", listInterviewer);

                ArrayList<ParticipantDTO> listParticipant = participantDAO.getParticipant(interviewID);
                request.setAttribute("listParticipant", listParticipant);

                //get list candidate
                ArrayList<UserDTO> listCandidate = participantDAO.getListCandidateByResult(interviewID, 1);
                request.setAttribute("listMainCandidate", listCandidate);
                //get list candidate

                //get list candidate that have not to interview
                ArrayList<UserDTO> listNoInterviewCandidate = participantDAO.getListCandidateByResult(interviewID, 2);
                request.setAttribute("listNoInterviewCandidate", listNoInterviewCandidate);
                //get list candidate that have not to interview
                /*Load list participant and interviewer*/

                InterviewDAO dao = new InterviewDAO();
                ArrayList<String> interviewStage = dao.getInterviewStage(postID);
                ArrayList<String> interviewStatus = dao.getInterviewStatus();
                ArrayList<String> interviewFormat = dao.getInterviewFormat();
                request.setAttribute("interviewFormat", interviewFormat);
                request.setAttribute("interviewStatus", interviewStatus);
                request.setAttribute("interviewStage", interviewStage);

                request.setAttribute("interviewID", interviewID);
                request.setAttribute("postID", postID);
                request.setAttribute("interview", update);
                request.setAttribute("booker", user.getFirstName() + " " + user.getLastName());
                request.getRequestDispatcher("/views/interview/interview-detail.jsp").forward(request, response);
                return;
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
                /*reload list candidate page*/

            } else if (action.equalsIgnoreCase("removeCandidate")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                ParticipantDAO pDAO = new ParticipantDAO();
                pDAO.removeCandidate(userID, interviewID);
                /*reload list candidate page*/
                InterviewDAO interviewDAO = new InterviewDAO();
                InterviewDTO interview = interviewDAO.getInterview(interviewID);

                ArrayList<UserDTO> listCandidate = pDAO.getListCandidate(interviewID);

                InterviewDAO dao = new InterviewDAO();
                ArrayList<String> interviewStage = dao.getInterviewStage(postID);
                ArrayList<String> interviewStatus = dao.getInterviewStatus();
                ArrayList<String> interviewFormat = dao.getInterviewFormat();
                request.setAttribute("interviewFormat", interviewFormat);
                request.setAttribute("interviewStatus", interviewStatus);
                request.setAttribute("interviewStage", interviewStage);

                request.setAttribute("postID", postID);
                request.setAttribute("interview", interview);
                request.setAttribute("listMainCandidate", listCandidate);
                request.setAttribute("interviewID", interviewID);
                request.setAttribute("booker", user.getFirstName() + " " + user.getLastName());
                request.getRequestDispatcher("/views/interview/interview-detail.jsp").forward(request, response);
                /*reload list candidate page*/
            } else if (action.equalsIgnoreCase("showCreatedInterview")) {

                //get URL for Back function of each page
//            String url = request.getServletPath();
                int bookerID = user.getUserID();
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<String> listInterviewStatus = new ArrayList<>();
                ArrayList<String> listInterviewStage = new ArrayList<>();

                ArrayList<InterviewDTO> createdInterviewList = interviewDAO.getCreatedInterview(bookerID);

                for (int i = 0; i < createdInterviewList.size(); i++) {
                    int interviewPostID = createdInterviewList.get(i).getPostID();
                    int stageIndex = createdInterviewList.get(i).getStageID();
                    int statusID = createdInterviewList.get(i).getInteviewStatusID();

                    String stageName = interviewDAO.getInteviewStage(interviewPostID, stageIndex);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                }

                request.setAttribute("listInterviewStatus", listInterviewStatus);
                request.setAttribute("listInterviewStage", listInterviewStage);

//            session.setAttribute("url", url);
                request.setAttribute("createdInterviewList", createdInterviewList);
                request.getRequestDispatcher("/views/HRStaff/created-inteview-list.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("showPendingInterview")) {
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<InterviewDTO> InterviewList = interviewDAO.getInterviewByStatus(1);
                ArrayList<String> listInterviewStatus = new ArrayList<>();
                ArrayList<String> listInterviewStage = new ArrayList<>();

                for (int i = 0; i < InterviewList.size(); i++) {
                    int interviewPostID = InterviewList.get(i).getPostID();
                    int stageIndex = InterviewList.get(i).getStageID();
                    int statusID = InterviewList.get(i).getInteviewStatusID();

                    String stageName = interviewDAO.getInteviewStage(interviewPostID, stageIndex);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                }

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
                    int interviewPostID = InterviewList.get(i).getPostID();
                    int stageIndex = InterviewList.get(i).getStageID();
                    int statusID = InterviewList.get(i).getInteviewStatusID();

                    String stageName = interviewDAO.getInteviewStage(interviewPostID, stageIndex);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                }

                request.setAttribute("userID", user.getUserID());
                request.setAttribute("listInterviewStatus", listInterviewStatus);
                request.setAttribute("listInterviewStage", listInterviewStage);

                request.setAttribute("InterviewList", InterviewList);
                request.getRequestDispatcher("/views/HRStaff/interview-list.jsp").forward(request, response);
            } else {
                InterviewDAO dao = new InterviewDAO();
                ArrayList<String> interviewStage = dao.getInterviewStage(postID);
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
            ArrayList<String> interviewStage = dao.getInterviewStage(postID);
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
