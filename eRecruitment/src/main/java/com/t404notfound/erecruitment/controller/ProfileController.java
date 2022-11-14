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
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author MINH TRI
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
@javax.servlet.annotation.MultipartConfig
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
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        String action = request.getParameter("action");

        //check case user is null
        if (user != null) {

            UserDAO dao = new UserDAO();

            if (action != null) {
                if (action.equalsIgnoreCase("changePass")) {
                    String oldPassword = request.getParameter("oldPassword");
                    String newPassword = request.getParameter("newPassword");
                    //check case password is null
                    if (oldPassword == null || oldPassword.equals("")) {
                        request.setAttribute("passwordErrMess1", "Mật khẩu không được để trống");
                        request.setAttribute("newPassword", newPassword);
                    } else {
                        //check case password is null
                        if (newPassword == null || newPassword.equals("")) {
                            request.setAttribute("passwordErrMess2", "Mật khẩu không được để trống");
                            request.setAttribute("oldPassword", oldPassword);
                        } else {
                            //checkPassword using login function 
                            UserDTO checkPass = dao.login(user.getEmail(), oldPassword);
                            if (checkPass != null) {
                                boolean checkChangePass = dao.changePass(user.getUserID(), newPassword);
                                if (checkChangePass) {
                                    user.setPassword(newPassword);
                                    session.setAttribute("user", user);
                                    request.setAttribute("changePassMess", "Thay đổi mật khẩu thành công.");
                                }
                            } else {
                                request.setAttribute("passwordErrMess1", "Mật khẩu không chính xác.");
                                request.setAttribute("oldPassword", oldPassword);
                                request.setAttribute("newPassword", newPassword);
                            }
                        }
                    }
                } else if (action.equalsIgnoreCase("updateProfile")) {
                    String firstName = request.getParameter("firstName");
                    String lastName = request.getParameter("lastName");
                    String gender = request.getParameter("gender");
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
                        request.setAttribute("updateMess", "Cập nhật hồ sơ thành công");
                    }
                } else if (action.equalsIgnoreCase("updateAvatar")) {

                    //Lấy đường dẫn tương đối
                    String dir;

                    dir = request.getServletContext().getRealPath("");
                    String path[] = dir.split("eRecruitment");
                    dir = path[0];

                    dir += "\\image";
                    File img = new File(dir);
                    if (!img.exists()) {
                        img.mkdir();
                    }
                    dir += "\\avatar";
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

                    Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">

                    if (filePart.getSize() > 0) {
                        //tạo file .png và ghi đè img vào
                        String fileName = "avatar";
                        File file = File.createTempFile(fileName, ".png", image);
                        //tạo file .png và ghi đè img vào
                        try {

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

                        Files.move(source, source.resolveSibling("avatar.png"),
                                StandardCopyOption.REPLACE_EXISTING);
                        //rename img
                    }
//                request.setAttribute("path", file.getAbsolutePath());
                    if (user.getAvatarURL() != null && user.getAvatarURL().contains("image/avatar")) {
                        String url = "image/avatar/" + user.getFirstName().trim() + user.getLastName().trim() + "/avatar.png";
                        if (dao.changeAvatar(url, user.getUserID())) {
                            user.setAvatarURL(url);
                            session.setAttribute("user", user);
                        }
                    }

                }
            }
//            CVDAO cvdao = new CVDAO();
//            CVDTO cvdto = cvdao.loadCVByUserID(user.getUserID());
//            session.setAttribute("cv", user);
            //System.out.println(cvdto.toString());
        }

        CVDAO cvdao = new CVDAO();
        CVDTO cvdto = new CVDTO();
        cvdto = cvdao.loadCVByUserID(user.getUserID());
        request.setAttribute("cv", cvdto);

        // Hoa: message for Applying for a job
        // But user role is not a CANDIDATE
        String msg = (String) request.getAttribute("msg");
        request.setAttribute("msg", msg);
        //
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
