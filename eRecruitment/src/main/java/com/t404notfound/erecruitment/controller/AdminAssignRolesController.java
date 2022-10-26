/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.AdminUserDAO;
import com.t404notfound.erecruitment.bean.AdminUserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Savoy
 */
@WebServlet(name = "AdminAssignRolesController", urlPatterns = {"/AdminAssignRoles"})
public class AdminAssignRolesController extends HttpServlet {

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
        String url = "./adminViewUser";
        try {
            String SearchValue = request.getParameter("SearchValue").trim();
            request.setAttribute("SearchValue", SearchValue);
            String email = request.getParameter("Email");
            String idString = request.getParameter("ID");
            int id = Integer.parseInt(idString);
            String candidate = request.getParameter("isCandidate");
            boolean isCandidate = Boolean.parseBoolean(candidate);
            String HRStaff = request.getParameter("isHRStaff");
            boolean isHRStaff = Boolean.parseBoolean(HRStaff);
            String HRManager = request.getParameter("isHRManager");
            boolean isHRManager = Boolean.parseBoolean(HRManager);
            String interviewer = request.getParameter("isInterviewer");
            boolean isInterviewer = Boolean.parseBoolean(interviewer);
            ArrayList<AdminUserDTO> list = new ArrayList<>();
            request.setAttribute("fuck", candidate);
            request.setAttribute("fuck2", interviewer);

            if (isCandidate) {
                try {
                    AdminUserDAO.addRoles(id, 1);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            } else {
                try {
                    AdminUserDAO.removeRoles(id, 1);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            }

            if (isHRStaff) {
                try {
                    AdminUserDAO.addRoles(id, 2);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            } else {
                try {
                    AdminUserDAO.removeRoles(id, 2);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            }

            if (isHRManager) {
                try {
                    AdminUserDAO.addRoles(id, 3);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            } else {
                try {
                    AdminUserDAO.removeRoles(id, 3);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            }

            if (isInterviewer) {
                try {
                    AdminUserDAO.addRoles(id, 4);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            } else {
                try {
                    AdminUserDAO.removeRoles(id, 4);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            }

            try {
                list = AdminUserDAO.getUsers(SearchValue);
            } catch (SQLException | NamingException | ClassNotFoundException ex) {
            }
            request.setAttribute("Users", list);
        } finally {
            RequestDispatcher ReqDis = request.getRequestDispatcher(url);
            ReqDis.forward(request, response);
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
