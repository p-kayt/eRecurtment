/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author MINH TRI
 */
public class InterviewDAO {

    //Test ok roi
    public boolean createAnInterview(String description, int formatID,
            String link, String address, String time, int stageID, int postID,
            int inteviewStatusID, int bookerID) {
        String sql = "INSERT INTO Interview ([Description], OnlineLink, [Address], InterviewTime, "
                + " StageID, PostID, FormatID, StatusID, BookerID) "
                + " VALUES (?, ?, ?, ?, ?,?,?,?,?) ";

        try {
            Connection con = Util.DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setNString(1, description);
            ps.setString(2, link);
            ps.setNString(3, address);

            // time must be in format 'yyyy-mm-dd hh:mm:ss'
            ps.setString(4, time);
            ps.setInt(5, stageID);
            ps.setInt(6, postID);
            ps.setInt(7, formatID);
            ps.setInt(8, inteviewStatusID);
            ps.setInt(9, bookerID);

            int result = ps.executeUpdate();
            if (result != 0) {
                return true;
            } else {
                throw new Exception();
            }

        } catch (Exception e) {
            System.out.println("Error when create interview.");
            e.printStackTrace();
            return false;
        }
    }

    //test ok
    public InterviewDTO getInterview(int interviewID) {

        String sql = "SELECT * FROM Interview "
                + " WHERE InterviewID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String pattern = "YYYY/mm/dd HH:mm:ss";
                DateFormat df = new SimpleDateFormat(pattern);
                String time = df.format(rs.getDate("InterviewTime"));
                /* Convert date to String using DateFormat*/

                int stageID = rs.getInt("StageID");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int statusID = rs.getInt("StatusID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, stageID, postID, statusID, bookerID);
                return tmp;
            }
        } catch (Exception e) {
            System.out.println("Error when query interview.");
            e.printStackTrace();
        }
        return null;
    }

    public boolean checkInterview(int interviewID) {
        String sql = "SELECT * FROM Interview "
                + " WHERE InterviewID = ?";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error when query interview.");
            e.printStackTrace();
        }
        return false;
    }

    //test delete Interview
    public boolean deleteInterview(int interviewID) {
        if (checkInterview(interviewID)) {
            String sql = "DELETE Interview "
                    + " WHERE InterviewID = ?";
            try {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, interviewID);
                int rs = ps.executeUpdate();
                if(rs != 0) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public static void main(String[] args) {
        InterviewDAO dao = new InterviewDAO();
        String description = "Phỏng vấn sơ bộ vị trí Marketing.";
        int formatID = 1;
        String link = null;
        String address = null;
        String time = "2013-12-01 12:30:00";
        int stageID = 1;
        int postID = 5;
        int inteviewStatusID = 1;
        int bookerID = 1;

        System.out.println(dao.createAnInterview(description, formatID, link, address, time, stageID, postID, inteviewStatusID, bookerID));

        System.out.println(dao.getInterview(6).toString());
        
        System.out.println(dao.deleteInterview(6));
    }
}
