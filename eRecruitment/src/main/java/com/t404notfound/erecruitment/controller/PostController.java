/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.applicationposition.ApplicationPositionDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDTO;
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
 * @author MSI GF63
 */
@WebServlet(name = "PostController", urlPatterns = {"/post"})
public class PostController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ApplicationPositionDAO positionDAO = new ApplicationPositionDAO();
            ApplicationPostDAO postDAO = new ApplicationPostDAO();
            String msg = "";
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            switch (action) {
                case "search-posts":
                    String keyword = request.getParameter("keyword");
                    request.setAttribute("keyword", keyword);
                    int statusID = Integer.parseInt(request.getParameter("statusID"));
                    request.setAttribute("statusID", statusID);
                    ArrayList<ApplicationPostDTO> postList = postDAO.searchApplicationPosts(keyword, statusID);
                    request.setAttribute("postList", postList);
                    request.getRequestDispatcher("views/job/post/search-post-result.jsp").forward(request, response);
                    break;
                case "advanced-search-posts":
                    keyword = request.getParameter("keyword");
                    request.setAttribute("keyword", keyword);
                    statusID = Integer.parseInt(request.getParameter("statusID"));
                    request.setAttribute("statusID", statusID);
                    String salary = request.getParameter("salary");
                    request.setAttribute("salary", salary);
                    int workingForm = Integer.parseInt(request.getParameter("workingForm"));
                    request.setAttribute("workingForm", workingForm);
                    int dateOrder = Integer.parseInt(request.getParameter("dateOrder"));
                    request.setAttribute("dateOrder", dateOrder);
                    
                    String formID = "";
                    if(workingForm == 2){
                        formID = " and post.FormID in (1, 2, 3)";
                    }
                    else if(workingForm == 3){
                        formID = " and post.FormID in (4, 5, 6)";
                    }
                    
                    String sortByDate = "";
                    if(dateOrder == 1){
                        sortByDate = " order by ExpiredDate desc";
                    }
                    else{
                        sortByDate = " order by StartDate desc";
                    }
                    
                    postList = postDAO.advanceSearchApplicationPosts(keyword, statusID, salary, formID, sortByDate);
                    request.setAttribute("postList", postList);
                    request.getRequestDispatcher("views/job/post/search-post-result.jsp").forward(request, response);
                    break;
                case "more-recommended":
                    request.setAttribute("statusID", 3);
                    request.setAttribute("workingForm", 1);
                    
                    postList = postDAO.listHighestHiringQuantityPosts();
                    request.setAttribute("postList", postList);
                    request.getRequestDispatcher("views/job/post/search-post-result.jsp").forward(request, response);
                    break;
                case "more-fulltime":
                    request.setAttribute("statusID", 3);
                    request.setAttribute("workingForm", 2);
                    
                    postList = postDAO.listFullTimePost();
                    request.setAttribute("postList", postList);
                    request.getRequestDispatcher("views/job/post/search-post-result.jsp").forward(request, response);
                    break;
                case "more-parttime":
                    request.setAttribute("statusID", 3);
                    request.setAttribute("workingForm", 3);
                    
                    postList = postDAO.listPartTimePost();
                    request.setAttribute("postList", postList);
                    request.getRequestDispatcher("views/job/post/search-post-result.jsp").forward(request, response);
                    break;
                case "post-detail":
                    int postID = Integer.parseInt(request.getParameter("postID"));
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
