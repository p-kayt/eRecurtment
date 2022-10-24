/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

import Util.DBUtil;
import java.net.ConnectException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

/**
 *
 * @author MINH TRI
 */
public class ParticipantDAO {

    //Add a candidate to aninterview
    public boolean addCandidate(int userID, int interviewID, String time) {
        //if user exists, then return false
        if (!checkCandidate(userID, interviewID)) {
            String sql = "INSERT INTO Participant (UserID, InterviewID, InterviewTime) "
                    + " VALUES (?, ?, ?)";

            try {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, userID);
                ps.setInt(2, interviewID);
                ps.setString(3, time);
                //time must be in format yyyy-mm-yy hh:mm:ss
                int rs = ps.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    //Get all the candidate of an interview
    public ArrayList<ParticipantDTO> getCandidate(int interviewID) {
        ArrayList<ParticipantDTO> list = new ArrayList<>();
        String sql = "SElECT * FROM Participant "
                + " WHERE InterviewID = ?";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userID = rs.getInt("UserID");
                /* Convert date to String using DateFormat*/
                String pattern = "YYYY/mm/dd HH:mm:ss";
                DateFormat df = new SimpleDateFormat(pattern);
                String time = df.format(rs.getDate("InterviewTime"));
                /* Convert date to String using DateFormat*/
                ParticipantDTO tmp = new ParticipantDTO(userID, interviewID, time);
                list.add(tmp);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //Remove candidate out of interview
    public boolean removeCandidate(int userID, int interviewID) {
        String sql = "DELETE Participant "
                + " WHERE UserID = ? AND InterviewID = ? ";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, interviewID);
            int rs = ps.executeUpdate();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
            // if exception ouccur then return false
        }
    }

    //check if candidate existed or not
    public boolean checkCandidate(int userID, int interviewID) {
        String sql = "SElECT * FROM Participant "
                + " WHERE UserID = ? AND InterviewID = ? ";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, interviewID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}