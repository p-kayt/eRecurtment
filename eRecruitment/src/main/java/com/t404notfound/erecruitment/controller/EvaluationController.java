/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.interview.EvaluateDAO;
import com.t404notfound.erecruitment.bean.interview.EvaluateDTO;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "EvaluationController", urlPatterns = {"/evaluate"})
public class EvaluationController extends HttpServlet {

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

        String evaluateAction = request.getParameter("evaluateAction");
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        UserDAO userDAO = new UserDAO();

        if (evaluateAction != null) {
            switch (evaluateAction.toLowerCase()) {
                case "evaluate":
                    String description = request.getParameter("description").trim();
                    int score = Integer.parseInt(request.getParameter("score"));
                    int interviewerID = Integer.parseInt(request.getParameter("interviewerID"));
                    int interviewID = Integer.parseInt(request.getParameter("interviewID"));
                    int participantID = Integer.parseInt(request.getParameter("participantID"));

                    EvaluateDAO evaluateDAO = new EvaluateDAO();

                    //if evaluation exist then update, else add new evaluation
                    boolean checkEvaluation = evaluateDAO.checkEvaluation(interviewerID, participantID, interviewID);
                    if (checkEvaluation) {
                        evaluateDAO.updateEvaluation(description, score, interviewerID, participantID, interviewID);
                    } else {
                        evaluateDAO.addEvaluation(description, score, interviewerID, participantID, interviewID);
                    }
                    //if evaluation exist then update, else add new evaluation

                    request.getRequestDispatcher("/common-interview").forward(request, response);
                    break;
                default:
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
