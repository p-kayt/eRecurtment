/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.application;

import Util.DBUtil;
import com.t404notfound.erecruitment.bean.interview.InterviewDTO;
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
public class ApplicationDAO {

    private static Connection cn;

    public ApplicationDAO() {
    }

    // Get list of all job application
    // Sort by Apply Date descending
    // Newest -> oldest
    public ArrayList<ApplicationDTO> listAllApplication() {
        String sql = "select ApplicationID, ApplyDate, StatusID, StageID, UserID, PostID from Application order by ApplyDate desc";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            ArrayList<ApplicationDTO> list = new ArrayList<>();
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationDTO dto = new ApplicationDTO();
                dto.setId(rs.getInt("ApplicationID"));
                dto.setApplyDate(rs.getDate("ApplyDate"));
                dto.setStatusID(rs.getInt("StatusID"));
                dto.setStageID(rs.getInt("StageID"));
                dto.setUserID(rs.getInt("UserID"));
                dto.setPostID(rs.getInt("PostID"));

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

    public ApplicationDTO getApplicationByID(int appID) {
        String sql = "select ApplicationID, ApplyDate, StatusID, StageID, UserID, PostID from Application where ApplicationID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, appID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                ApplicationDTO dto = new ApplicationDTO();
                dto.setId(rs.getInt("ApplicationID"));
                dto.setApplyDate(rs.getDate("ApplyDate"));
                dto.setStatusID(rs.getInt("StatusID"));
                dto.setStageID(rs.getInt("StageID"));
                dto.setUserID(rs.getInt("UserID"));
                dto.setPostID(rs.getInt("PostID"));

                return dto;
            }
            return null;
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

    public int cancelApplication(int appID) {
        String sql = "update Application set StatusID = 2 where ApplicationID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, appID);
            return pst.executeUpdate();
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

    public ArrayList<ApplicationDTO> listAllApplicationOfAPost(int postID) {
        String sql = "select ApplicationID, ApplyDate, StatusID, StageID, UserID, PostID from Application where PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, postID);
            ArrayList<ApplicationDTO> list = new ArrayList<>();
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationDTO dto = new ApplicationDTO();
                dto.setId(rs.getInt("ApplicationID"));
                dto.setApplyDate(rs.getDate("ApplyDate"));
                dto.setStatusID(rs.getInt("StatusID"));
                dto.setStageID(rs.getInt("StageID"));
                dto.setUserID(rs.getInt("UserID"));
                dto.setPostID(rs.getInt("PostID"));

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

    public ArrayList<ApplicationDTO> listAllApplicationOfAUser(int userID) {
        String sql = "select ApplicationID, ApplyDate, StatusID, StageID, UserID, PostID from Application where UserID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, userID);
            ArrayList<ApplicationDTO> list = new ArrayList<>();
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationDTO dto = new ApplicationDTO();
                dto.setId(rs.getInt("ApplicationID"));
                dto.setApplyDate(rs.getDate("ApplyDate"));
                dto.setStatusID(rs.getInt("StatusID"));
                dto.setStageID(rs.getInt("StageID"));
                dto.setUserID(rs.getInt("UserID"));
                dto.setPostID(rs.getInt("PostID"));

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

    public int addApplication(ApplicationDTO dto) {
        int result = 0;
        String sql = "INSERT INTO Application(ApplyDate, StatusID, StageID, UserID, PostID) VALUES(?, ?, ?, ?, ?)";
        try {
            cn = DBUtil.getConnection();
            cn.setAutoCommit(false);
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setDate(1, dto.getApplyDate());
            pst.setInt(2, dto.getStatusID());
            pst.setInt(3, dto.getStageID());
            pst.setInt(4, dto.getUserID());
            pst.setInt(5, dto.getPostID());

            result = pst.executeUpdate();

            cn.commit();
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

    public boolean isUserApplying(int userID, int postID) {
        String sql = "select ApplicationID from Application where UserID = ? and PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, userID);
            pst.setInt(2, postID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return true;
            } else {
                return false;
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
        return true;
    }

    public int rejectApplication(int appID) {
        String sql = "update Application set StatusID = 3 where ApplicationID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, appID);
            return pst.executeUpdate();
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

    public int getNextStage(int stageOffset, int postID) {
        String sql = "select top 1 LEAD(ID, ?, 0) OVER ( ORDER BY ID ) AS NextID FROM Application_Stage where PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, stageOffset);
            pst.setInt(2, postID);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }

    public int approveToNextStage(int nextStage, int appID) {
        String sql = "update Application set StageID = ? where ApplicationID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, nextStage);
            pst.setInt(2, appID);
            return pst.executeUpdate();
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
    
    public int rollbackToPreviousStage(int previousStage, int appID) {
        String sql = "update Application set StageID = ? where ApplicationID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, previousStage);
            pst.setInt(2, appID);
            return pst.executeUpdate();
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
    
    public int getIDOfApplication(int userID, int postID) {
        String sql = "select ApplicationID from Application where UserID = ? and PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);

            pst.setInt(1, userID);
            pst.setInt(2, postID);

            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
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
        return 0;
    }
    
    public int approveApplicationSuccess(int nextStage, int appID) {
        String sql = "update Application set StageID = ?, StatusID = 4 where ApplicationID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, nextStage);
            pst.setInt(2, appID);
            return pst.executeUpdate();
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

    public ArrayList<InterviewDTO> getInterviewsOfPost(int postID) {
        ArrayList<InterviewDTO> list = new ArrayList<>();
        String sql = " SELECT * FROM [Interview] where PostID = ? ";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, postID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int interviewID = rs.getInt("InterviewID");
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime").split("\\.")[0];
                /* Convert date to String using DateFormat*/

                int maxCandidate = rs.getInt("MaxCandidate");
                int stageID = rs.getInt("StageID");
                int formatID = rs.getInt("FormatID");
                int statusID = rs.getInt("StatusID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCandidate, stageID, postID, statusID, bookerID);
                list.add(tmp);
            }
            return list;

        } catch (Exception e) {
            System.out.println("Error when get interview list.");
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ApplicationDAO dao = new ApplicationDAO();
        int r = dao.getIDOfApplication(1, 3);
        System.out.println(r);
        
    }

}
