/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.applicationposition.ApplicationPositionDAO;
import com.t404notfound.erecruitment.bean.applicationposition.ApplicationPositionDTO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ApplicationPositionDAO positionDAO = new ApplicationPositionDAO();
            ApplicationPostDAO postDAO = new ApplicationPostDAO();
            
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            switch(action){
                case "position-list":
                    ArrayList<ApplicationPositionDTO> list = positionDAO.listApplicationPositions();
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("views/job/position/positionlist.jsp").forward(request, response);
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
                    
                    positionDAO.addApplicationPosition(dto);
                     
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
