/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Huu Minh
 */
public class CVDAO {

    public CVDTO loadCV(int CVID) {
        String sql = "SELECT FirstName, "
                + "LastName, "
                + "Avatar, "
                + "Dob, "
                + "Introduction, "
                + "Email, "
                + "PhoneNumber, "
                + "[Address], "
                + "City, "
                + "GenderName, "
                + "UserID FROM CV "
                + "INNER JOIN Gender ON Gender = GenderID "
                + "WHERE CVID = ?";
        try {
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                CVDTO cv = new CVDTO();
                cv.setCVID(CVID);
                cv.setFirstName(rs.getString("FirstName"));
                cv.setLastName(rs.getString("LastName"));
                cv.setAvatar(rs.getString("Avatar"));
                cv.setDob(rs.getDate("Dob"));
                cv.setIntroduction(rs.getString("Introduction"));
                cv.setEmail(rs.getString("Email"));
                cv.setPhoneNumber(rs.getString("PhoneNumber"));
                cv.setAddress(rs.getString("Address"));
                cv.setCity(rs.getString("City"));
                cv.setGender(rs.getString("GenderName"));
                cv.setUserID(rs.getInt("UserID"));
                cv.setSkills(loadSkill(CVID));
                cv.setInterests(loadInterest(CVID));
                cv.setCertificates(loadCertificate(CVID));
                cv.setAchievements(loadAchievement(CVID));
                cv.setExperiences(loadExperience(CVID));
                cv.setLanguages(loadLanguage(CVID));
                cv.setEducations(loadEducation(CVID));
                cv.setSocialMedias(loadSocialMedia(CVID));
                return cv;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private ArrayList<SkillDTO> loadSkill(int CVID) {
        String sql = "SELECT SkillID, "
                + "SkillName, "
                + "SkillDescription, "
                + "CVID "
                + "FROM CV_Skill "
                + "WHERE CVID = ?";
        try {
            ArrayList<SkillDTO> list = new ArrayList<>();
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                SkillDTO dto = new SkillDTO();
                dto.setSkillID(rs.getInt("SkillID"));
                dto.setSkillName(rs.getString("SkillName"));
                dto.setSkillDescription("SkillDescription");
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    private ArrayList<InterestDTO> loadInterest(int CVID) {
        String sql = "SELECT InterestID, "
                + "InterestName, "
                + "CVID "
                + "FROM CV_Interest "
                + "WHERE CVID = ?";
        try {
            ArrayList<InterestDTO> list = new ArrayList<>();
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                InterestDTO dto = new InterestDTO();
                dto.setInterestID(rs.getInt("InterestID"));
                dto.setInterestName(rs.getString("InterestName"));
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ArrayList<CertificateDTO> loadCertificate(int CVID) {
        String sql = "SELECT CertificateID, "
                + "CertificateName, "
                + "CertificateLink, "
                + "CVID "
                + "FROM CV_Certificate "
                + "WHERE CVID = ?";
        try {
            ArrayList<CertificateDTO> list = new ArrayList<>();
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                CertificateDTO dto = new CertificateDTO();
                dto.setCertificateID(rs.getInt("CertificateID"));
                dto.setCertificateName(rs.getString("CertificateName"));
                dto.setCertificateLink("CertificateLink");
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ArrayList<AchievementDTO> loadAchievement(int CVID) {
        String sql = "SELECT AchievementID, AchievementName, AchievementDescription, AchievementLink, CVID FROM CV_Achievement WHERE CVID = ?;";
        try {
            ArrayList<AchievementDTO> list = new ArrayList<>();
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                AchievementDTO dto = new AchievementDTO();
                dto.setAchievementID(rs.getInt("AchievementID"));
                dto.setAchievementName(rs.getString("AchievementName"));
                dto.setAchievementDescription(rs.getString("AchievementDescription"));
                dto.setAchievementLink(rs.getString("AchievementLink"));
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ArrayList<ExperienceDTO> loadExperience(int CVID) {
        String sql = "SELECT ExperienceID, "
                + "JobTitle, "
                + "OrganizationName, "
                + "ExperienceDescription, "
                + "ExperienceDuration, "
                + "CVID "
                + "FROM CV_Experience "
                + "WHERE CVID = ?;";
        try {
            ArrayList<ExperienceDTO> list = new ArrayList<>();
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ExperienceDTO dto = new ExperienceDTO();
                System.out.println(rs.toString());
                dto.setExperienceID(rs.getInt("ExperienceID"));
                dto.setJobTitle(rs.getString("JobTitle"));
                dto.setExperienceDescription(rs.getString("ExperienceDescription"));
                dto.setExperienceDuration(rs.getString("ExperienceDuration"));
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ArrayList<LanguageDTO> loadLanguage(int CVID) {
        String sql = "SELECT LanguageID, "
                + "LanguageName, "
                + "LanguageDescription, "
                + "CVID "
                + "FROM CV_Language "
                + "WHERE CVID = ?;";
        try {
            ArrayList<LanguageDTO> list = new ArrayList<>();
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                LanguageDTO dto = new LanguageDTO();
                System.out.println(rs.toString());
                dto.setLanguageID(rs.getInt("LanguageID"));
                dto.setLanguageName(rs.getString("LanguageName"));
                dto.setLanguageDescription(rs.getString("LanguageDescription"));
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ArrayList<EducationDTO> loadEducation(int CVID) {
        String sql = "SELECT EducationID, "
                + "EducationName, "
                + "OrganizationName, "
                + "StatusName "
                + "FROM CV_Education "
                + "JOIN EducationStatus "
                + "ON CV_Education.StatusID = EducationStatus.StatusID "
                + "WHERE CVID = ?;";
        try {
            ArrayList<EducationDTO> list = new ArrayList<>();
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                EducationDTO dto = new EducationDTO();
                System.out.println(rs.toString());
                dto.setEducationID(rs.getInt("EducationID"));
                dto.setEducationName(rs.getString("EducationName"));
                dto.setOrganizationName(rs.getString("OrganizationName"));
                dto.setStatus(rs.getString("StatusName"));
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ArrayList<SocialMediaDTO> loadSocialMedia(int CVID) {
        String sql = "SELECT SocialMediaID, "
                + "SocialMediaLink, "
                + "PlatformName "
                + "FROM CV_SocialMedia "
                + "JOIN [Platform] "
                + "ON CV_SocialMedia.PlatformID = [Platform].PlatformID "
                + "WHERE CVID = ?;";
        try {
            ArrayList<SocialMediaDTO> list = new ArrayList<>();
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                SocialMediaDTO dto = new SocialMediaDTO();
                System.out.println(rs.toString());
                dto.setSocialMediaID(rs.getInt("SocialMediaID"));
                dto.setSocialMediaLink(rs.getString("SocialMediaLink"));
                dto.setPlatformName(rs.getString("PlatformName"));
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        CVDAO dao = new CVDAO();
        CVDTO dto;
        dto = dao.loadCV(1);
        System.out.println(dto.toString());

//        ArrayList<EducationDTO> list = new ArrayList<>();
//        list = dao.loadEducation(1);
//        System.out.println(list);
    }
}
