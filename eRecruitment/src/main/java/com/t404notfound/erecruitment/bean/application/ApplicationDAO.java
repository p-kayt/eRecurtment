/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.application;

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
            if (result != 0) {
                cn.commit();
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
        ApplicationDAO dao = new ApplicationDAO();
//        ApplicationDTO dto = new ApplicationDTO();
//        long millis = System.currentTimeMillis();
//        java.sql.Date date = new java.sql.Date(millis);
//        dto.setApplyDate(date);
//        dto.setStatusID(1);
//        dto.setStageID(1);
//        dto.setUserID(2);
//        dto.setPostID(2);
//
//        int res = dao.addApplication(dto);
//        System.out.println(res);
    }

}
