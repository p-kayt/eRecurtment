/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.interview.EvaluateDAO;
import com.t404notfound.erecruitment.bean.interview.EvaluateDTO;
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
@WebServlet(name = "CommonInterviewController", urlPatterns = {"/common-interview"})
public class CommonInterviewController extends HttpServlet {

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
        
        int postID = 0;
        if (request.getParameter("postID") != null) {
            postID = Integer.parseInt(request.getParameter("postID"));
        };
        
        if (action != null) {
            if (action.equalsIgnoreCase("showInterviewerPendingInterview")) {
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
                
                request.setAttribute("option", "pending");
                request.setAttribute("InterviewList", InterviewList);
                request.getRequestDispatcher("/views/candidate/interview-list.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showCandidatePendingInterview")) {
                InterviewDAO interviewDAO = new InterviewDAO();
                int userID = user.getUserID();
                ArrayList<InterviewDTO> InterviewList = interviewDAO.getInterviewOfCandidateByStatus(user.getUserID(), 1);
                ArrayList<String> listInterviewStatus = new ArrayList<>();
                ArrayList<String> listInterviewStage = new ArrayList<>();
                ArrayList<String> candidateInterviewTime = new ArrayList<>();
                
                for (int i = 0; i < InterviewList.size(); i++) {
                    int interviewPostID = InterviewList.get(i).getPostID();
                    int stageIndex = InterviewList.get(i).getStageID();
                    int statusID = InterviewList.get(i).getInteviewStatusID();
                    
                    String time = interviewDAO.getCandidateInterviewTime(userID, InterviewList.get(i).getInterviewID());
                    String stageName = interviewDAO.getInteviewStage(interviewPostID, stageIndex);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                    candidateInterviewTime.add(time);
                }
                
                request.setAttribute("userID", userID);
                request.setAttribute("listInterviewStatus", listInterviewStatus);
                request.setAttribute("listInterviewStage", listInterviewStage);
                request.setAttribute("candidateInterviewTime", candidateInterviewTime);
                
                request.setAttribute("InterviewList", InterviewList);
                request.getRequestDispatcher("/views/candidate/interview-list.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showInterviewerInterviewHistory")) {
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
                
                request.setAttribute("option", "history");
                request.setAttribute("InterviewList", InterviewList);
                request.getRequestDispatcher("/views/candidate/interview-list.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showCandidateInterviewHistory")) {
                InterviewDAO interviewDAO = new InterviewDAO();
                ArrayList<InterviewDTO> InterviewList = interviewDAO.getInterviewOfCandidateByStatus(user.getUserID(), 3);
                ArrayList<String> listInterviewStatus = new ArrayList<>();
                ArrayList<String> listInterviewStage = new ArrayList<>();
                ArrayList<String> listResultOfCandidate = new ArrayList<>();
                ArrayList<String> candidateInterviewTime = new ArrayList<>();
                int userID = user.getUserID();
                
                for (int i = 0; i < InterviewList.size(); i++) {
                    int interviewPostID = InterviewList.get(i).getPostID();
                    int stageIndex = InterviewList.get(i).getStageID();
                    int statusID = InterviewList.get(i).getInteviewStatusID();
                    
                    String time = interviewDAO.getCandidateInterviewTime(userID, InterviewList.get(i).getInterviewID());
                    String result = interviewDAO.getResultOfCandidate(userID, InterviewList.get(i).getInterviewID());
                    String stageName = interviewDAO.getInteviewStage(interviewPostID, stageIndex);
                    String statusName = interviewDAO.getInteviewStatus(statusID);
                    listInterviewStage.add(stageName);
                    listInterviewStatus.add(statusName);
                    listResultOfCandidate.add(result);
                    candidateInterviewTime.add(time);
                }
                
                request.setAttribute("userID", userID);
                request.setAttribute("listInterviewStatus", listInterviewStatus);
                request.setAttribute("listInterviewStage", listInterviewStage);
                request.setAttribute("listResultOfCandidate", listResultOfCandidate);
                request.setAttribute("candidateInterviewTime", candidateInterviewTime);
                
                request.setAttribute("InterviewList", InterviewList);
                request.getRequestDispatcher("/views/candidate/interview-list.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showCandidateInterviewDetail")) {
                // must contain postID and interviewID

                InterviewDAO interviewDAO = new InterviewDAO();
                int userID = user.getUserID();
                
                InterviewerDAO interviewerDAO = new InterviewerDAO();
                InterviewDTO interview = interviewDAO.getInterview(interviewID);
                int bookerID = interview.getBookerID();
                UserDTO booker = userDAO.getUserByID(bookerID);
                String stageName = interviewDAO.getInteviewStage(postID, interview.getStageID());
                String formatName = interviewDAO.getInterviewFormat(interview.getFormatID());
                String time = interviewDAO.getCandidateInterviewTime(userID, interviewID);
                String result = interviewDAO.getResultOfCandidate(userID, interviewID);
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);
                
                request.setAttribute("listInterviewer", listInterviewer);
                request.setAttribute("result", result);
                request.setAttribute("time", time);
                request.setAttribute("formatName", formatName);
                request.setAttribute("stageName", stageName);
                request.setAttribute("booker", booker);
                request.setAttribute("interview", interview);
                request.getRequestDispatcher("/views/candidate/interview-detail.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("showInterviewerInterviewDetail")) {
                // must contain postID and interviewID and option of this interview

                String option = request.getParameter("option");  //pending or history
                int resultID;
                
                switch (option.toLowerCase()) {
                    case "pending":
                        resultID = 1;
                        break;
                    case "history":
                        resultID = 2;
                        break;
                    default:
                        resultID = 1;
                }
                
                ParticipantDAO participantDAO = new ParticipantDAO();
                InterviewDAO interviewDAO = new InterviewDAO();
                int userID = user.getUserID();
                
                InterviewerDAO interviewerDAO = new InterviewerDAO();
                InterviewDTO interview = interviewDAO.getInterview(interviewID);
                int bookerID = interview.getBookerID();
                UserDTO booker = userDAO.getUserByID(bookerID);
                String stageName = interviewDAO.getInteviewStage(postID, interview.getStageID());
                String formatName = interviewDAO.getInterviewFormat(interview.getFormatID());
                
                String statusName = interviewDAO.getInteviewStatus(interview.getInteviewStatusID());
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);

                //get list candidate
                ArrayList<UserDTO> listCandidate = participantDAO.getListCandidateByResult(interviewID, resultID);
                request.setAttribute("listCandidate", listCandidate);
                //get list candidate
                //get time of candidates
                ArrayList<String> candidateInterviewTime = new ArrayList<>();
                for (UserDTO u : listCandidate) {
                    String time = interviewDAO.getCandidateInterviewTime(u.getUserID(), interviewID);
                    candidateInterviewTime.add(time);
                }
                //get time of candidates
                
                EvaluateDAO evaluateDAO = new EvaluateDAO();
                EvaluateDTO evaluate = evaluateDAO.getEvaluation(user.getUserID(), resultID, interviewID);
                
                request.setAttribute("evaluate", evaluate);
                request.setAttribute("listInterviewer", listInterviewer);
                request.setAttribute("statusName", statusName);
                request.setAttribute("listCandidate", listCandidate);
                request.setAttribute("candidateInterviewTime", candidateInterviewTime);
                request.setAttribute("formatName", formatName);
                request.setAttribute("stageName", stageName);
                request.setAttribute("booker", booker);
                request.setAttribute("interview", interview);
                request.setAttribute("option", option);
                request.getRequestDispatcher("/views/Interviewer/interview-detail.jsp").forward(request, response);
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
