/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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
            System.out.println(sql);
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            if (rs.next()) {
                CVDTO cv = new CVDTO();
                System.out.println(rs.toString());
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
                return cv;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        CVDAO dao = new CVDAO();
        CVDTO dto;
        dto = dao.loadCV(1);
        System.out.println(dto.toString());
        
    }
}
