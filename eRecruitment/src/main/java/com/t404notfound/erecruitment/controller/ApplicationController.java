/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import applicationstage.ApplicationStageDAO;
import applicationstage.ApplicationStageDTO;
import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.application.ApplicationDAO;
import com.t404notfound.erecruitment.bean.application.ApplicationDTO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDTO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Huu Minh
 */
@WebServlet(name = "ApplicationController", urlPatterns = {"/application"})
public class ApplicationController extends HttpServlet {

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
        if (action == null) {
            action = "view-applied-position";
        }

        int postID = 0;
        if (request.getParameter("postID") != null) {
            postID = Integer.parseInt(request.getParameter("postID"));
        };

        ApplicationDAO appdao = new ApplicationDAO();
        ApplicationPostDAO postdao = new ApplicationPostDAO();
        if (user != null) {

            if (action.equalsIgnoreCase("view-applied-position")) {
                ArrayList<ApplicationDTO> appList = appdao.listAllApplicationOfAUser(user.getUserID());
                ArrayList<ApplicationPostDTO> postList = new ArrayList<>();
                for (ApplicationDTO x : appList) {
                    postList.add(postdao.loadApplicationPostWithName(x.getPostID()));
                }

                request.setAttribute("postList", postList);
                request.setAttribute("appList", appList);
                request.getRequestDispatcher("/views/job/applied-position/applied-position.jsp").forward(request, response);
            }
            if (action.equalsIgnoreCase("cancel-application")) {
                int applicationID = Integer.parseInt(request.getParameter("appID"));

                appdao.cancelApplication(applicationID);

                ArrayList<ApplicationDTO> appList = appdao.listAllApplicationOfAUser(user.getUserID());
                ArrayList<ApplicationPostDTO> postList = new ArrayList<>();
                for (ApplicationDTO x : appList) {
                    postList.add(postdao.loadApplicationPostWithName(x.getPostID()));
                }

                request.setAttribute("postList", postList);
                request.setAttribute("appList", appList);
                request.getRequestDispatcher("/views/job/applied-position/applied-position.jsp").forward(request, response);
            }
            if (action.equalsIgnoreCase("view-application-detail")) {
                int applicationID = Integer.parseInt(request.getParameter("appID"));
                int stageID = Integer.parseInt(request.getParameter("stageID"));
                postID = Integer.parseInt(request.getParameter("postID"));
                
                ApplicationStageDAO stagedao = new ApplicationStageDAO();
                
                ArrayList<ApplicationStageDTO> stageList = stagedao.listAllApplicationStageByPostID(postID);
                ApplicationStageDTO currentStage = stagedao.getApplicationStage(stageID);
                ApplicationDTO app = appdao.getApplicationByID(applicationID);
                ApplicationPostDTO post = postdao.loadApplicationPostWithName(postID);
                boolean check = false;
                
                request.setAttribute("check", check);
                request.setAttribute("post", post);
                request.setAttribute("application", app);
                request.setAttribute("stage", currentStage);
                request.setAttribute("stageList", stageList);
                request.getRequestDispatcher("/views/job/applied-position/application-detail.jsp").forward(request, response);
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
