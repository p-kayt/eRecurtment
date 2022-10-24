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

    private static Connection cn;

    // Find if a post exist
    private int isPostExist(int postID) {
        String sql = "select PostID from ApplicationPost where PostID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                result = 1;
                return result;
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
        return result;
    }

    // Get ID of the recent added post
    // Use for insert of post's info
    private int getLatestPostID() {
        String sql = "select MAX(PostID) from ApplicationPost";
        int result = -1;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                result = rs.getInt("ID");
                return result;
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
        return result;
    }

    // Check FK for Post deletion
    // check candidate's application
    private int checkApplication(int postID) {
        String sql = "select PostID from Application where PostID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                result = 1;
                return result;
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
        return result;
    }

    // check Interview for post
    private int checkInterview(int postID) {
        String sql = "select PostID from Interview where PostID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                result = 1;
                return result;
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
        return result;
    }

    // Load post's benefits
    private ArrayList<PostBenefitDTO> loadPostBenefits(int postID) {
        String sql = "select BenefitID, Benefit, PostID from ApplicationBenefit where PostID = ?";
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
    private ArrayList<PostSkillDTO> loadPostSkills(int postID) {
        String sql = "select SkillID, SkillName, SkillDescription, PostID from ApplicationSkill where PostID = ?";
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
    private ArrayList<PostRequirementDTO> loadPostRequirements(int postID) {
        String sql = "select RequirementID, Requirement, PostID from ApplicationRequirement where PostID = ?";
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
    private ArrayList<PostStageDTO> loadPostStages(int postID) {
        String sql = "select ID, Description, PostID, StageID from Application_Stage where PostID = ?";
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

    // Methods for deleting Post related info
    // return -1 if failed
    // return 0 if succeed but no row existed with the postID
    // return other value if succeed and row existed
    // delete post's benefits
    private int deletePostBenefits(int postID) {
        int result = -1;
        String sql = "delete from ApplicationBenefit where PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            result = pst.executeUpdate();
            return result;
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
        return result;
    }

    // delete post's skills
    private int deletePostSkills(int postID) {
        int result = -1;
        String sql = "delete from ApplicationSkill where PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            result = pst.executeUpdate();
            return result;
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
        return result;
    }

    // delete post's requirements
    private int deletePostRequirements(int postID) {
        int result = -1;
        String sql = "delete from ApplicationRequirement where PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            result = pst.executeUpdate();
            return result;
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
        return result;
    }

    // delete post's stages
    private int deletePostStages(int postID) {
        int result = -1;
        String sql = "delete from Application_Stage where PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            result = pst.executeUpdate();
            return result;
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
        return result;
    }

    // Methods for adding Post related info
    // Must add post first
    // And insert with latest post ID
    // Add post's benefits
    private int addPostBenefits(ArrayList<PostBenefitDTO> list, int postID) {
        String sql = "insert into ApplicationBenefit(Benefit, PostID) values(?, ?)";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            for (PostBenefitDTO postBenefitDTO : list) {
                pst.setNString(1, postBenefitDTO.getBenefit());
                pst.setInt(2, postID);
                result += pst.executeUpdate();
            }
            return result;
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
        return result;
    }

    // Add post's Skills
    private int addPostSkills(ArrayList<PostSkillDTO> list, int postID) {
        String sql = "insert into ApplicationSkill(SkillName, SkillDescription, PostID) values(?, ?, ?)";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            for (PostSkillDTO skill : list) {
                pst.setNString(1, skill.getSkillName());
                pst.setNString(2, skill.getSkillDescription());
                pst.setInt(3, postID);
                result += pst.executeUpdate();
            }
            return result;
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
        return result;
    }

    // Add post's requirements
    private int addPostRequirements(ArrayList<PostRequirementDTO> list, int postID) {
        String sql = "insert into ApplicationRequirement(Requirement, PostID) values(?, ?)";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            for (PostRequirementDTO requirement : list) {
                pst.setNString(1, requirement.getRequirement());
                pst.setInt(2, postID);
                result += pst.executeUpdate();
            }
            return result;
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
        return result;
    }

    // Add post's stages
    private int addPostStages(ArrayList<PostStageDTO> list, int postID) {
        String sql = "insert into Application_Stage(Description, PostID, StageID) values(?, ?, ?)";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            for (PostStageDTO stage : list) {
                pst.setNString(1, stage.getDescription());
                pst.setInt(2, postID);
                pst.setInt(3, stage.getStageID());
                result += pst.executeUpdate();
            }
            return result;
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
        return result;
    }

    // Load post info
    public ApplicationPostDTO loadApplicationPost(int postID) {
        String sql = "select PostID, PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID from ApplicationPost where PostID = ?";
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
    public ArrayList<ApplicationPostDTO> listApplicationPosts() {
        String sql = "select PostID, PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID from ApplicationPost";
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

    public ArrayList<ApplicationPostDTO> listByStatus(int statusID) {
        String sql = "select PostID, PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID from ApplicationPost where StatusID = ?";
        try {
            cn = DBUtil.getConnection();
            ArrayList<ApplicationPostDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, statusID);
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

    public ArrayList<ApplicationPostDTO> listByPosition(int positionID) {
        String sql = "select PostID, PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID from ApplicationPost where PositionID = ?";
        try {
            cn = DBUtil.getConnection();
            ArrayList<ApplicationPostDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, positionID);
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

    // search posts by 
    public ArrayList<ApplicationPostDTO> searchApplicationPosts(String keyword) {
        String sql = "select PostID, PostDescription, Salary, post.HiringQuantity, CreateDate, StartDate, ExpiredDate, post.PositionID, FormID, post.StatusID"
                + " from ApplicationPost post inner join ApplicationPosition position on post.PositionID = position.PositionID"
                + " where position.PositionName like ?";
        try {
            cn = DBUtil.getConnection();
            ArrayList<ApplicationPostDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setNString(1, "%" + keyword + "%");
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

    // Delete Post
    public int deleteApplicationPost(int postID) {
        int result = -1;
        // check if post is in DB
        int check1 = checkApplication(postID), check2 = checkInterview(postID);
        if (check1 != 0 || check2 != 0) {
            System.out.println("FK of post existed! Cancel deletion");
            return result;
        }
        int post = isPostExist(postID);
        if (post != 0) {
            int delete1 = deletePostBenefits(postID);
            int delete2 = deletePostSkills(postID);
            int delete3 = deletePostRequirements(postID);
            int delete4 = deletePostStages(postID);
            if (delete1 != -1 && delete2 != -1 && delete3 != -1 && delete4 != -1) {
                String sql = "delete from ApplicationPost where PostID = ?";
                try {
                    cn = DBUtil.getConnection();
                    PreparedStatement pst = cn.prepareStatement(sql);
                    pst.setInt(1, postID);
                    result = pst.executeUpdate();
                    return result;
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
            }
        }
        return result;
    }

    public int addPost(ApplicationPostDTO post) {
        int result = 0;
        String sql = "INSERT INTO ApplicationPost(PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setNString(1, post.getPostDescription());
            pst.setNString(2, post.getSalary());
            pst.setInt(3, post.getHiringQuantity());
            pst.setDate(4, post.getCreatedDate());
            pst.setDate(5, post.getStartDate());
            pst.setDate(6, post.getExpiredDate());
            pst.setInt(7, post.getPositionID());
            pst.setInt(8, post.getFormID());
            pst.setInt(9, post.getStatusID());
            
            result = pst.executeUpdate();
            
            if(result != 0){
                int postID = getLatestPostID();
                addPostBenefits(post.getBenefitList(), postID);
                addPostSkills(post.getSkillList(), postID);
                addPostRequirements(post.getRequirementList(), postID);
                addPostStages(post.getStageList(), postID);
                return result;
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
        return result;
    }

    public static void main(String[] args) {

        ApplicationPostDAO dao = new ApplicationPostDAO();

//        int res = dao.isPostExist(1);
//        System.out.println(res);
//        System.out.println("");
//        System.out.println("");
//
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
//        ArrayList<ApplicationPostDTO> l = dao.searchApplicationPosts("test");
//        for (ApplicationPostDTO po : l) {
//            System.out.println(po.getPostDescription());
//            for (PostSkillDTO s : po.getSkillList()) {
//                System.out.println(s.getSkillName());
//                System.out.println(s.getSkillDescription());
//                System.out.println("");
//            }
//            System.out.println("");
//            for (PostBenefitDTO b : po.getBenefitList()) {
//                System.out.println(b.getBenefit());
//                System.out.println("");
//            }
//            System.out.println("");
//            for (PostRequirementDTO r : po.getRequirementList()) {
//                System.out.println(r.getRequirement());
//                System.out.println("");
//            }
//            System.out.println("");
//            for (PostStageDTO s : po.getStageList()) {
//                System.out.println(s.getDescription());
//                System.out.println("");
//            }
//            System.out.println("================================");
//            System.out.println("");
//        }
    }
}
