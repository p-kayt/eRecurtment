/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationposition;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

/**
 *
 * @author MSI GF63
 */
public class ApplicationPositionDAO {
    private static Connection cn;
    
    // Check Post for Position deletion
    private int checkPost(int postID) {
        String sql = "select PositionID from ApplicationPost where PositionID = ?";
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
    
    
    public ApplicationPositionDTO loadApplicationPositions(int id) {
        String sql = "select PositionID, PositionName, PositionDescription, HiringQuantity, CreatedDate, StatusID from ApplicationPosition where PositionID = ?";
        try {
            cn = DBUtil.getConnection();
            ArrayList<ApplicationPositionDTO> list = new ArrayList<>();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                ApplicationPositionDTO ap = new ApplicationPositionDTO();
                ap.setPositionID(rs.getInt("PositionID"));
                ap.setPositionName(rs.getNString("PositionName"));
                ap.setPositionDescription(rs.getNString("PositionDescription"));
                ap.setHiringQuantity(rs.getInt("HiringQuantity"));
                ap.setCreatedDate(rs.getDate("CreatedDate"));
                ap.setStatusID(rs.getInt("StatusID"));
                
                return ap;
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

    public ArrayList<ApplicationPositionDTO> listApplicationPositions() {
        String sql = "select PositionID, PositionName, PositionDescription, HiringQuantity, CreatedDate, StatusID from ApplicationPosition";
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
    
    public int addApplicationPosition(ApplicationPositionDTO dto) {
        String sql = "INSERT INTO ApplicationPosition(PositionName, PositionDescription, HiringQuantity, CreatedDate, StatusID) VALUES(?, ?, ?, ?, ?)";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            cn.setAutoCommit(false);
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setNString(1, dto.getPositionName());
            pst.setNString(2, dto.getPositionDescription());
            pst.setInt(3, dto.getHiringQuantity());
            pst.setDate(4, dto.getCreatedDate());
            pst.setInt(5, dto.getStatusID());

            result = pst.executeUpdate();
            if(result != 0){
                cn.commit();
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

    public int updateApplicationPosition(ApplicationPositionDTO dto) {
        String sql = "update ApplicationPosition set PositionName = ?, PositionDescription = ?, HiringQuantity = ?, CreatedDate = ?, StatusID = ? where PositionID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            cn.setAutoCommit(false);
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setNString(1, dto.getPositionName());
            pst.setNString(2, dto.getPositionDescription());
            pst.setInt(3, dto.getHiringQuantity());
            pst.setDate(4, dto.getCreatedDate());
            pst.setInt(5, dto.getStatusID());
            pst.setInt(6, dto.getPositionID());

            result = pst.executeUpdate();
            if(result != 0){
                cn.commit();
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

    // safe delete for Application position
    // Use for Position with no existing FK reference (Post)
    public int safeDeleteApplicationPosition(int id) {
        String sql = "delete from ApplicationPosition where PositionID = ?";
        int result = 0, check = checkPost(id);
        if(check != 0){
            System.out.println("FK of Position existed! Deletion cancel");
            return 0;
        }
        try {
            cn = DBUtil.getConnection();
            cn.setAutoCommit(false);
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, id);

            result = pst.executeUpdate();
            if(result != 0){
                cn.commit();
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
    
    public int deleteApplicationPosition(int id) {
        String sql = "delete from ApplicationPosition where PositionID = ?";
        int result = 0;
        try {
            cn = DBUtil.getConnection();
            cn.setAutoCommit(false);
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setInt(1, id);

            result = pst.executeUpdate();
            if(result != 0){
                cn.commit();
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

    public static void main(String[] args) {
        ApplicationPositionDAO dao = new ApplicationPositionDAO();
//        ArrayList<ApplicationPositionDTO> list = dao.listByStatus(2);
//
//        if (list.isEmpty() || list == null) {
//            System.out.println("List is null");
//        }
//
//        for (ApplicationPositionDTO ap : list) {
//            System.out.println(ap.getPositionID());
//            System.out.println(ap.getPositionName());
//            System.out.println(ap.getPositionDescription());
//            System.out.println(ap.getHiringQuantity());
//            System.out.println(ap.getCreatedDate());
//            System.out.println(ap.getStatusID());
//            System.out.println("");
//        }
        ApplicationPositionDTO dto = new ApplicationPositionDTO();
        dto.setPositionID(0);
        dto.setPositionName("Test V? Trí");
        dto.setPositionDescription("Test mô t? v? trí");
        dto.setHiringQuantity(0);
        dto.setCreatedDate(Date.valueOf(LocalDate.now()));
        dto.setStatusID(3);
        
        int result = dao.addApplicationPosition(dto);
        if(result == 0){
            System.out.println("Add position fail!");
        }
        else{
            System.out.println("Add position success");
        }
    }
}
