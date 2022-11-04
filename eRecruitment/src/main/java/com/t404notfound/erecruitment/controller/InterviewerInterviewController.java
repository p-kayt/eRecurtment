/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.interview.InterviewDAO;
import com.t404notfound.erecruitment.bean.interview.InterviewDTO;
import com.t404notfound.erecruitment.bean.interview.InterviewerDAO;
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
@WebServlet(name = "InterviewOfInterviewerController", urlPatterns = {"/interviewer/interview"})
public class InterviewerInterviewController extends HttpServlet {

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
        UserDAO userDAO = new UserDAO();

        int interviewID = 0;
        if (request.getParameter("interviewID") != null) {
            interviewID = Integer.parseInt(request.getParameter("interviewID"));
        };
        String action = request.getParameter("action");

        if (action != null) {
            if (action.equalsIgnoreCase("showInterviewDetail")) {
                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ParticipantDAO participantDAO = new ParticipantDAO();

                InterviewDAO iDAO = new InterviewDAO();
                InterviewDTO interview = iDAO.getInterview(interviewID);

                UserDTO booker = userDAO.getUserByID(interview.getBookerID());

                //get Interviewer of this interview
                ArrayList<UserDTO> listMainInterviewer = interviewerDAO.getInterviewer(interviewID);

                request.setAttribute("booker", booker.getFirstName() + " " + booker.getLastName());
                //get list interviewer
                request.setAttribute("listMainInterviewer", listMainInterviewer);
                //get list interviewer

                // get interview detail
                String interviewStage = iDAO.getInteviewStage(interview.getPostID(), interview.getStageID());
                String interviewStatus = iDAO.getInterviewStatus(interview.getInteviewStatusID());
                String interviewFormat = iDAO.getInterviewFormat(interview.getFormatID());
                request.setAttribute("interviewFormat", interviewFormat);
                request.setAttribute("interviewStatus", interviewStatus);
                request.setAttribute("interviewStage", interviewStage);
                // get interview detail

                ArrayList<ParticipantDTO> listParticipant = participantDAO.getParticipant(interviewID);
                request.setAttribute("listParticipant", listParticipant);

                //get list candidate
                ArrayList<UserDTO> listMainCandidate = participantDAO.getListCandidateByResult(interviewID, 1);
                request.setAttribute("listMainCandidate", listMainCandidate);
                //get list candidate

                //get list candidate that have not to interview
                ArrayList<UserDTO> listNoInterviewCandidate = participantDAO.getListCandidateByResult(interviewID, 2);
                request.setAttribute("listNoInterviewCandidate", listNoInterviewCandidate);
                //get list candidate that have not to interview

                request.setAttribute("interview", interview);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/Interviewer/interview-detail.jsp").forward(request, response);
                return;
            } else if (action.equalsIgnoreCase("showPendingInterview")) {
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<InterviewDTO> InterviewList = interviewDAO.getInterviewOfInterviewerByStatus(user.getUserID(), 1);
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
                request.getRequestDispatcher("/views/candidate/interview-list.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showInterviewHistory")) {
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<InterviewDTO> InterviewList = interviewDAO.getInterviewOfInterviewerByStatus(user.getUserID(), 3);
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
                request.getRequestDispatcher("/views/candidate/interview-list.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/home");
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
