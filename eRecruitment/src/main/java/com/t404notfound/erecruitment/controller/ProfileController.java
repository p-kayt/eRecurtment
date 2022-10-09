/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
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
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
public class ProfileController extends HttpServlet {

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
        UserDTO user = (UserDTO) session.getAttribute("user");
        String action = request.getParameter("action");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String gender = request.getParameter("gender");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        //check case user is null
        if (user != null) {

            UserDAO dao = new UserDAO();

            if (action != null) {
                if (action.equalsIgnoreCase("changePass")) {
                    //check case password is null
                    if (oldPassword == null || oldPassword.equals("")) {
                        request.setAttribute("passwordErrMess1", "Password cannot be empty");
                        request.setAttribute("newPassword", newPassword);
                    } else {
                        //check case password is null
                        if (newPassword == null || newPassword.equals("")) {
                            request.setAttribute("passwordErrMess2", "Password cannot be empty");
                            request.setAttribute("oldPassword", oldPassword);
                        } else {
                            //checkPassword using login function 
                            UserDTO checkPass = dao.login(user.getEmail(), oldPassword);
                            if (checkPass != null) {
                                boolean checkChangePass = dao.changePass(user.getUserID(), newPassword);
                                if (checkChangePass) {
                                    user.setPassword(newPassword);
                                    session.setAttribute("user", user);
                                    request.setAttribute("changePassMess", "Change password successfully.");
                                }
                            } else {
                                request.setAttribute("passwordErrMess1", "Incorrect password.");
                                request.setAttribute("oldPassword", oldPassword);
                                request.setAttribute("newPassword", newPassword);
                            }
                        }
                    }
                } else if (action.equalsIgnoreCase("updateProfile")) {
                    if (firstName == null || firstName.trim().equals("")) {
                        firstName = user.getFirstName();
                    }
                    if (lastName == null || lastName.trim().equals("")) {
                        lastName = user.getLastName();
                    }

                    if (dao.updateProfile(user.getUserID(), firstName, lastName, gender)) {
                        user.setFirstName(firstName);
                        user.setLastName(lastName);
                        int genderID;
                        switch (gender.toLowerCase()) {
                            case "male":
                                genderID = 1;
                                break;
                            case "female":
                                genderID = 2;
                                break;
                            default:
                                genderID = 3;
                                break;
                        }
                        user.setGenderID(genderID);
                        session.setAttribute("user", user);
                        request.setAttribute("updateMess", "Update profile successfully");
                    }
                }
            }
        }

        request.getRequestDispatcher("/views/account/profile.jsp").forward(request, response);
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
