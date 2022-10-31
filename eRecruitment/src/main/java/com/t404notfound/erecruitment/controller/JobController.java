/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.applicationposition.ApplicationPositionDAO;
import com.t404notfound.erecruitment.bean.applicationposition.ApplicationPositionDTO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDTO;
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
        request.setCharacterEncoding("UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            ApplicationPositionDAO positionDAO = new ApplicationPositionDAO();
            ApplicationPostDAO postDAO = new ApplicationPostDAO();
            String msg = "";
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            switch (action) {
                case "load-add-position":
                    request.getRequestDispatcher("views/job/position/add-position.jsp").forward(request, response);
                    break;
                // NOT FINISHED
                case "load-add-post":
                    
                    break;
                case "position-list":
                    ArrayList<ApplicationPositionDTO> list = positionDAO.listApplicationPositions();
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("views/job/position/positionlist.jsp").forward(request, response);
                    break;
                case "search-position":
                    String keyword = request.getParameter("keyword");
                    request.setAttribute("keyword", keyword);
                    list = positionDAO.searchApplicationPositions(keyword);
                    if (list != null) {
                        request.setAttribute("list", list);
                        request.getRequestDispatcher("views/job/position/positionlist.jsp").forward(request, response);
                    } else {
                        log("SEARCH POSITION FAILED!");
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }
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

                    int result = positionDAO.addApplicationPosition(dto);
                    if (result == 1) {
                        msg = "Thêm Vị Trí Thành Công";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    } else {
                        // ko add duoc se gui error mesage
                        msg = "Thêm Vị Trí Thất Bại";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }

                    break;
                case "position-detail":
                    int id = Integer.parseInt(request.getParameter("id"));
                    ApplicationPositionDTO position = positionDAO.loadApplicationPositions(id);
                    ArrayList<ApplicationPostDTO> postList = postDAO.listByPosition(id);

                    if (position != null && postList != null) {
                        request.setAttribute("position", position);
                        request.setAttribute("postList", postList);
                        request.getRequestDispatcher("views/job/position/position-detail.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }

                    break;
                case "edit-position":
                    id = Integer.parseInt(request.getParameter("id"));
                    name = request.getParameter("name");
                    description = request.getParameter("description");
                    quantity = Integer.parseInt(request.getParameter("quantity"));
                    date = Date.valueOf(request.getParameter("date"));
                    status = Integer.parseInt(request.getParameter("status"));

                    dto = new ApplicationPositionDTO();
                    dto.setPositionID(id);
                    dto.setPositionName(name);
                    dto.setPositionDescription(description);
                    dto.setHiringQuantity(quantity);
                    dto.setCreatedDate(date);
                    dto.setStatusID(status);

                    result = positionDAO.updateApplicationPosition(dto);
                    if (result == 1) {
                        msg = "Cập Nhật Vị Trí Thành Công";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-detail&id="+ id + "").forward(request, response);
                    } else {
                        msg = "Cập Nhật Vị Trí Thất Bại";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }
                    break;
                case "staff-post-detail":
                    int positionID = Integer.parseInt(request.getParameter("positionID"));
                    position = positionDAO.loadApplicationPositions(positionID);
                    int postID = Integer.parseInt(request.getParameter("postID"));
                    ApplicationPostDTO post = postDAO.loadApplicationPost(postID);

                    if (position != null && post != null) {
                        request.setAttribute("position", position);
                        request.setAttribute("post", post);
                        request.getRequestDispatcher("views/job/post/staff-post-detail.jsp").forward(request, response);
                    } else {
                        request.getRequestDispatcher("./job?action=position-list").forward(request, response);
                    }
                    break;
                // NOT FINISHED
                case "edit-post":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    String postDescription = request.getParameter("postDescription");
                    String salary = request.getParameter("salary");
                    int hiringQuantity = Integer.parseInt(request.getParameter("hiringQuantity"));
                    Date createdDate = Date.valueOf(request.getParameter("createdDate"));
                    Date startDate = Date.valueOf(request.getParameter("startDate"));
                    Date expiredDate = Date.valueOf(request.getParameter("expiredDate"));
                    int formID = Integer.parseInt(request.getParameter("formID"));
                    int statusID = Integer.parseInt(request.getParameter("statusID"));
                    positionID = Integer.parseInt(request.getParameter("positionID"));
                    
                    ApplicationPostDTO editingPost = new ApplicationPostDTO();
                    editingPost.setPostID(postID);
                    editingPost.setPostDescription(postDescription);
                    editingPost.setSalary(salary);
                    editingPost.setHiringQuantity(hiringQuantity);
                    editingPost.setCreatedDate(createdDate);
                    editingPost.setStartDate(startDate);
                    editingPost.setExpiredDate(expiredDate);
                    editingPost.setFormID(formID);
                    editingPost.setStatusID(statusID);
                    editingPost.setPositionID(positionID);
                    
                    result = postDAO.updatePost(editingPost);
                    if(result == 1){
                        msg = "Cập Nhật Bài Đăng Thành Công";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                        
                    }else{
                        msg = "Cập Nhật Bài Đăng Thất Bại";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./job?action=staff-post-detail&positionID=" + positionID + "&postID=" + postID).forward(request, response);
                    }
                    
                    break;
                // NOT FINISHED
                case "edit-post-requirements":
                   
                    break;
                // NOT FINISHED
                case "edit-post-skills":
                   
                    break;
                // NOT FINISHED
                case "edit-post-benefits":
                   
                    break;
                // NOT FINISHED
                case "edit-post-stages":
                   
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
