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
import java.util.ArrayList;

/**
 *
 * @author MINH TRI
 */
public class InterviewDAO {

    //Test ok roi
    public boolean createAnInterview(String description, String link, String address,
            String time, int maxCandidate, int stageID, int postID, int formatID,
            int bookerID) {
        String sql = "INSERT INTO Interview ([Description], OnlineLink, [Address], InterviewTime, MaxCandidate, "
                + " StageID, PostID, FormatID, StatusID, BookerID) "
                + " VALUES (?, ?, ?, ?, ?, ?,?,?,1,?) ";

        try {
            Connection con = Util.DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setNString(1, description);
            ps.setString(2, link);
            ps.setNString(3, address);

            // time must be in format 'yyyy-mm-dd hh:mm:ss'
            ps.setString(4, time);
            ps.setInt(5, maxCandidate);
            ps.setInt(6, stageID);
            ps.setInt(7, postID);
            ps.setInt(8, formatID);
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
                String time = rs.getString("InterviewTime");
                /* Convert date to String using DateFormat*/
                int maxCadidate = rs.getInt("MaxCandidate");
                int stageID = rs.getInt("StageID");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int statusID = rs.getInt("StatusID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCadidate, stageID, postID, statusID, bookerID);
                return tmp;
            }
        } catch (Exception e) {
            System.out.println("Error when query interview.");
            e.printStackTrace();
        }
        return null;
    }

    public int getNewestInterview() {
        int interviewID = 0;
        String sql = "SELECT MAX(InterviewID) as InterviewID "
                + " FROM Interview";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                interviewID = rs.getInt("InterviewID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return interviewID;
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

    //test delete Interview ok
    //need test again
    public boolean deleteInterview(int interviewID) {
        if (checkInterview(interviewID)) {
            String sql = "DELETE Interview "
                    + " WHERE InterviewID = ?";
            try {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, interviewID);
                int rs = ps.executeUpdate();
                if (rs != 0) {
                    return true;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public InterviewDTO updateInterview(int interviewID, String description, String link, String address,
            String time, int maxCandidate, int stageID, int formatID, int statusID) {

        if (checkInterview(interviewID)) {
            String sql = "UPDATE Interview "
                    + " SET [Description] = ?, OnlineLink = ?, [Address] = ?, InterviewTime = ?, MaxCandidate = ?, StageID =?, "
                    + " FormatID = ?, StatusID = ? "
                    + " WHERE InterviewID = ? ";

            try {
                Connection con = DBUtil.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setNString(1, description);
                ps.setString(2, link);
                ps.setString(3, address);
                ps.setString(4, time);
                ps.setInt(5, maxCandidate);
                ps.setInt(6, stageID);
                ps.setInt(7, formatID);
                ps.setInt(8, statusID);
                ps.setInt(9, interviewID);

                int rs = ps.executeUpdate();
                if (rs > 0) {
                    return getInterview(interviewID);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    //get interview list
    //test OK
    public ArrayList<InterviewDTO> getInterviewList() {
        ArrayList<InterviewDTO> list = new ArrayList<>();
        String sql = " SELECT * FROM [Interview] ";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int interviewID = rs.getInt("InterviewID");
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime");
                /* Convert date to String using DateFormat*/

                int maxCandidate = rs.getInt("MaxCandidate");
                int stageID = rs.getInt("StageID");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int statusID = rs.getInt("StatusID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCandidate, stageID, postID, statusID, bookerID);
                list.add(tmp);
            }
            return list;

        } catch (Exception e) {
            System.out.println("Error when get interview list.");
            e.printStackTrace();
        }
        return list;
    }

    //test ok
    public ArrayList<InterviewDTO> getCreatedInterview(int bookerID) {
        ArrayList<InterviewDTO> list = new ArrayList<>();

        String sql = " SELECT [InterviewID], [Description], OnlineLink, [Address], InterviewTime, MaxCandidate, StageID, PostID, FormatID, StatusID, BookerID\n"
                + " FROM Interview "
                + " WHERE BookerID = ? ";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, bookerID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int interviewID = rs.getInt("InterviewID");
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime");
                /* Convert date to String using DateFormat*/

                int maxCandidate = rs.getInt("MaxCandidate");
                int stageID = rs.getInt("StageID");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int statusID = rs.getInt("StatusID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCandidate, stageID, postID, statusID, bookerID);
                list.add(tmp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<String> getInterviewStage(int postID) {
        ArrayList<String> list = new ArrayList<>();
        String sql = " SELECT [Description]\n"
                + " FROM Application_Stage\n"
                + " WHERE StageID = 2 AND PostID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, postID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String interviewStage = rs.getString("Description");
                list.add(interviewStage);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<String> getInterviewStatus() {
        ArrayList<String> list = new ArrayList<>();
        String sql = " SELECT StatusName\n"
                + " FROM InterviewStatus ";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String interviewStatus = rs.getString("StatusName");
                list.add(interviewStatus);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<String> getInterviewFormat() {
        ArrayList<String> list = new ArrayList<>();
        String sql = " SELECT FormatName \n"
                + " FROM InterviewFormat";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String interviewStatus = rs.getString("FormatName");
                list.add(interviewStatus);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getInteviewStage(int postID, int stageIndex) {
        ArrayList<String> list = new ArrayList<>();
        String sql = " SELECT [Description]  \n"
                + " FROM Application_Stage\n"
                + " WHERE PostID = ? AND StageID = 2 ";
        String stageName = "";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, postID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String stage = rs.getString("Description");
                list.add(stage);
            }
            
            stageName = list.get(stageIndex - 1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stageName;
    }

    public String getInteviewStatus(int statusID) {
        String sql = " SELECT StatusName \n"
                + " FROM InterviewStatus\n"
                + " WHERE StatusID = ?";
        String statusName = "";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, statusID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                statusName = rs.getString("StatusName");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return statusName;
    }

    public static void main(String[] args) {
        InterviewDAO dao = new InterviewDAO();
        String description = "Phỏng vấn sơ bộ vị trí Marketing.";
        int formatID = 1;
        String link = null;
        String address = null;
        String time = "2013-12-01 12:30";
        int maxCandidate = 10;
        int stageID = 1;
        int postID = 1;
        int inteviewStatusID = 1;
        int bookerID = 1;
        int interviewID = 8;

//        System.out.println(dao.createAnInterview(description, formatID, link, address, time, stageID, postID, bookerID));
//
//        System.out.println(dao.deleteInterview(6));
//
//        link = "https://abc.com";
//        InterviewDTO t = dao.updateInterview(interviewID, description, formatID, link, address, time, stageID, inteviewStatusID);
//        System.out.println(t.toString());
        System.out.println("=====================================================================================");
//        ArrayList<InterviewDTO> li = dao.getInterviewList();
//        System.out.println("List interview: ");
//        for (InterviewDTO o : li) {
//            System.out.println(o.toString());
//        }
        System.out.println(dao.getNewestInterview());
        ArrayList<String> status = dao.getInterviewStatus();
        for (String s : status) {
            System.out.println(s);
        }

        System.out.println("=====================================================================================");
        ArrayList<InterviewDTO> createdList = dao.getCreatedInterview(1);
        for (InterviewDTO i : createdList) {
            System.out.println("ID: " + i.getInterviewID() + "to String: " + i.toString());
        }
        System.out.println("=====================================================================================");
        ArrayList<InterviewDTO> getList = dao.getCreatedInterview(4);
        for (InterviewDTO i : getList) {
            System.out.println("ID: " + i.getInterviewID() + "to String: " + i.toString());
        }
    }
}
