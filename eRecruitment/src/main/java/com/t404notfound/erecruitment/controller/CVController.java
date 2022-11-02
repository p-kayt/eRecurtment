/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.cv.CVDAO;
import com.t404notfound.erecruitment.bean.cv.CVDTO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Huu Minh
 */
@WebServlet(name = "CVController", urlPatterns = {"/cv"})
@javax.servlet.annotation.MultipartConfig
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

        int CVID = 0;
        String introduction;
        String firstName;
        String lastName;
        String gender;
        String dob;
        String email;
        String phoneNumber;
        String address;
        String city;

        CVDAO cvdao = new CVDAO();
        CVDTO cvdto = new CVDTO();
        if (user != null) {

            switch (action) {
                case "createMyCV":
                    request.setAttribute("action", "createCV");
                    request.getRequestDispatcher("/views/cv/cv-write.jsp").forward(request, response);
                    break;
                case "createCV":

                    CVID = 0;
                    if (request.getParameter("CVID") != null) {
                        CVID = Integer.parseInt(request.getParameter("CVID"));
                    }
                    introduction = request.getParameter("introduction");
                    firstName = request.getParameter("firstName");
                    lastName = request.getParameter("lastName");
                    gender = request.getParameter("gender");
                    dob = request.getParameter("date");
                    email = request.getParameter("email");
                    phoneNumber = request.getParameter("phoneNumber");
                    address = request.getParameter("address");
                    city = request.getParameter("city");
                    cvdto = new CVDTO(0, firstName, lastName, dob, introduction, email, phoneNumber, address, city, gender, user.getUserID(), null, null, null, null, null, null, null, null);
                    cvdao.saveCV(cvdto);
                    cvdto = cvdao.loadCVByUserID(user.getUserID());
                    request.setAttribute("cv", cvdto);
                    request.getRequestDispatcher("/profile").forward(request, response);
                    break;
                case "editMyCV":
                    request.setAttribute("action", "editCV");
                    cvdto = cvdao.loadCVByUserID(user.getUserID());
                    request.setAttribute("cv", cvdto);
                    request.getRequestDispatcher("/views/cv/cv-write.jsp").forward(request, response);
                    break;
                case "editCV":
                    CVID = 0;
                    if (request.getParameter("CVID") != null) {
                        CVID = Integer.parseInt(request.getParameter("CVID"));
                    }
                    introduction = request.getParameter("introduction");
                    firstName = request.getParameter("firstName");
                    lastName = request.getParameter("lastName");
                    gender = request.getParameter("gender");
                    dob = request.getParameter("date");
                    email = request.getParameter("email");
                    phoneNumber = request.getParameter("phoneNumber");
                    address = request.getParameter("address");
                    city = request.getParameter("city");
                    cvdto = new CVDTO(CVID, firstName, lastName, dob, introduction, email, phoneNumber, address, city, gender, user.getUserID(), null, null, null, null, null, null, null, null);
                    cvdao.updateCV(cvdto);
                    cvdto = cvdao.loadCVByUserID(user.getUserID());
                    request.setAttribute("cv", cvdto);
                    request.getRequestDispatcher("/profile").forward(request, response);
                    
                    break;
                case "updateAvatar":

//                    request.setAttribute("infor", "Hello");
                    //Lấy đường dẫn tương đối
                    String dir;

                    dir = request.getServletContext().getRealPath("homepage.jsp");
                    String path[] = dir.split("eRecruitment");
                    dir = path[0];

                    dir += "\\image";
                    File img = new File(dir);
                    if (!img.exists()) {
                        img.mkdir();
                    }
                    dir += "\\cv_avatar";
                    File avatar = new File(dir);
                    if (!avatar.exists()) {
                        avatar.mkdir();
                    }
                    dir += "\\" + user.getFirstName().trim() + user.getLastName().trim();
                    File image = new File(dir);
                    if (!image.exists()) {
                        image.mkdir();
                    }
                    //Lấy đường dẫn tương đối

                    //tạo file .png và ghi đè img vào
                    String fileName = "cv_avatar";
                    File file = File.createTempFile(fileName, ".png", image);

                    try {
                        Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
                        try ( InputStream input = filePart.getInputStream()) {
                            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    //tạo file .png và ghi đè img vào

                    //rename img
                    Path source = Paths.get(file.getParentFile() + "\\" + file.getName());

                    Files.move(source, source.resolveSibling("cv_avatar.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                    //rename img

                    String url = "image/cv_avatar/" + user.getFirstName().trim() + user.getLastName().trim() + "/cv_avatar.png";
                    if (cvdao.changeAvatar(url, user.getUserID())) {
                        cvdto.setAvatar(url);
                        cvdto = cvdao.loadCVByUserID(user.getUserID());
                        request.setAttribute("cv", cvdto);
                        request.getRequestDispatcher("/profile").forward(request, response);
                    }
                    break;
                default:
                    request.getRequestDispatcher("/home").forward(request, response);
                    break;
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
