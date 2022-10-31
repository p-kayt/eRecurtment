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
@WebServlet(name = "AdminViewUsersController", urlPatterns = {"/adminViewUser"})
public class AdminViewUsersController extends HttpServlet {

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
        String url = "views/admin/userlist.jsp";
        try {
            String SearchValue = request.getParameter("txtSearch").trim();
            String action = request.getParameter("action");
            ArrayList<AdminUserDTO> list = new ArrayList<>();
            if (action == null) {
                request.getRequestDispatcher("views/account/login.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("Search")) {
                try {
                    list = AdminUserDAO.getUsers(SearchValue);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            } else if (action.equalsIgnoreCase("All")) {
                try {
                    SearchValue = "";
                    list = AdminUserDAO.getUsers(SearchValue);
                } catch (SQLException | NamingException | ClassNotFoundException ex) {
                }
            }
            request.setAttribute("SearchValue", SearchValue);
            if (list.isEmpty()) {
                request.setAttribute("nullMsg", "No Record Matched.");
            } else {
                request.setAttribute("Users", list);
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
