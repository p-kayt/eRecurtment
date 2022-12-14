/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.AdminUserDAO;
import com.t404notfound.erecruitment.bean.AdminUserDTO;
import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.interview.ManagerParticipantDAO;
import com.t404notfound.erecruitment.bean.interview.ManagerParticipantDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Savoy
 */
@WebServlet(name = "ManagerViewCandidates", urlPatterns = {"/ManagerViewCandidates"})
public class ManagerViewCandidates extends HttpServlet {

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
        String url = "views/HRManager/candidatelist.jsp";
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login");
        } else if (user.getUserRole() != 3) {
            response.sendRedirect("home");
        }
        try {
            String SearchValue = request.getParameter("txtSearch").trim();
            String action = request.getParameter("action");
            ArrayList<ManagerParticipantDTO> list = new ArrayList<>();
            if (action.equalsIgnoreCase("T??m ki???m")) {
                try {
                    list = ManagerParticipantDAO.getParticipants(SearchValue);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            } else if (action.equalsIgnoreCase("Quay v??? danh s??ch")) {
                try {
                    list = ManagerParticipantDAO.getParticipants(SearchValue);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            } else if (action.equalsIgnoreCase("Hi???n th??? t???t c???")) {
                try {
                    SearchValue = "";
                    list = ManagerParticipantDAO.getParticipants(SearchValue);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            } else if (action.equalsIgnoreCase("All")) {
                try {
                    SearchValue = "";
                    list = ManagerParticipantDAO.getParticipants(SearchValue);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            }
            request.setAttribute("SearchValue", SearchValue);
            if (list.isEmpty()) {
                request.setAttribute("nullMsg", "Kh??ng t??m th???y!");
            } else {
                request.setAttribute("Candidates", list);
            }
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
