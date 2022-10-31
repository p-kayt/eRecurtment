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
@WebServlet(name = "InterviewController", urlPatterns = {"/interview"})
public class InterviewController extends HttpServlet {

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
        int postID = 0;
        if (request.getParameter("postID") != null) {
            postID = Integer.parseInt(request.getParameter("postID"));
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
                    session.setAttribute("interview", interview);
                    session.setAttribute("interviewID", interviewID);
                    request.setAttribute("action", "interviewDetail");
                    session.setAttribute("booker", user.getFirstName() + " " + user.getLastName());
                    request.getRequestDispatcher("/views/interview/interview-detail.jsp").forward(request, response);
                    return;
                } else {
                    request.setAttribute("format", format);
                    request.setAttribute("link", link);
                    request.setAttribute("address", address);
                    request.setAttribute("stage", stageID);
                    request.setAttribute("date", date);
                    request.setAttribute("time", hour);
                    request.setAttribute("maxCandidate", maxCandidate);
                    request.setAttribute("description", description);
                    request.getRequestDispatcher("/views/interview/interview-create.jsp").forward(request, response);
                }
            } else if (action.equalsIgnoreCase("interviewDetail")) {

                InterviewerDAO interviewerDAO = new InterviewerDAO();
                int interviewID = ((Integer) session.getAttribute("interviewID")).intValue();
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);
                session.setAttribute("listMainInterviewer", listInterviewer);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/interview-detail.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("showListInterviewer")) {

                InterviewerDAO iDAO = new InterviewerDAO();
                int interviewID = ((Integer) session.getAttribute("interviewID")).intValue();
                ArrayList<UserDTO> listInterviewer = iDAO.getAvailableInterviewer(interviewID);
                session.setAttribute("listInterviewer", listInterviewer);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/interviewer-list.jsp").forward(request, response);

            } else if (action.equalsIgnoreCase("addInterviewer")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = ((Integer) session.getAttribute("interviewID")).intValue();
                InterviewerDAO iDAO = new InterviewerDAO();
                boolean check = iDAO.addInterviewer(userID, interviewID);
                /*may be bug here*/
                /*reload list interview page*/
                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getAvailableInterviewer(interviewID);
                session.setAttribute("listInterviewer", listInterviewer);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/interviewer-list.jsp").forward(request, response);
                /*reload list interview page*/

            } else if (action.equalsIgnoreCase("removeInterviewer")) {

                int userID = Integer.parseInt((String) request.getParameter("userID"));
                int interviewID = ((Integer) session.getAttribute("interviewID")).intValue();
                InterviewerDAO iDAO = new InterviewerDAO();
                boolean check = iDAO.removeInterviewer(userID, interviewID);
                /*may be bug here*/
                /*reload detail page*/
                InterviewerDAO interviewerDAO = new InterviewerDAO();
                ArrayList<UserDTO> listInterviewer = interviewerDAO.getInterviewer(interviewID);
                session.setAttribute("listMainInterviewer", listInterviewer);
                request.setAttribute("interviewID", interviewID);
                request.getRequestDispatcher("/views/interview/interview-detail.jsp").forward(request, response);
                /*reload detail page*/
            }
        } else {
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
