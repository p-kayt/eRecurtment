/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

import Util.DBUtil;
import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
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
    public boolean addCandidate(int userID, int interviewID, String time, int resultID) {
        //if user exists, then return false
        if (!checkCandidate(userID, interviewID)) {
            String sql = "INSERT INTO Participant (UserID, InterviewID, InterviewTime, ResultID) "
                    + " VALUES (?, ?, ?, ?)";

            try {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, userID);
                ps.setInt(2, interviewID);
                ps.setString(3, time);
                ps.setInt(4, resultID);
                //time must be in format yyyy-mm-yy hh:mm:ss
                int rs = ps.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            } catch (Exception e) {
                System.out.println("Error when add candidate.");
                e.printStackTrace();
            }
        }
        return false;
    }

    //Get all the candidate of an interview
    public ArrayList<ParticipantDTO> getParticipant(int interviewID) {
        ArrayList<ParticipantDTO> list = new ArrayList<>();
        String sql = "SElECT * FROM Participant "
                + " WHERE InterviewID = ?";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userID = rs.getInt("UserID");
                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime");
                /* Convert date to String using DateFormat*/
                int resultID = rs.getInt("ResultID");
                ParticipantDTO tmp = new ParticipantDTO(userID, interviewID, time, resultID);
                list.add(tmp);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public ArrayList<UserDTO> getListCandidate(int interviewID) {

        ArrayList<UserDTO> list = new ArrayList<>();
        UserDAO dao = new UserDAO();

        String sql = "SELECT UserID "
                + " FROM Participant "
                + " WHERE InterviewID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userID = rs.getInt("UserID");

                UserDTO tmp = dao.getUserByID(userID);
                list.add(tmp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
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

    //testing
    public ArrayList<UserDTO> getAvailablePariticipant(int postID, int stageID) {
        ArrayList<UserDTO> list = new ArrayList<>();
        UserDAO userDAO = new UserDAO();

        /*Select all UserIDs that have same postD and stageID and not exist in
        any intevriew of this stage*/
        String sql = "SELECT DISTINCT UserID \n"
                + "FROM [Application]\n"
                + "WHERE PostID = ? AND StageID = ? And UserID NOT IN ( \n"
                + "		SELECT UserID FROM Participant\n"
                + "		WHERE InterviewID IN (SELECT DISTINCT InterviewID FROM Interview\n"
                + "		WHERE PostID = ? AND StageID = ?));";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, postID);
            ps.setInt(2, stageID);
            ps.setInt(3, postID);
            ps.setInt(4, stageID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userID = rs.getInt("UserID");
                UserDTO tmp = userDAO.getUserByID(userID);
                list.add(tmp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        ParticipantDAO dao = new ParticipantDAO();
        ArrayList<UserDTO> list = dao.getAvailablePariticipant(1, 1);
        System.out.println("===============================================================");
        for (UserDTO u : list) {
            System.out.println(u.toString());
        }
        System.out.println("===============================================================");
    }
}
