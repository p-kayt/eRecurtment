/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.cv.CVDAO;
import com.t404notfound.erecruitment.bean.cv.CVDTO;
import java.io.IOException;
import java.sql.Date;
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
@WebServlet(name = "CVController", urlPatterns = {"/cv"})
public class CVController extends HttpServlet {

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
        String action = request.getParameter("action");
        String introduction = request.getParameter("introduction");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        //Date dob = Date.valueOf(request.getParameter("dob"));
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
        String city = request.getParameter("city");

        CVDAO cvdao = new CVDAO();
        CVDTO cvdto = new CVDTO();
        if (user != null) {

            switch (action) {
                case "createMyCV":
                    request.getRequestDispatcher("/views/cv/cv-write.jsp").forward(request, response);
                    break;
                case "createCV":
                    
                    cvdto = new CVDTO(0, firstName, lastName, city, new Date(01,01,2001), introduction, email, phoneNumber, address, city, gender, user.getUserID(), null, null, null, null, null, null, null, null);
                    cvdao.saveCV(cvdto);
                    cvdto = cvdao.loadCVByUserID(user.getUserID());
                    request.setAttribute("cv", cvdto);
                    request.getRequestDispatcher("/profile").forward(request, response);
                    break;
                default:
                    request.getRequestDispatcher("/home").forward(request, response);
            }
        }

        //        
        //        CVDTO cvdto = cvdao.loadCV(1);
        //        
        //        request.setAttribute("cv", cvdto);
        //        request.getRequestDispatcher("views/cv/cv-write.jsp").forward(request, response);
        {

        }
    }

    public static void main(String[] args) {

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
