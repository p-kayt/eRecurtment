/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.application.ApplicationDAO;
import com.t404notfound.erecruitment.bean.application.ApplicationDTO;
import com.t404notfound.erecruitment.bean.applicationposition.ApplicationPositionDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDAO;
import com.t404notfound.erecruitment.bean.applicationpost.ApplicationPostDTO;
import com.t404notfound.erecruitment.bean.cv.CVDAO;
import com.t404notfound.erecruitment.bean.cv.CVDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
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
            int result = 0;
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");
            CVDAO cvDAO = new CVDAO();
            CVDTO cv = new CVDTO();
            ApplicationDAO appDAO = new ApplicationDAO();
            Date currentDate;
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
                    if (workingForm == 2) {
                        formID = " and post.FormID in (1, 2, 3)";
                    } else if (workingForm == 3) {
                        formID = " and post.FormID in (4, 5, 6)";
                    }

                    String sortByDate = "";
                    if (dateOrder == 1) {
                        sortByDate = " order by ExpiredDate desc";
                    } else {
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
                    ApplicationPostDTO post = postDAO.loadApplicationPostWithName(postID);
                    request.setAttribute("post", post);
                    request.getRequestDispatcher("views/job/post/job-detail.jsp").forward(request, response);
                    break;
                case "apply-for-post":
                    postID = Integer.parseInt(request.getParameter("postID"));
                    post = postDAO.loadApplicationPostWithName(postID);
                    // Check if user is LOGGED-IN or not
                    if (user == null) {
                        // User is NOT LOGGED-IN. 
                        msg = "Bạn Cần Phải Đăng Nhập Để Ứng Tuyển Vào Vị Trí";
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("./login").forward(request, response);
                    } // Check if user is a CANDIDATE or not
                    else {
                        // User is NOT a CANDIDATE
                        if (user.getUserRole() != 1) {
                            msg = "Bạn Không Phải Là Ứng Viên - Chỉ Có Ứng Viên Mới Được Quyền Ứng Tuyển Vào Các Vị Trí";
                            request.setAttribute("msg", msg);
                            request.getRequestDispatcher("./profile").forward(request, response);
                        } // User is a CANDIDATE. Check if he/she has create a CV
                        else {
                            cv = cvDAO.loadCVByUserID(user.getUserID());
                            // User has NOT create a CV
                            if (cv == null) {
                                msg = "Bạn Chưa Tạo CV - Ứng Viên Cần Tạo CV Để Ứng Tuyển Vào Các Vị Trí";
                                request.setAttribute("msg", msg);
                                request.getRequestDispatcher("./profile").forward(request, response);
                            } // Check if user HAS ALREADY APPLIED for the post
                            else {
                                boolean isApplying = appDAO.isUserApplying(user.getUserID(), postID);
                                // User HAS ALREADY APPLIED for the post
                                if (isApplying == true) {
                                    msg = "Bạn Đã Ứng Tuyển Cho Vị Trí Này - Không Thể Ứng Tuyển Nhiều Lần Cho Cùng 1 Bài Đăng Công Việc";
                                    request.setAttribute("msg", msg);
                                    request.setAttribute("post", post);
                                    request.getRequestDispatcher("views/job/post/job-detail.jsp").forward(request, response);
                                } else {
                                    // If post Status IS NOT HIRING (INACTIVE, PENDING, CLOSE)
                                    if (post.getStatusID() != 3) {
                                        if (post.getStatusID() == 1) {
                                            msg = "Ứng Tuyển Thất Bại - Bài Đăng Đang Ở Trạng Thái InActive";
                                            request.setAttribute("msg", msg);
                                            request.setAttribute("post", post);
                                            request.getRequestDispatcher("views/job/post/job-detail.jsp").forward(request, response);
                                        } else if (post.getStatusID() == 2) {
                                            msg = "Ứng Tuyển Thất Bại - Bài Đăng Đang Ở Trạng Thái Đang Chờ";
                                            request.setAttribute("msg", msg);
                                            request.setAttribute("post", post);
                                            request.getRequestDispatcher("views/job/post/job-detail.jsp").forward(request, response);
                                        } else {
                                            msg = "Ứng Tuyển Thất Bại - Bài Đăng Đang Ở Trạng Thái Đã Đóng";
                                            request.setAttribute("msg", msg);
                                            request.setAttribute("post", post);
                                            request.getRequestDispatcher("views/job/post/job-detail.jsp").forward(request, response);
                                        }
                                    } // All user conditions have been met
                                    // LOGGED-IN, IS A CANDIDATE, HAS CREATED A CV, DOES NOT APPLY FOR THIS POST YET
                                    // Add user application for the post and redirect to user's application list with anouncement
                                    else {
                                        int initialStage = post.getStageList().get(0).getId();
                                        currentDate = new Date(Calendar.getInstance().getTime().getTime());
                                        ApplicationDTO application = new ApplicationDTO(0, currentDate, 1, initialStage, user.getUserID(), postID);
                                        result = appDAO.addApplication(application);
                                        if (result == 1) {
                                            msg = "Ứng Tuyển Công Việc Thành Công - Xem Công Việc Ðã Ứng Tuyển Của Ứng Viên Ở Danh Sách Ứng Tuyển";
                                            request.setAttribute("msg", msg);
                                            request.setAttribute("post", post);
                                            request.getRequestDispatcher("views/job/post/job-detail.jsp").forward(request, response);
                                        } else {
                                            msg = "Đã Có Lỗi Xảy Ra - Vui Lòng Thử Lại Ứng Tuyển Vị Trí";
                                            request.setAttribute("msg", msg);
                                            request.setAttribute("post", post);
                                            request.getRequestDispatcher("views/job/post/job-detail.jsp").forward(request, response);
                                        }
                                    }
                                }
                            }
                        }
                    }
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
