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
import java.util.ArrayList;

/**
 *
 * @author Huu Minh
 */
public class TMP {
    public ArrayList<SocialMediaDTO> loadSocialMedia(int CVID) {
        String sql = "SELECT SocialMediaID, "
                + "SocialMediaLink, "
                + "PlatformName "
                + "FROM CV_SocialMedia "
                + "JOIN [Platform] "
                + "ON CV_SocialMedia.PlatformID = [Platform].PlatformID "
                + "WHERE CVID = ?;";
        try {
            ArrayList<SocialMediaDTO> list = new ArrayList<>();
            System.out.println(sql);
            Connection cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(CVID));
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                SocialMediaDTO dto = new SocialMediaDTO();
                System.out.println(rs.toString());
                dto.setSocialMediaID(rs.getInt("SocialMediaID"));
                dto.setSocialMediaLink(rs.getString("SocialMediaLink"));
                dto.setPlatformName(rs.getString("PlatformName"));
                dto.setCVID(CVID);
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
}
