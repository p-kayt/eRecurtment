/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationposition;

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
public class ApplicationPositionDAO {

    public ArrayList<ApplicationPositionDTO> listApplicationPositions() {
        String sql = "select PositionID, PositionName, PositionDescription, HiringQuantity, CreatedDate, StatusID from ApplicationPosition";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            ArrayList<ApplicationPositionDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationPositionDTO ap = new ApplicationPositionDTO();
                ap.setPositionID(rs.getInt("PositionID"));
                ap.setPositionName(rs.getNString("PositionName"));
                ap.setPositionDescription(rs.getNString("PositionDescription"));
                ap.setHiringQuantity(rs.getInt("HiringQuantity"));
                ap.setCreatedDate(rs.getDate("CreatedDate"));
                ap.setStatusID(rs.getInt("StatusID"));

                list.add(ap);
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

    // get application positions list by status
    public ArrayList<ApplicationPositionDTO> listByStatus(int statusID) {
        String sql = "select PositionID, PositionName, PositionDescription, HiringQuantity, CreatedDate, StatusID from ApplicationPosition where StatusID = ?";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            ArrayList<ApplicationPositionDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, statusID);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationPositionDTO ap = new ApplicationPositionDTO();
                ap.setPositionID(rs.getInt("PositionID"));
                ap.setPositionName(rs.getNString("PositionName"));
                ap.setPositionDescription(rs.getNString("PositionDescription"));
                ap.setHiringQuantity(rs.getInt("HiringQuantity"));
                ap.setCreatedDate(rs.getDate("CreatedDate"));
                ap.setStatusID(rs.getInt("StatusID"));

                list.add(ap);
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

    public ArrayList<ApplicationPositionDTO> searchApplicationPositions(String keyword) {
        String sql = "select PositionID, PositionName, PositionDescription, HiringQuantity, CreatedDate, StatusID from ApplicationPosition where PositionName like ?";
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            ArrayList<ApplicationPositionDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setNString(1, "%" + keyword + "%");
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationPositionDTO ap = new ApplicationPositionDTO();
                ap.setPositionID(rs.getInt("PositionID"));
                ap.setPositionName(rs.getNString("PositionName"));
                ap.setPositionDescription(rs.getNString("PositionDescription"));
                ap.setHiringQuantity(rs.getInt("HiringQuantity"));
                ap.setCreatedDate(rs.getDate("CreatedDate"));
                ap.setStatusID(rs.getInt("StatusID"));

                list.add(ap);
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

    public int updateApplicationPosition(ApplicationPositionDTO dto) {
        String sql = "update ApplicationPosition set PositionName = ?, PositionDescription = ?, HiringQuantity = ?, CreatedDate = ?, StatusID = ? where PositionID = ?";
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setNString(1, dto.getPositionName());
            pst.setNString(2, dto.getPositionDescription());
            pst.setInt(3, dto.getHiringQuantity());
            pst.setDate(4, dto.getCreatedDate());
            pst.setInt(5, dto.getStatusID());
            pst.setInt(6, dto.getPositionID());

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

    public int deleteApplicationPosition(int id) {
        String sql = "delete from ApplicationPosition where PositionID = ?";
        int result = 0;
        Connection cn = null;
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, id);

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
        ApplicationPositionDAO dao = new ApplicationPositionDAO();
        ArrayList<ApplicationPositionDTO> list = dao.listByStatus(2);

        if (list.isEmpty() || list == null) {
            System.out.println("List is null");
        }

        for (ApplicationPositionDTO ap : list) {
            System.out.println(ap.getPositionID());
            System.out.println(ap.getPositionName());
            System.out.println(ap.getPositionDescription());
            System.out.println(ap.getHiringQuantity());
            System.out.println(ap.getCreatedDate());
            System.out.println(ap.getStatusID());
            System.out.println("");
        }
    }
}
