/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.application;

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
    public ArrayList<ApplicationPositionDTO> listApplicationPositions(){
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
                ap.setPositionName(rs.getString("PositionName"));
                ap.setPositionDescription(rs.getString("PositionDescription"));
                ap.setHiringQuantity(rs.getInt("HiringQuantity"));
                ap.setCreatedDate(rs.getDate("CreatedDate"));
                ap.setStatusID(rs.getInt("StatusID"));
                
                list.add(ap);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if(cn != null){
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
        ApplicationPositionDAO dao = new ApplicationPositionDAO();
        ArrayList<ApplicationPositionDTO> list = dao.listApplicationPositions();
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
