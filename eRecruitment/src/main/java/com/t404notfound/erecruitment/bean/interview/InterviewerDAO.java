/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

import Util.DBUtil;
import com.t404notfound.erecruitment.bean.UserDAO;
import com.t404notfound.erecruitment.bean.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author MINH TRI
 */
public class InterviewerDAO {

    //Add an interviewer to a interview
    public boolean addInterviewer(int userID, int interviewID) {

        //If interviewer exist then return false
        if (!checkInterviewer(userID, interviewID)) {
            String sql = "INSERT INTO Interviewer (UserID, InterviewID) "
                    + " VALUES (?, ?)";
            try {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, userID);
                ps.setInt(2, interviewID);
                int rs = ps.executeUpdate();
                if (rs > 0) {
                    return true;
                }
            } catch (Exception e) {
                System.out.println("Error when add interviewer.");
                e.printStackTrace();
            }
        }
        return false;
    }

    //Get all interviewer of an interview
    //Test ok
    public ArrayList<UserDTO> getInterviewer(int interviewID) {

        ArrayList<UserDTO> list = new ArrayList<>();
        ArrayList<Integer> listID = new ArrayList<>();
        UserDAO dao = new UserDAO();

        String sql = "SELECT UserID "
                + " FROM Interviewer "
                + " WHERE InterviewID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userID = rs.getInt("UserID");

                listID.add(userID);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (listID.size() > 0) {
            for (int i = 0; i < listID.size(); i++) {
                UserDTO user = dao.getUserByID(listID.get(i));
                list.add(user);
            }
        }

        return list;
    }

    //get all inteviewerID in this interview
    public ArrayList<Integer> getInterviewerID(int interviewID) {
        ArrayList<Integer> list = new ArrayList<>();

        String sql = "SELECT * FROM Interviewer "
                + " WHERE InterviewID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int userID = rs.getInt("UserID");
                list.add(userID);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    //remove interviewer from an interview
    public boolean removeInterviewer(int userID, int interviewID) {
        String sql = "DELETE Interviewer "
                + " WHERE UserID = ? AND InterviewID = ? ";
        Connection con = null;
        try {
            con = DBUtil.getConnection();
            con.setAutoCommit(false);
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, interviewID);
            int rs = ps.executeUpdate();
            if (rs == 0) {
                return false;
            }
            con.commit();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
    }

    //check if interviewer existed or not
    public boolean checkInterviewer(int userID, int interviewID) {
        String sql = "SElECT * FROM Interviewer "
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

    //get all interviewer that does not exist in an interview
    public ArrayList<UserDTO> getAvailableInterviewer(int interviewID) {
        ArrayList<UserDTO> interviewerList = new ArrayList<>();
        ArrayList<Integer> availableInterviewerIDList = new ArrayList<>();

        UserDAO userDAO = new UserDAO();

        //Get all InterviewID that not exist in this interview
        String sql = " SELECT u.[UserID] "
                + " FROM [User_Role] u "
                + " WHERE (u.RoleID = 4 OR u.RoleID = 2) AND u.UserID NOT IN (SELECT i.[UserID] "
                + " FROM Interviewer i "
                + " WHERE InterviewID = ?) ";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("UserID");
                availableInterviewerIDList.add(id);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (availableInterviewerIDList.size() > 0) {
            for (int i = 0; i < availableInterviewerIDList.size(); i++) {
                UserDTO user = userDAO.getUserByID(availableInterviewerIDList.get(i));
                interviewerList.add(user);
            }
        }

        return interviewerList;
    }

    public static void main(String[] args) {
        InterviewerDAO dao = new InterviewerDAO();
        ArrayList<UserDTO> test = dao.getAvailableInterviewer(11);

        System.out.println("List");
        for (UserDTO userDTO : test) {
            userDTO.toString();
            System.out.println(userDTO.toString() + "\n");
        }
        System.out.println("======================");
        test = dao.getInterviewer(2);
        System.out.println("List interviewer");
        for (UserDTO userDTO : test) {
            userDTO.toString();
            System.out.println(userDTO.toString() + "\n");
        }
        System.out.println("======================");
    }

}
