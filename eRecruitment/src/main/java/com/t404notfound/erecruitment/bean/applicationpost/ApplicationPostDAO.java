/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationpost;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author MSI GF63
 */
public class ApplicationPostDAO {

    // Load post's benefits
    public ArrayList<PostBenefitDTO> loadPostBenefits(int postID) {
        String sql = "select BenefitID, Benefit, PostID from ApplicationBenefit where PostID = ?";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            ArrayList<PostBenefitDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                PostBenefitDTO dto = new PostBenefitDTO();
                dto.setBenefitID(rs.getInt("BenefitID"));
                dto.setBenefit(rs.getNString("Benefit"));
                dto.setPostID(postID);

                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return null;
    }

    // load post's skills
    public ArrayList<PostSkillDTO> loadPostSkills(int postID) {
        String sql = "select SkillID, SkillName, SkillDescription, PostID from ApplicationSkill where PostID = ?";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            ArrayList<PostSkillDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                PostSkillDTO dto = new PostSkillDTO();
                dto.setSkillID(rs.getInt("SkillID"));
                dto.setSkillName(rs.getNString("SkillName"));
                dto.setSkillDescription(rs.getNString("SkillDescription"));
                dto.setPostID(postID);

                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return null;
    }

    // load post's requirements
    public ArrayList<PostRequirementDTO> loadPostRequirements(int postID) {
        String sql = "select RequirementID, Requirement, PostID from ApplicationRequirement where PostID = ?";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            ArrayList<PostRequirementDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                PostRequirementDTO dto = new PostRequirementDTO();
                dto.setRequirementID(rs.getInt("RequirementID"));
                dto.setRequirement(rs.getNString("Requirement"));
                dto.setPostID(postID);

                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return null;
    }

    // load post's stages
    public ArrayList<PostStageDTO> loadPostStages(int postID) {
        String sql = "select ID, Description, PostID, StageID from Application_Stage where PostID = ?";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            ArrayList<PostStageDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                PostStageDTO dto = new PostStageDTO();
                dto.setId(rs.getInt("ID"));
                dto.setDescription(rs.getNString("Description"));
                dto.setPostID(postID);
                dto.setStageID(rs.getInt("StageID"));

                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return null;
    }

    // Load post info
    public ApplicationPostDTO loadApplicationPost(int postID) {
        String sql = "select PostID, PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID from ApplicationPost where PostID = ?";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                ApplicationPostDTO post = new ApplicationPostDTO();
                post.setPostID(postID);
                post.setPostDescription(rs.getNString("PostDescription"));
                post.setSalary(rs.getNString("Salary"));
                post.setHiringQuantity(rs.getInt("HiringQuantity"));
                post.setCreatedDate(rs.getDate("CreateDate"));
                post.setStartDate(rs.getDate("StartDate"));
                post.setExpiredDate(rs.getDate("ExpiredDate"));
                post.setPositionID(rs.getInt("PositionID"));
                post.setFormID(rs.getInt("FormID"));
                post.setStatusID(rs.getInt("StatusID"));

                post.setBenefitList(loadPostBenefits(postID));
                post.setSkillList(loadPostSkills(postID));
                post.setRequirementList(loadPostRequirements(postID));
                post.setStageList(loadPostStages(postID));

                return post;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return null;
    }
    
    // load posts list
    public ArrayList<ApplicationPostDTO> listApplicationPosts(){
        String sql = "select PostID, PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID from ApplicationPost";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            ArrayList<ApplicationPostDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationPostDTO post = new ApplicationPostDTO();
                post.setPostID(rs.getInt("PostID"));
                post.setPostDescription(rs.getNString("PostDescription"));
                post.setSalary(rs.getNString("Salary"));
                post.setHiringQuantity(rs.getInt("HiringQuantity"));
                post.setCreatedDate(rs.getDate("CreateDate"));
                post.setStartDate(rs.getDate("StartDate"));
                post.setExpiredDate(rs.getDate("ExpiredDate"));
                post.setPositionID(rs.getInt("PositionID"));
                post.setFormID(rs.getInt("FormID"));
                post.setStatusID(rs.getInt("StatusID"));

                post.setBenefitList(loadPostBenefits(post.getPostID()));
                post.setSkillList(loadPostSkills(post.getPostID()));
                post.setRequirementList(loadPostRequirements(post.getPostID()));
                post.setStageList(loadPostStages(post.getPostID()));

                list.add(post);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return null;
    }
    
    public static void main(String[] args) {
        
        ApplicationPostDAO dao = new ApplicationPostDAO();
//        ApplicationPostDTO p = dao.loadApplicationPost(1);
//        System.out.println(p.getPostDescription());
//        for (PostSkillDTO s : p.getSkillList()) {
//            System.out.println(s.getSkillName());
//            System.out.println(s.getSkillDescription());
//            System.out.println("");
//        }
//        System.out.println("");
//        for (PostBenefitDTO b : p.getBenefitList()) {
//            System.out.println(b.getBenefit());
//            System.out.println("");  
//        }
//        System.out.println("");
//        for (PostRequirementDTO r : p.getRequirementList()) {
//            System.out.println(r.getRequirement());
//            System.out.println("");
//        }
//        System.out.println("");
//        for (PostStageDTO s : p.getStageList()) {
//            System.out.println(s.getDescription());
//            System.out.println("");
//        }
//        System.out.println("");
//        System.out.println("");
        
        ArrayList<ApplicationPostDTO> l = dao.listApplicationPosts();
        for (ApplicationPostDTO po : l) {
            System.out.println(po.getPostDescription());
        for (PostSkillDTO s : po.getSkillList()) {
            System.out.println(s.getSkillName());
            System.out.println(s.getSkillDescription());
            System.out.println("");
        }
        System.out.println("");
        for (PostBenefitDTO b : po.getBenefitList()) {
            System.out.println(b.getBenefit());
            System.out.println("");  
        }
        System.out.println("");
        for (PostRequirementDTO r : po.getRequirementList()) {
            System.out.println(r.getRequirement());
            System.out.println("");
        }
        System.out.println("");
        for (PostStageDTO s : po.getStageList()) {
            System.out.println(s.getDescription());
            System.out.println("");
        }
        System.out.println("");
        }
    }
}
