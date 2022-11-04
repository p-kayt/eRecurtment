/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MINH TRI
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String url = (String)session.getAttribute("url");
        Cookie checkCookie = null;
        
        /*duyet cookie*/
        Cookie[] cookie = request.getCookies();
        if (cookie != null) {
            for (Cookie c : cookie) {
                if (c.getName().equalsIgnoreCase("email")) {
                    if (email == null || email.trim().equals("")) {
                        email = c.getValue();
                    }
                } else if (c.getName().equalsIgnoreCase("password")) {
                    if (password == null || password.trim().equals("")) {
                        password = c.getValue();
                    }
                } else if(c.getName().equalsIgnoreCase("logged")) {
                    checkCookie = c;
                }
            }
        }
        /*duyet cookie*/
        
        if (email != null && password != null) {
            email = email.toLowerCase();
            UserDAO dao = new UserDAO();
            UserDTO user = dao.login(email, password);
            if (user == null) {
                request.setAttribute("email", email);
                request.setAttribute("errorMessage", "Email hoặc mật khẩu không chính xác");
            } else {
                session.setAttribute("user", user);

                /*add cookie*/
                if (checkCookie == null) {
                    Cookie e = new Cookie("email", email);
                    Cookie p = new Cookie("password", password);
                    Cookie l = new Cookie("logged", "true");
                    e.setMaxAge(60 * 60 * 24); //luu trong 1 ngay
                    p.setMaxAge(60 * 60 * 24); //luu trong 1 ngay
                    l.setMaxAge(60 * 60 * 24);
                    response.addCookie(e);
                    response.addCookie(p);
                    response.addCookie(l);
                } else {
                    checkCookie.setValue("true");
                    response.addCookie(checkCookie);
                }
                /*add cookie*/
                if (url == null || url.trim().equals("")) {
                    url = "/home";
                }
                response.sendRedirect(request.getContextPath() + url);
                return;
            }
        }
        // Hoa: message for Applying for a job but not logged-in
        String msg = (String)request.getAttribute("msg");
        request.setAttribute("msg", msg);
        //
        request.getRequestDispatcher("views/account/login.jsp").forward(request, response);
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
