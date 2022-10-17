/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.cv;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.Date;
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

    public void saveCV(String firstName, String lastName, String avatar, Date dob, String introduction, String email, String phoneNumber, String address, String city, String gender, int userID, ArrayList skills, ArrayList interests, ArrayList certificates, ArrayList achivements, ArrayList experiences, ArrayList languages, ArrayList educations, ArrayList socialMedias) {
        String sql = "INSERT INTO CV(FirstName, "
                + "LastName, "
                + "Avatar, "
                + "Dob, "
                + "Introduction, "
                + "Email, "
                + "PhoneNumber, "
                + "[Address], "
                + "City, "
                + "Gender, "
                + "UserID) "
                + " VALUES (?,?,?,?,?,?,?,?,?,?,?) ";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, avatar);
            ps.setDate(4, dob);
            ps.setString(5, introduction);
            ps.setString(6, email);
            ps.setString(7, phoneNumber);
            ps.setString(8, address);
            ps.setString(9, city);
            int genderID = 0;
            switch (gender.toLowerCase()) {
                case "female":
                    genderID = 2;
                    break;
                case "other":
                    genderID = 3;
                    break;
                default:
                    genderID = 1;
                    break;
            }
            ps.setInt(10, genderID);
            ps.setInt(11, userID);

//            int CVID = getHighestCVID();
//            saveSkill(skills, CVID);
//            saveInterest(interests, CVID);
//            saveCertificate(certificates, CVID);
//            saveAchievement(achivements, CVID);
        } catch (SQLException e) {
            System.out.print("CV save error: " + e.getMessage());
        }
    }

    public int getHighestCVID() {
        String sql = "SELECT MAX(CVID) AS CVID FROM CV ";
        try {
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                CVDTO cv = new CVDTO();
                cv.setCVID(rs.getInt("CVID"));
                return cv.getCVID();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return -1;
    }

    public void saveSkill(ArrayList<SkillDTO> skillList, int CVID) {
        String sql = "INSERT INTO CV_Skill( "
                + "SkillName, "
                + "SkillDescription, "
                + "CVID "
                + ") VALUES (?,?,?) ";
        try {
            for (SkillDTO x : skillList) {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, x.getSkillName());
                ps.setString(2, x.getSkillDescription());
                ps.setInt(3, CVID);

                ps.execute();
            }

        } catch (SQLException e) {
            System.out.print("CV save error: " + e.getMessage());
        }
    }

    public void saveInterest(ArrayList<InterestDTO> interestList, int CVID) {
        String sql = "INSERT INTO CV_Interest( "
                + "InterestName, "
                + "CVID "
                + ") VALUES (?,?) ";
        try {
            for (InterestDTO x : interestList) {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, x.getInterestName());
                ps.setInt(2, CVID);

                ps.execute();
            }

        } catch (SQLException e) {
            System.out.print("CV save error: " + e.getMessage());
        }
    }

    public void saveCertificate(ArrayList<CertificateDTO> certificateList, int CVID) {
        String sql = "INSERT INTO CV_Certificate( "
                + "CertificateName, "
                + "CertificateLink, "
                + "CVID "
                + ") VALUES (?,?,?) ";
        try {
            for (CertificateDTO x : certificateList) {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, x.getCertificateName());
                ps.setString(2, x.getCertificateLink());
                ps.setInt(3, CVID);

                ps.execute();
            }

        } catch (SQLException e) {
            System.out.print("CV save error: " + e.getMessage());
        }
    }

    public void saveAchievement(ArrayList<AchievementDTO> achievementList, int CVID) {
        String sql = "INSERT INTO CV_Achievement( "
                + "AchievementName, "
                + "AchievementDescription, "
                + "AchievementLink, "
                + "CVID "
                + ") VALUES (?,?,?,?) ";
        try {
            for (AchievementDTO x : achievementList) {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, x.getAchievementName());
                ps.setString(2, x.getAchievementDescription());
                ps.setString(3, x.getAchievementLink());
                ps.setInt(4, CVID);

                ps.execute();
            }

        } catch (SQLException e) {
            System.out.print("CV save error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        CVDAO dao = new CVDAO();
//        CVDTO dto;
//        dto = dao.loadCV(2);
//        System.out.println(dto.toString());

//        ArrayList<SkillDTO> skillList = new ArrayList<>();
//        skillList.add(new SkillDTO(0, "test skill 1", "test skill description", 0));
//        skillList.add(new SkillDTO(0, "test skill 2", "test skill description", 0));
//        ArrayList<InterestDTO> interestList = new ArrayList<>();
//        interestList.add(new InterestDTO(0, "test 1", 0));
//        interestList.add(new InterestDTO(0, "test 2", 0));
//        ArrayList<CertificateDTO> certificateList = new ArrayList<>();
//        certificateList.add(new CertificateDTO(0, "test 1", "test 1", 0));
//        certificateList.add(new CertificateDTO(0, "test 2", "test 2", 0));
//        ArrayList<AchievementDTO> achievementList = new ArrayList<>();
//        achievementList.add(new AchievementDTO(0, "test 1", "test 1", "test 1", 0));
//        achievementList.add(new AchievementDTO(0, "test 2", "test 2", "test 2", 0));
        
        dao.saveCV("test 1", "test 2", "test 3", Date.valueOf("2011-04-01"), "test 5", "test3@gmail.com", "test 7", "test 8", "test 9", "male", 1, null, null, null, null, null, null, null, null);

//        System.out.println(dao.getHighestCVID());
    }
}
