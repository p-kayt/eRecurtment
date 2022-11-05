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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Huu Minh
 */
public class CVDAO {

    public boolean changeAvatar(String url, int CVID) {

        String sql = "UPDATE CV "
                + " SET Avatar = ? "
                + " WHERE CVID = ? ";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, url);
            ps.setInt(2, CVID);
            int rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error when execute query.");
            e.printStackTrace();
            e.getMessage();
        }

        return false;
    }

    public CVDTO loadCVByUserID(int userID) {
        System.out.println(userID);
        String sql = "SELECT CVID, "
                + "UserID FROM CV "
                + "INNER JOIN Gender ON Gender = GenderID "
                + "WHERE UserID = ?";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(userID));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                int CVID = rs.getInt("CVID");
                con.close();
                return loadCV(CVID);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

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
                + "Gender, "
                + "UserID FROM CV "
                + "INNER JOIN Gender ON Gender = GenderID "
                + "WHERE CVID = ?";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                CVDTO cv = new CVDTO();
                cv.setCVID(CVID);
                cv.setFirstName(rs.getString("FirstName"));
                cv.setLastName(rs.getString("LastName"));
                cv.setAvatar(rs.getString("Avatar"));
                cv.setDob(rs.getString("Dob"));
                cv.setIntroduction(rs.getString("Introduction"));
                cv.setEmail(rs.getString("Email"));
                cv.setPhoneNumber(rs.getString("PhoneNumber"));
                cv.setAddress(rs.getString("Address"));
                cv.setCity(rs.getString("City"));
                cv.setGender(rs.getInt("Gender"));
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
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                SkillDTO dto = new SkillDTO();
                dto.setSkillID(rs.getInt("SkillID"));
                dto.setSkillName(rs.getString("SkillName"));
                dto.setSkillDescription(rs.getString("SkillDescription"));
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
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
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
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                CertificateDTO dto = new CertificateDTO();
                dto.setCertificateID(rs.getInt("CertificateID"));
                dto.setCertificateName(rs.getString("CertificateName"));
                dto.setCertificateLink(rs.getString("CertificateLink"));
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
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
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
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ExperienceDTO dto = new ExperienceDTO();
                System.out.println(rs.toString());
                dto.setExperienceID(rs.getInt("ExperienceID"));
                dto.setJobTitle(rs.getString("JobTitle"));
                dto.setExperienceOrganizationName(rs.getString("OrganizationName"));
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
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
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
                + "StatusID, "
                + "CVID "
                + "FROM CV_Education "
                + "WHERE CVID = ?";
        try {
            ArrayList<EducationDTO> list = new ArrayList<>();
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                EducationDTO dto = new EducationDTO();
                System.out.println(rs.toString());
                dto.setEducationID(rs.getInt("EducationID"));
                dto.setEducationName(rs.getString("EducationName"));
                dto.setOrganizationName(rs.getString("OrganizationName"));
                dto.setStatus(rs.getInt("StatusID"));
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
                + "PlatformID "
                + "FROM CV_SocialMedia "
                + "WHERE CVID = ?;";
        try {
            ArrayList<SocialMediaDTO> list = new ArrayList<>();
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                SocialMediaDTO dto = new SocialMediaDTO();
                System.out.println(rs.toString());
                dto.setSocialMediaID(rs.getInt("SocialMediaID"));
                dto.setSocialMediaLink(rs.getString("SocialMediaLink"));
                dto.setPlatformID(rs.getInt("PlatformID"));
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

//==============================================================================
    public void saveCVByUserID(int userID, CVDTO cv) {
        String sql = "SELECT CVID, "
                + "UserID FROM CV "
                + "INNER JOIN Gender ON Gender = GenderID "
                + "WHERE UserID = ?";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setNString(1, String.valueOf(userID));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                int CVID = rs.getInt("CVID");
                con.close();
                updateCV(cv);
            } else {
                saveCV(cv);
            }

        } catch (SQLException e) {

        }
    }

    public int saveCV(CVDTO cv) {
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
        int result = 0;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtil.getConnection();

            con.setAutoCommit(false);

            ps = con.prepareStatement(sql);
            if (cv.getFirstName() != null) {
                ps.setNString(1, cv.getFirstName());
            } else {
                ps.setNString(1, "");
            }
            if (cv.getLastName() != null) {
                ps.setNString(2, cv.getLastName());
            } else {
                ps.setNString(2, "");
            }
            if (cv.getAvatar() != null) {
                ps.setNString(3, cv.getAvatar());
            } else {
                ps.setNString(3, "");
            }
            if (cv.getDob() != null) {
                ps.setNString(4, cv.getDob());
            } else {
                ps.setNString(4, "yyyy/mm/dd");
            }
            if (cv.getIntroduction() != null) {
                ps.setNString(5, cv.getIntroduction());
            } else {
                ps.setNString(5, "");
            }
            if (cv.getEmail() != null) {
                ps.setNString(6, cv.getEmail());
            } else {
                ps.setNString(6, "username@domainname.extension");
            }
            if (cv.getPhoneNumber() != null) {
                ps.setNString(7, cv.getPhoneNumber());
            } else {
                ps.setNString(7, "");
            }
            if (cv.getAddress() != null) {
                ps.setNString(8, cv.getAddress());
            } else {
                ps.setNString(8, "");
            }
            if (cv.getCity() != null) {
                ps.setNString(9, cv.getCity());
            } else {
                ps.setNString(9, "");
            }

//            int genderID = 1;
//            switch (cv.getGender().toLowerCase()) {
//                case "female":
//                    genderID = 2;
//                    break;
//                case "other":
//                    genderID = 3;
//                    break;
//                default:
//                    genderID = 1;
//                    break;
//            }
            ps.setInt(10, cv.getGender());
            ps.setInt(11, cv.getUserID());
            result = ps.executeUpdate();
//            System.out.println(result);
            int CVID = getHighestCVID(con);
//            System.out.println(getHighestCVID());
            if (cv.getSkills() != null) {
                ArrayList<PreparedStatement> psList = saveSkill(cv.getSkills(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }                
            }
            if (cv.getInterests() != null) {
                ArrayList<PreparedStatement> psList = saveInterest(cv.getInterests(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getCertificates() != null) {
                ArrayList<PreparedStatement> psList = saveCertificate(cv.getCertificates(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getAchievements() != null) {
                ArrayList<PreparedStatement> psList = saveAchievement(cv.getAchievements(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getEducations() != null) {
                ArrayList<PreparedStatement> psList = saveExperience(cv.getExperiences(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getLanguages() != null) {
                ArrayList<PreparedStatement> psList = saveLanguage(cv.getLanguages(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getEducations() != null) {
                ArrayList<PreparedStatement> psList = saveEducation(cv.getEducations(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getSocialMedias() != null) {
                ArrayList<PreparedStatement> psList = saveSocialMedia(cv.getSocialMedias(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            con.commit();

            return result;
        } catch (SQLException e) {
            System.out.println("CV save error: " + e.getMessage());
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException e1) {
                System.out.println("CV save error: " + e.getMessage());
            };

        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CVDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (con != null) {
                try {

                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CVDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
        return result;
    }

    public int getHighestCVID(Connection con) {
        String sql = "SELECT MAX(CVID) AS CVID FROM CV ";
        try {
            PreparedStatement pst = con.prepareStatement(sql);
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

    public ArrayList<PreparedStatement> saveSkill(ArrayList<SkillDTO> skillList, int CVID, Connection con) {
        String sql = "INSERT INTO CV_Skill( "
                + "SkillName, "
                + "SkillDescription, "
                + "CVID "
                + ") VALUES (?,?,?) ";
        ArrayList<PreparedStatement> psList = new ArrayList<>();
        if (skillList != null) {

            try {
                for (SkillDTO x : skillList) {

                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setNString(1, x.getSkillName());
                    ps.setNString(2, x.getSkillDescription());
                    ps.setInt(3, CVID);

                    psList.add(ps);
                }

            } catch (SQLException e) {
                System.out.println("CV save error: " + e.getMessage());
            }
        }
        return psList;
    }

    public ArrayList<PreparedStatement> saveInterest(ArrayList<InterestDTO> interestList, int CVID, Connection con) {
        String sql = "INSERT INTO CV_Interest( "
                + "InterestName, "
                + "CVID "
                + ") VALUES (?,?) ";
        ArrayList<PreparedStatement> psList = new ArrayList<>();
        try {
            for (InterestDTO x : interestList) {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setNString(1, x.getInterestName());
                ps.setInt(2, CVID);

                psList.add(ps);
            }

        } catch (SQLException e) {
            System.out.println("CV save error: " + e.getMessage());
        }
        return psList;
    }

    public ArrayList<PreparedStatement> saveCertificate(ArrayList<CertificateDTO> certificateList, int CVID, Connection con) {
        String sql = "INSERT INTO CV_Certificate( "
                + "CertificateName, "
                + "CertificateLink, "
                + "CVID "
                + ") VALUES (?,?,?) ";
        ArrayList<PreparedStatement> psList = new ArrayList<>();
        try {
            for (CertificateDTO x : certificateList) {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setNString(1, x.getCertificateName());
                ps.setNString(2, x.getCertificateLink());
                ps.setInt(3, CVID);

                psList.add(ps);
            }

        } catch (SQLException e) {
            System.out.println("CV save error: " + e.getMessage());
        }
        return psList;
    }

    public ArrayList<PreparedStatement> saveAchievement(ArrayList<AchievementDTO> achievementList, int CVID, Connection con) {
        String sql = "INSERT INTO CV_Achievement( "
                + "AchievementName, "
                + "AchievementDescription, "
                + "AchievementLink, "
                + "CVID "
                + ") VALUES (?,?,?,?) ";
        ArrayList<PreparedStatement> psList = new ArrayList<>();
        try {
            for (AchievementDTO x : achievementList) {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setNString(1, x.getAchievementName());
                ps.setNString(2, x.getAchievementDescription());
                ps.setNString(3, x.getAchievementLink());
                ps.setInt(4, CVID);

                psList.add(ps);
            }

        } catch (SQLException e) {
            System.out.println("CV save error: " + e.getMessage());
        }
        return psList;
    }

    public ArrayList<PreparedStatement> saveExperience(ArrayList<ExperienceDTO> experienceList, int CVID, Connection con) {
        String sql = "INSERT INTO CV_Experience( "
                + "JobTitle, "
                + "OrganizationName, "
                + "ExperienceDescription, "
                + "ExperienceDuration, "
                + "CVID "
                + ") VALUES (?,?,?,?,?) ";
        ArrayList<PreparedStatement> psList = new ArrayList<>();
        try {
            for (ExperienceDTO x : experienceList) {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setNString(1, x.getJobTitle());
                ps.setNString(2, x.getExperienceOrganizationName());
                ps.setNString(3, x.getExperienceDescription());
                ps.setNString(4, x.getExperienceDuration());
                ps.setInt(5, CVID);

                psList.add(ps);
            }

        } catch (SQLException e) {
            System.out.println("CV save error: " + e.getMessage());
        }
        return psList;
    }

    public ArrayList<PreparedStatement> saveLanguage(ArrayList<LanguageDTO> languageList, int CVID, Connection con) {
        String sql = "INSERT INTO CV_Language( "
                + "LanguageName, "
                + "LanguageDescription, "
                + "CVID "
                + ") VALUES (?,?,?) ";
        ArrayList<PreparedStatement> psList = new ArrayList<>();

        if (languageList != null) {
            try {
                for (LanguageDTO x : languageList) {

                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setNString(1, x.getLanguageName());
                    ps.setNString(2, x.getLanguageDescription());
                    ps.setInt(3, CVID);

                    psList.add(ps);
                }

            } catch (SQLException e) {
                System.out.println("CV save error: " + e.getMessage());
            }
        }
        return psList;
    }

    public ArrayList<PreparedStatement> saveEducation(ArrayList<EducationDTO> educationList, int CVID, Connection con) {
        String sql = "INSERT INTO CV_Education( "
                + "EducationName, "
                + "OrganizationName, "
                + "StatusID, "
                + "CVID "
                + ") VALUES (?,?,?,?) ";
        ArrayList<PreparedStatement> psList = new ArrayList<>();

        if (educationList != null) {
            try {
                for (EducationDTO x : educationList) {

                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setNString(1, x.getEducationName());
                    ps.setNString(2, x.getOrganizationName());
                    ps.setInt(3, x.getStatus());
                    ps.setInt(4, CVID);

                    psList.add(ps);
                }

            } catch (SQLException e) {
                System.out.println("CV save error: " + e.getMessage());
            }
        }
        return psList;
    }

    public ArrayList<PreparedStatement> saveSocialMedia(ArrayList<SocialMediaDTO> socialMediaList, int CVID, Connection con) {
        String sql = "INSERT INTO CV_SocialMedia( "
                + "SocialMediaLink, "
                + "PlatformID, "
                + "CVID "
                + ") VALUES (?,?,?) ";
        ArrayList<PreparedStatement> psList = new ArrayList<>();
        try {
            for (SocialMediaDTO x : socialMediaList) {
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setNString(1, x.getSocialMediaLink());
                ps.setInt(2, x.getPlatformID());
                ps.setInt(3, CVID);

                psList.add(ps);
            }

        } catch (SQLException e) {
            System.out.println("CV save error: " + e.getMessage());
        }
        return psList;
    }

//==============================================================================
    public int updateCV(CVDTO cv) {
        String sql = "UPDATE CV "
                + "SET FirstName = ?, "
                + "LastName = ?, "
                + "Avatar = ?, "
                + "Dob = ?, "
                + "Introduction = ?, "
                + "Email = ?, "
                + "PhoneNumber = ?, "
                + "[Address] = ?, "
                + "City = ?, "
                + "Gender = ? "
                + "WHERE CVID = ? ";
        int result = 0;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtil.getConnection();

            con.setAutoCommit(false);

            ps = con.prepareStatement(sql);
            if (cv.getFirstName() != null) {
                ps.setNString(1, cv.getFirstName());
            } else {
                ps.setNString(1, "");
            }
            if (cv.getLastName() != null) {
                ps.setNString(2, cv.getLastName());
            } else {
                ps.setNString(2, "");
            }
            if (cv.getAvatar() != null) {
                ps.setNString(3, cv.getAvatar());
            } else {
                ps.setNString(3, "");
            }
            if (cv.getDob() != null) {
                ps.setNString(4, cv.getDob());
            } else {
                ps.setNString(4, "yyyy/mm/dd");
            }
            if (cv.getIntroduction() != null) {
                ps.setNString(5, cv.getIntroduction());
            } else {
                ps.setNString(5, "");
            }
            if (cv.getEmail() != null) {
                ps.setNString(6, cv.getEmail());
            } else {
                ps.setNString(6, "username@domainname.extension");
            }
            if (cv.getPhoneNumber() != null) {
                ps.setNString(7, cv.getPhoneNumber());
            } else {
                ps.setNString(7, "");
            }
            if (cv.getAddress() != null) {
                ps.setNString(8, cv.getAddress());
            } else {
                ps.setNString(8, "");
            }
            if (cv.getCity() != null) {
                ps.setNString(9, cv.getCity());
            } else {
                ps.setNString(9, "");
            }
//            int genderID = 1;
//            switch (cv.getGender().toLowerCase()) {
//                case "female":
//                    genderID = 2;
//                    break;
//                case "other":
//                    genderID = 3;
//                    break;
//                default:
//                    genderID = 1;
//                    break;
//            }
            ps.setInt(10, cv.getGender());

            int CVID = cv.getCVID();

            if (cv.getSkills() != null) {
                deleteSkill(CVID, con).executeUpdate();
                ArrayList<PreparedStatement> psList = saveSkill(cv.getSkills(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }                
            }
            if (cv.getInterests() != null) {
                deleteInterest(CVID, con).executeUpdate();
                ArrayList<PreparedStatement> psList = saveInterest(cv.getInterests(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getCertificates() != null) {
                deleteCertificate(CVID, con).executeUpdate();
                ArrayList<PreparedStatement> psList = saveCertificate(cv.getCertificates(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getAchievements() != null) {
                deleteAchievement(CVID, con).executeUpdate();
                ArrayList<PreparedStatement> psList = saveAchievement(cv.getAchievements(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getEducations() != null) {
                deleteEducation(CVID, con).executeUpdate();
                ArrayList<PreparedStatement> psList = saveEducation(cv.getEducations(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getLanguages() != null) {
                deleteLanguage(CVID, con).executeUpdate();
                ArrayList<PreparedStatement> psList = saveLanguage(cv.getLanguages(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getExperiences() != null) {
                deleteExperience(CVID, con).executeUpdate();
                ArrayList<PreparedStatement> psList = saveExperience(cv.getExperiences(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }
            if (cv.getSocialMedias() != null) {
                deleteSocialMedia(CVID, con).executeUpdate();
                ArrayList<PreparedStatement> psList = saveSocialMedia(cv.getSocialMedias(), CVID, con);
                for (PreparedStatement x : psList) {
                    x.executeUpdate();
                }  
            }

            ps.setInt(11, cv.getCVID());
            result = ps.executeUpdate();

            con.commit();

            return result;
        } catch (SQLException e) {
            System.out.println("CV update error: " + e.getMessage());
            try {
                if (con != null) {
                    con.rollback();
                }
            } catch (SQLException e1) {
                System.out.println("CV update error: " + e.getMessage());
            };

        } finally {
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CVDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (con != null) {
                try {

                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CVDAO.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

        }
        return result;
    }

    //==============================================================================
    public void deleteCV(CVDTO cv) {
        String sql = "DELETE FROM CV "
                + "WHERE CVID = ? ";
        int result = 0;
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBUtil.getConnection();

            con.setAutoCommit(false);

            int CVID = cv.getCVID();
            deleteSkill(CVID, con).executeUpdate();
            deleteInterest(CVID, con).executeUpdate();
            deleteCertificate(CVID, con).executeUpdate();
            deleteAchievement(CVID, con).executeUpdate();
            deleteExperience(CVID, con).executeUpdate();
            deleteLanguage(CVID, con).executeUpdate();
            deleteEducation(CVID, con).executeUpdate();
            deleteSocialMedia(CVID, con).executeUpdate();

            ps.setInt(1, cv.getCVID());
            result = ps.executeUpdate();

            con.commit();

        } catch (SQLException e) {

        }
    }

    public PreparedStatement deleteSkill(int CVID, Connection con) {
        String sql = "DELETE FROM CV_Skill "
                + "WHERE CVID = ? ";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, CVID);
            return ps;

        } catch (SQLException e) {
            System.out.println("CV delete error: " + e.getMessage());
        }

        return null;
    }

    public PreparedStatement deleteInterest(int CVID, Connection con) {
        String sql = "DELETE FROM CV_Interest "
                + "WHERE CVID = ? ";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, CVID);
            return ps;

        } catch (SQLException e) {
            System.out.println("CV delete error: " + e.getMessage());
        }

        return null;
    }

    public PreparedStatement deleteCertificate(int CVID, Connection con) {
        String sql = "DELETE FROM CV_Certificate "
                + "WHERE CVID = ? ";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, CVID);
            return ps;

        } catch (SQLException e) {
            System.out.println("CV delete error: " + e.getMessage());
        }

        return null;
    }

    public PreparedStatement deleteAchievement(int CVID, Connection con) {
        String sql = "DELETE FROM CV_Achievement "
                + "WHERE CVID = ? ";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, CVID);
            return ps;

        } catch (SQLException e) {
            System.out.println("CV delete error: " + e.getMessage());
        }

        return null;
    }

    public PreparedStatement deleteExperience(int CVID, Connection con) {
        String sql = "DELETE FROM CV_Experience "
                + "WHERE CVID = ? ";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, CVID);
            return ps;

        } catch (SQLException e) {
            System.out.println("CV delete error: " + e.getMessage());
        }

        return null;
    }

    public PreparedStatement deleteLanguage(int CVID, Connection con) {
        String sql = "DELETE FROM CV_Language "
                + "WHERE CVID = ? ";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, CVID);
            return ps;

        } catch (SQLException e) {
            System.out.println("CV delete error: " + e.getMessage());
        }

        return null;
    }

    public PreparedStatement deleteEducation(int CVID, Connection con) {
        String sql = "DELETE FROM CV_Education "
                + "WHERE CVID = ? ";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, CVID);
            return ps;

        } catch (SQLException e) {
            System.out.println("CV delete error: " + e.getMessage());
        }

        return null;
    }

    public PreparedStatement deleteSocialMedia(int CVID, Connection con) {
        String sql = "DELETE FROM CV_SocialMedia "
                + "WHERE CVID = ? ";

        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, CVID);
            return ps;

        } catch (SQLException e) {
            System.out.println("CV delete error: " + e.getMessage());
        }

        return null;
    }

//    public static void main(String[] args) {
//        CVDAO dao = new CVDAO();
//        CVDTO dto = new CVDTO();
//
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
//        achievementList.add(new AchievementDTO(0, "test 1", "test 1", 0));
//        achievementList.add(new AchievementDTO(0, "test 2", "test 2", 0));
//        ArrayList<ExperienceDTO> experienceList = new ArrayList<>();
//        experienceList.add(new ExperienceDTO(0, "test 1", "test 2", "test 3", "test 4", 0));
//        ArrayList<LanguageDTO> languageList = new ArrayList<>();
//        languageList.add(new LanguageDTO(0, "test language 1", "test language description", 0));
//        languageList.add(new LanguageDTO(0, "test language 2", "test language description", 0));
//        ArrayList<EducationDTO> educationList = new ArrayList<>();
//        educationList.add(new EducationDTO(0, "test 1", "test 2", 1, 0));
//        ArrayList<SocialMediaDTO> socialMediaList = new ArrayList<>();
//        socialMediaList.add(new SocialMediaDTO(0, "test 1", 1, 0));
//        socialMediaList.add(new SocialMediaDTO(0, "test 2", 2, 0));
//        dto = new CVDTO(1, "test 1", "test 2", "2011-04-01", "test 5", "test572477@gmail.com", "test 7", "test 8", "test 9", "male", 1, skillList, null, null, null, null, null, null, null);
//
////      skillList, interestList, certificateList, achievementList, experienceList, languageList, educationList, socialMediaList
//        Connection con = DBUtil.getConnection();
//        dao.updateCV(dto);
//        dto = dao.loadCV(1);
//        System.out.println(dto.toString());
//    }
}
