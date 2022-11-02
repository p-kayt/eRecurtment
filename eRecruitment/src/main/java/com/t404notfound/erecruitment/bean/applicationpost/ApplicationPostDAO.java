/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationpost;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.Date;
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
    public int getLatestPostID() {
        String sql = "select MAX(PostID) from ApplicationPost";
        int result = -1;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
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

    //============================================================================================================================================
    // Methods for loading Post's info
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
    //============================================================================================================================================

    //============================================================================================================================================
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

    private PreparedStatement getDeletePostBenefitsPST(int postID, Connection cn) {
        String sql = "delete from ApplicationBenefit where PostID = ?";
        try {
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            return pst;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
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

    private PreparedStatement getDeletePostSkillsPST(int postID, Connection cn) {
        String sql = "delete from ApplicationSkill where PostID = ?";
        try {
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            return pst;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
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

    private PreparedStatement getDeletePostRequirementsPST(int postID, Connection cn) {
        String sql = "delete from ApplicationRequirement where PostID = ?";
        try {
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);

            return pst;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return null;
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

    private PreparedStatement getDeletePostStagesPST(int postID, Connection cn) {
        String sql = "delete from Application_Stage where PostID = ?";
        try {
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            return pst;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    //============================================================================================================================================
    public int deleteABenefit(int benefitID) {
        String sql = "delete from ApplicationBenefit where BenefitID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, benefitID);
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

    public int deleteASkill(int skillID) {
        String sql = "delete from ApplicationSkill where SkillID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, skillID);
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

    public int deleteARequirement(int reqID) {
        String sql = "delete from ApplicationRequirement where RequirementID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, reqID);
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

    // Careful when using this method
    // tables have references to this table
    public int deleteAStage(int ID) {
        String sql = "delete from Application_Stage where ID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, ID);
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

    //============================================================================================================================================
    // Methods for adding Post related info
    // Must add post first
    // And insert with latest post ID
    // Add post's benefits
    public int addPostBenefits(ArrayList<PostBenefitDTO> list, int postID) {
        if (list == null || list.isEmpty()) {
            return -1;
        } else {
            String sql = "insert into ApplicationBenefit(Benefit, PostID) values(?, ?)";
            int result = 0;
            try {
                cn = DBUtil.getConnection();
                cn.setAutoCommit(false);
                PreparedStatement pst = cn.prepareStatement(sql);
                for (PostBenefitDTO postBenefitDTO : list) {
                    pst.setNString(1, postBenefitDTO.getBenefit());
                    pst.setInt(2, postID);
                    result = pst.executeUpdate();
                    if (result == 0) {
                        return 0;
                    }
                }
                cn.commit();
                return 1;
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
            return 0;
        }

    }

    // Add post's Skills
    public int addPostSkills(ArrayList<PostSkillDTO> list, int postID) {
        if (list == null || list.isEmpty()) {
            return -1;
        } else {
            String sql = "insert into ApplicationSkill(SkillName, SkillDescription, PostID) values(?, ?, ?)";
            int result = 0;
            try {
                cn = DBUtil.getConnection();
                cn.setAutoCommit(false);
                PreparedStatement pst = cn.prepareStatement(sql);
                for (PostSkillDTO skill : list) {
                    pst.setNString(1, skill.getSkillName());
                    pst.setNString(2, skill.getSkillDescription());
                    pst.setInt(3, postID);
                    result = pst.executeUpdate();
                    if (result == 0) {
                        return 0;
                    }
                }
                cn.commit();
                return 1;
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
            return 0;
        }

    }

    // Add post's requirements
    public int addPostRequirements(ArrayList<PostRequirementDTO> list, int postID) {
        if (list == null || list.isEmpty()) {
            return -1;
        } else {
            String sql = "insert into ApplicationRequirement(Requirement, PostID) values(?, ?)";
            int result = 0;
            try {
                cn = DBUtil.getConnection();
                cn.setAutoCommit(false);
                PreparedStatement pst = cn.prepareStatement(sql);
                for (PostRequirementDTO requirement : list) {
                    pst.setNString(1, requirement.getRequirement());
                    pst.setInt(2, postID);
                    result = pst.executeUpdate();
                    if (result == 0) {
                        return 0;
                    }
                }
                cn.commit();
                return 1;

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
            return 0;
        }
    }

    // Add post's stages
    public int addPostStages(ArrayList<PostStageDTO> list, int postID) {
        if (list == null || list.isEmpty()) {
            return -1;
        } else {
            String sql = "insert into Application_Stage(Description, PostID, StageID) values(?, ?, ?)";
            int result = 0;

            try {
                cn = DBUtil.getConnection();
                cn.setAutoCommit(false);
                PreparedStatement pst = cn.prepareStatement(sql);
                for (PostStageDTO stage : list) {
                    pst.setNString(1, stage.getDescription());
                    pst.setInt(2, postID);
                    pst.setInt(3, stage.getStageID());
                    result = pst.executeUpdate();
                    if (result == 0) {
                        return 0;
                    }
                }
                cn.commit();
                return 1;
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
            return 0;
        }

    }
    //============================================================================================================================================
    // Methods for updating Post's info

    // updating post's benefits
    public int updatePostBenefits(ArrayList<PostBenefitDTO> list) {
        String sql = "update ApplicationBenefit set Benefit = ? where BenefitID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            for (PostBenefitDTO postBenefitDTO : list) {
                pst.setNString(1, postBenefitDTO.getBenefit());
                pst.setInt(2, postBenefitDTO.getBenefitID());
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

    // updating post's skills
    public int updatePostSkills(ArrayList<PostSkillDTO> list) {
        String sql = "update ApplicationSkill set SkillName = ?, SkillDescription = ? where SkillID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            for (PostSkillDTO skill : list) {
                pst.setNString(1, skill.getSkillName());
                pst.setNString(2, skill.getSkillDescription());
                pst.setInt(3, skill.getSkillID());
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

    // updating post's requirements
    public int updatePostRequirements(ArrayList<PostRequirementDTO> list) {
        String sql = "update ApplicationRequirement set Requirement = ? where RequirementID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            for (PostRequirementDTO requirement : list) {
                pst.setNString(1, requirement.getRequirement());
                pst.setInt(2, requirement.getRequirementID());
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

    // updating post's stages
    public int updatePostStages(ArrayList<PostStageDTO> list) {
        String sql = "update Application_Stage set Description = ?, StageID = ? where ID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            for (PostStageDTO stage : list) {
                pst.setNString(1, stage.getDescription());
                pst.setInt(2, stage.getStageID());
                pst.setInt(3, stage.getId());
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
    //============================================================================================================================================

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

    public ArrayList<ApplicationPostDTO> listTop10FullTimePost() {
        // select top 10 post with post working form is FULLTIME (1, 2, 3)
        // post status is HIRING
        // with position status is HIRING
        // order by HIRING QUANTITY in descending order
        String sql = "select top 10 post.PostID, post.PostDescription, post.Salary, post.HiringQuantity, post.CreateDate, post.StartDate, post.ExpiredDate, post.PositionID, post.FormID, post.StatusID, position.PositionName "
                + "from ApplicationPost as post "
                + "join ApplicationPosition as position on post.PositionID = position.PositionID "
                + "where post.FormID in (1, 2, 3) "
                + "and post.StatusID = 3 "
                + "and position.StatusID = 3 "
                + "order by post.HiringQuantity desc";
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
                post.setPositionName(rs.getNString("PositionName"));

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

    public ArrayList<ApplicationPostDTO> listTop10PartTimePost() {
        // select top 10 post with post working form is PARTTIME (4,5,6)
        // post status is HIRING
        // with position status is HIRING
        // order by HIRING QUANTITY in descending order
        String sql = "select top 10 post.PostID, post.PostDescription, post.Salary, post.HiringQuantity, post.CreateDate, post.StartDate, post.ExpiredDate, post.PositionID, post.FormID, post.StatusID, position.PositionName "
                + "from ApplicationPost as post "
                + "join ApplicationPosition as position on post.PositionID = position.PositionID "
                + "where post.FormID in (4, 5, 6) "
                + "and post.StatusID = 3 "
                + "and position.StatusID = 3 "
                + "order by post.HiringQuantity desc";
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
                post.setPositionName(rs.getNString("PositionName"));

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

    public ArrayList<ApplicationPostDTO> listTop4RecentlyAddedPosts() {
        // select top 4 post
        // post status is HIRING
        // with position status is HIRING
        // order by CREATEDATE in descending order
        String sql = "select top 4 post.PostID, post.PostDescription, post.Salary, post.HiringQuantity, post.CreateDate, post.StartDate, post.ExpiredDate, post.PositionID, post.FormID, post.StatusID, position.PositionName "
                + "from ApplicationPost as post "
                + "join ApplicationPosition as position on post.PositionID = position.PositionID "
                + "where post.StatusID = 3 "
                + "and position.StatusID = 3 "
                + "order by post.CreateDate desc";
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
                post.setPositionName(rs.getNString("PositionName"));

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

    public ArrayList<ApplicationPostDTO> listTop10HighestHiringQuantityPosts() {
        // select top 4 post
        // post status is HIRING
        // with position status is HIRING
        // order by HIRINGQUANTITY in descending order
        String sql = "select top 10 post.PostID, post.PostDescription, post.Salary, post.HiringQuantity, post.CreateDate, post.StartDate, post.ExpiredDate, post.PositionID, post.FormID, post.StatusID, position.PositionName "
                + "from ApplicationPost as post "
                + "join ApplicationPosition as position on post.PositionID = position.PositionID "
                + "where post.StatusID = 3 "
                + "and position.StatusID = 3 "
                + "order by HiringQuantity desc";
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
                post.setPositionName(rs.getNString("PositionName"));

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
        int result = 0;
        String sql = "delete from ApplicationPost where PostID = ?";
        try {

            cn = DBUtil.getConnection();
            cn.setAutoCommit(false);

            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            PreparedStatement deleteBenefitsPST = getDeletePostBenefitsPST(postID, cn);
            deleteBenefitsPST.executeUpdate();
            PreparedStatement deleteSkillsPST = getDeletePostSkillsPST(postID, cn);
            deleteSkillsPST.executeUpdate();
            PreparedStatement deleteRequirementsPST = getDeletePostRequirementsPST(postID, cn);
            deleteRequirementsPST.executeUpdate();
            PreparedStatement deleteStagesPST = getDeletePostStagesPST(postID, cn);
            deleteStagesPST.executeUpdate();

            result = pst.executeUpdate();

            cn.commit();
            return result;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            try {
                if (cn != null) {
                    cn.rollback();
                    return 0;
                }
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
            }
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

    public int addPost(ApplicationPostDTO post) {
        int result = 0;
        String sql = "INSERT INTO ApplicationPost(PostDescription, Salary, HiringQuantity, CreateDate, StartDate, ExpiredDate, PositionID, FormID, StatusID) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            cn = DBUtil.getConnection();
            cn.setAutoCommit(false);
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

            if (result != 0) {
                cn.commit();
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

    public int updatePost(ApplicationPostDTO post) {
        int result = 0;
        String sql = "update ApplicationPost set PostDescription = ?, Salary = ?, HiringQuantity = ?, CreateDate = ?, StartDate = ?, ExpiredDate = ?, PositionID = ?, FormID = ?, StatusID = ? where PostID = ?";
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

            pst.setInt(10, post.getPostID());

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

    public static void main(String[] args) {

        ApplicationPostDAO dao = new ApplicationPostDAO();
//        int result = dao.deleteApplicationPost(4);
//        System.out.println(result);

    }
}
