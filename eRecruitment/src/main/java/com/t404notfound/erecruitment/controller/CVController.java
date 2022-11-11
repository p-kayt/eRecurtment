/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.t404notfound.erecruitment.controller;

import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import com.t404notfound.erecruitment.bean.cv.AchievementDTO;
import com.t404notfound.erecruitment.bean.cv.CVDAO;
import com.t404notfound.erecruitment.bean.cv.CVDTO;
import com.t404notfound.erecruitment.bean.cv.CertificateDTO;
import com.t404notfound.erecruitment.bean.cv.EducationDTO;
import com.t404notfound.erecruitment.bean.cv.ExperienceDTO;
import com.t404notfound.erecruitment.bean.cv.InterestDTO;
import com.t404notfound.erecruitment.bean.cv.LanguageDTO;
import com.t404notfound.erecruitment.bean.cv.SkillDTO;
import com.t404notfound.erecruitment.bean.cv.SocialMediaDTO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Date;
import java.util.ArrayList;
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
        int gender;
        String dob;
        String email;
        String phoneNumber;
        String address;
        String city;

        CVDAO cvdao = new CVDAO();
        CVDTO cvdto = new CVDTO();
        if (user != null) {

            if (action.equalsIgnoreCase("viewCV")) {
                cvdto = cvdao.loadCVByUserID(user.getUserID());
                request.setAttribute("cv", cvdto);
                request.getRequestDispatcher("/views/cv/cv-read.jsp").forward(request, response);
            }
            if (action.equalsIgnoreCase("viewCVOfACandidate")) {
                int userID = Integer.parseInt(request.getParameter("userID").toString());
                cvdto = cvdao.loadCVByUserID(userID);
                request.setAttribute("cv", cvdto);
                request.getRequestDispatcher("/views/cv/cv-read.jsp").forward(request, response);
            }
            if (action.equalsIgnoreCase("createMyCV")) {
                request.setAttribute("action", "createCV");
                request.getRequestDispatcher("/views/cv/cv-write.jsp").forward(request, response);
            }
            if (action.equalsIgnoreCase("createCV")) {

                CVID = 0;

                introduction = request.getParameter("introduction");
                firstName = request.getParameter("firstName");
                lastName = request.getParameter("lastName");
                gender = Integer.parseInt(request.getParameter("gender"));
                dob = request.getParameter("date");
                email = request.getParameter("email");
                phoneNumber = request.getParameter("phoneNumber");
                address = request.getParameter("address");
                city = request.getParameter("city");

                //Skill
                ArrayList<SkillDTO> skills = new ArrayList<>();

                String[] skillNames = request.getParameterValues("skillName");
                String[] skillDescriptions = request.getParameterValues("skillDescription");
                try {
                    for (int i = 0; i < skillNames.length; i++) {
                        skills.add(new SkillDTO(0, skillNames[i], skillDescriptions[i], CVID));
                    }
                } catch (Exception e) {

                }

                //Education
                ArrayList<EducationDTO> educations = new ArrayList<>();
                String[] educationNames = request.getParameterValues("educationName");
                String[] organizationName = request.getParameterValues("organizationName");
                String[] status = request.getParameterValues("status");
                try {
                    for (int i = 0; i < educationNames.length; i++) {
                        educations.add(new EducationDTO(0, educationNames[i], organizationName[i], Integer.parseInt(status[i]), CVID));
                    }
                } catch (Exception e) {

                }

                //Interest
                ArrayList<InterestDTO> interests = new ArrayList<>();
                String[] interestNames = request.getParameterValues("interestName");
                try {
                    for (int i = 0; i < interestNames.length; i++) {
                        interests.add(new InterestDTO(0, interestNames[i], CVID));
                    }
                } catch (Exception e) {

                }

                //Experience
                ArrayList<ExperienceDTO> experiences = new ArrayList<>();
                String[] jobTitle = request.getParameterValues("jobTitle");
                String[] experienceOrganizationName = request.getParameterValues("experienceOrganizationName");
                String[] experienceDescription = request.getParameterValues("experienceDescription");
                String[] experienceDuration = request.getParameterValues("experienceDuration");
                try {
                    for (int i = 0; i < jobTitle.length; i++) {
                        experiences.add(new ExperienceDTO(CVID, jobTitle[i], experienceOrganizationName[i], experienceDescription[i], experienceDuration[i], CVID));
                    }

                } catch (Exception e) {

                }

                //Language
                ArrayList<LanguageDTO> languages = new ArrayList<>();
                String[] languageNames = request.getParameterValues("languageName");
                String[] languageDescriptions = request.getParameterValues("languageDescription");
                try {
                    for (int i = 0; i < languageNames.length; i++) {
                        languages.add(new LanguageDTO(0, languageNames[i], languageDescriptions[i], CVID));
                    }
                } catch (Exception e) {

                }

                //Certificate
                ArrayList<CertificateDTO> certificates = new ArrayList<>();
                String[] certificateNames = request.getParameterValues("certificateName");
                String[] certificateLinks = request.getParameterValues("certificateLink");
                try {
                    for (int i = 0; i < certificateNames.length; i++) {
                        certificates.add(new CertificateDTO(0, certificateNames[i], certificateLinks[i], CVID));
                    }
                } catch (Exception e) {

                }

                //Achievement
                ArrayList<AchievementDTO> achivements = new ArrayList<>();
                String[] achivementNames = request.getParameterValues("achivementName");
                String[] achievementDescriptions = request.getParameterValues("achievementDescription");
                String[] achivementLink = request.getParameterValues("achivementLink");
                try {
                    for (int i = 0; i < achivementNames.length; i++) {
                        achivements.add(new AchievementDTO(0, achivementNames[i], achievementDescriptions[i], achivementLink[i], CVID));
                    }
                } catch (Exception e) {

                }

                //SocialMedia
                ArrayList<SocialMediaDTO> socialMedias = new ArrayList<>();
                String[] platformIDs = request.getParameterValues("platformID");
                String[] socialMediaLink = request.getParameterValues("socialMediaLink");
                try {
                    for (int i = 0; i < platformIDs.length; i++) {
                        socialMedias.add(new SocialMediaDTO(0, socialMediaLink[i], Integer.parseInt(platformIDs[i]), CVID));
                    }
                } catch (Exception e) {

                }

                cvdto = new CVDTO(CVID, firstName, lastName, dob, introduction, email, phoneNumber, address, city, gender, user.getUserID(), skills, interests, certificates, achivements, experiences, languages, educations, socialMedias);
                cvdao.saveCV(cvdto);

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

                Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
                //tạo file .png và ghi đè img vào
                String fileName = "cv_avatar";
                File file = File.createTempFile(fileName, ".png", image);
                //tạo file .png và ghi đè img vào
                if (filePart.getSize() > 0) {
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

                    Files.move(source, source.resolveSibling("cv_avatar.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                    //rename img
                }

//                request.setAttribute("path", file.getAbsolutePath());
                String url = "image/cv_avatar/" + user.getFirstName().trim() + user.getLastName().trim() + "/cv_avatar.png";
                if (cvdao.changeAvatar(url, cvdto.getCVID())) {
                    cvdto.setAvatar(url);
                }

                cvdto = cvdao.loadCVByUserID(user.getUserID());
                request.setAttribute("cv", cvdto);
                request.getRequestDispatcher("/profile").forward(request, response);
            }
            if (action.equalsIgnoreCase("editMyCV")) {
                request.setAttribute("action", "editCV");
                cvdto = cvdao.loadCVByUserID(user.getUserID());
                request.setAttribute("cv", cvdto);
                request.getRequestDispatcher("/views/cv/cv-write.jsp").forward(request, response);
            }
            if (action.equalsIgnoreCase("editCV")) {
                CVID = 0;
                if (request.getParameter("CVID") != null) {
                    CVID = Integer.parseInt(request.getParameter("CVID"));
                }
                introduction = request.getParameter("introduction");
                firstName = request.getParameter("firstName");
                lastName = request.getParameter("lastName");
                gender = Integer.parseInt(request.getParameter("gender"));
                dob = request.getParameter("date");
                email = request.getParameter("email");
                phoneNumber = request.getParameter("phoneNumber");
                address = request.getParameter("address");
                city = request.getParameter("city");

                //Skill
                ArrayList<SkillDTO> skills = new ArrayList<>();

                String[] skillNames = request.getParameterValues("skillName");
                String[] skillDescriptions = request.getParameterValues("skillDescription");
                try {
                    for (int i = 0; i < skillNames.length; i++) {
                        skills.add(new SkillDTO(0, skillNames[i], skillDescriptions[i], CVID));
                    }
                } catch (Exception e) {

                }

                //Education
                ArrayList<EducationDTO> educations = new ArrayList<>();
                String[] educationNames = request.getParameterValues("educationName");
                String[] organizationName = request.getParameterValues("organizationName");
                String[] status = request.getParameterValues("status");
                try {
                    for (int i = 0; i < educationNames.length; i++) {
                        educations.add(new EducationDTO(0, educationNames[i], organizationName[i], Integer.parseInt(status[i]), CVID));
                    }
                } catch (Exception e) {

                }

                //Interest
                ArrayList<InterestDTO> interests = new ArrayList<>();
                String[] interestNames = request.getParameterValues("interestName");
                try {
                    for (int i = 0; i < interestNames.length; i++) {
                        interests.add(new InterestDTO(0, interestNames[i], CVID));
                    }
                } catch (Exception e) {

                }

                //Experience
                ArrayList<ExperienceDTO> experiences = new ArrayList<>();
                String[] jobTitle = request.getParameterValues("jobTitle");
                String[] experienceOrganizationName = request.getParameterValues("experienceOrganizationName");
                String[] experienceDescription = request.getParameterValues("experienceDescription");
                String[] experienceDuration = request.getParameterValues("experienceDuration");
                try {
                    for (int i = 0; i < jobTitle.length; i++) {
                        experiences.add(new ExperienceDTO(CVID, jobTitle[i], experienceOrganizationName[i], experienceDescription[i], experienceDuration[i], CVID));
                    }

                } catch (Exception e) {

                }

                //Language
                ArrayList<LanguageDTO> languages = new ArrayList<>();
                String[] languageNames = request.getParameterValues("languageName");
                String[] languageDescriptions = request.getParameterValues("languageDescription");
                try {
                    for (int i = 0; i < languageNames.length; i++) {
                        languages.add(new LanguageDTO(0, languageNames[i], languageDescriptions[i], CVID));
                    }
                } catch (Exception e) {

                }

                //Certificate
                ArrayList<CertificateDTO> certificates = new ArrayList<>();
                String[] certificateNames = request.getParameterValues("certificateName");
                String[] certificateLinks = request.getParameterValues("certificateLink");
                try {
                    for (int i = 0; i < certificateNames.length; i++) {
                        certificates.add(new CertificateDTO(0, certificateNames[i], certificateLinks[i], CVID));
                    }
                } catch (Exception e) {

                }

                //Achievement
                ArrayList<AchievementDTO> achivements = new ArrayList<>();
                String[] achivementNames = request.getParameterValues("achivementName");
                String[] achievementDescriptions = request.getParameterValues("achievementDescription");
                String[] achivementLink = request.getParameterValues("achivementLink");
                try {
                    for (int i = 0; i < achivementNames.length; i++) {
                        achivements.add(new AchievementDTO(0, achivementNames[i], achievementDescriptions[i], achivementLink[i], CVID));
                    }
                } catch (Exception e) {

                }

                //SocialMedia
                ArrayList<SocialMediaDTO> socialMedias = new ArrayList<>();
                String[] platformIDs = request.getParameterValues("platformID");
                String[] socialMediaLink = request.getParameterValues("socialMediaLink");
                try {
                    for (int i = 0; i < platformIDs.length; i++) {
                        socialMedias.add(new SocialMediaDTO(0, socialMediaLink[i], Integer.parseInt(platformIDs[i]), CVID));
                    }
                } catch (Exception e) {

                }

                cvdto = new CVDTO(CVID, firstName, lastName, dob, introduction, email, phoneNumber, address, city, gender, user.getUserID(), skills, interests, certificates, achivements, experiences, languages, educations, socialMedias);
                cvdao.updateCV(cvdto);

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

                Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
                //tạo file .png và ghi đè img vào
                String fileName = "cv_avatar";
                File file = File.createTempFile(fileName, ".png", image);
                //tạo file .png và ghi đè img vào
                if (filePart.getSize() > 0) {
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

                    Files.move(source, source.resolveSibling("cv_avatar.png"),
                            StandardCopyOption.REPLACE_EXISTING);
                    //rename img
                }

//                request.setAttribute("path", file.getAbsolutePath());
                String url = "image/cv_avatar/" + user.getFirstName().trim() + user.getLastName().trim() + "/cv_avatar.png";
                if (cvdao.changeAvatar(url, cvdto.getCVID())) {
                    cvdto.setAvatar(url);
                }

                cvdto = cvdao.loadCVByUserID(user.getUserID());
                request.setAttribute("cv", cvdto);
                request.getRequestDispatcher("/profile").forward(request, response);

            }

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
