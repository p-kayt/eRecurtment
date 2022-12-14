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
import java.sql.SQLException;
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
                String time = rs.getString("InterviewTime").split("\\.")[0];
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

            Connection con = null;

            try {
                con = DBUtil.getConnection();
                con.setAutoCommit(false);
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, interviewID);
                int rs = ps.executeUpdate();
                if (rs == 0) {
                    return false;
                }
                con.commit();
                return true;
            } catch (Exception e) {
                e.printStackTrace();
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
                String time = rs.getString("InterviewTime").split("\\.")[0];
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
                String time = rs.getString("InterviewTime").split("\\.")[0];
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

    //format of interview stage is (ID; description)
    public ArrayList<String> getInterviewStage(int postID) {
        ArrayList<String> list = new ArrayList<>();
        String sql = " SELECT ID, [Description]\n"
                + " FROM Application_Stage\n"
                + " WHERE StageID = 2 AND PostID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, postID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String interviewStage = rs.getInt("ID") + ";" + rs.getString("Description");
                list.add(interviewStage);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //get interview stage name by stageID
    public String getInterviewStageNameByID(int stageID) {
        String sql = " SELECT ID, [Description]\n"
                + " FROM Application_Stage\n"
                + " WHERE ID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String interviewStage = rs.getInt("ID") + ";" + rs.getString("Description");
                return interviewStage;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

    //get status name by ID
    public String getInterviewStatus(int statusID) {
        String sql = " SELECT StatusName\n"
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

    //get format name by ID
    public String getInterviewFormat(int formatID) {
        String sql = " SELECT FormatName\n"
                + " FROM InterviewFormat\n"
                + " WHERE FormatID = ?";
        String formatName = "";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, formatID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                formatName = rs.getString("FormatName");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return formatName;
    }

    //get interview stage
    public String getInterviewStageByID(int stageID) {

        String sql = " SELECT ID, [Description]\n"
                + " FROM Application_Stage\n"
                + " WHERE ID = ?";
        String stage = "";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                stage = rs.getInt("ID") + ";" + rs.getString("Description");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return stage;
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

    //get all interview by status ID
    public ArrayList<InterviewDTO> getInterviewByStatus(int statusID) {
        ArrayList<InterviewDTO> list = new ArrayList<>();

        String sql = " SELECT * FROM Interview\n"
                + " WHERE StatusID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, statusID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int interviewID = rs.getInt("InterviewID");
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime").split("\\.")[0];
                /* Convert date to String using DateFormat*/

                int maxCandidate = rs.getInt("MaxCandidate");
                int stageID = rs.getInt("StageID");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCandidate, stageID, postID, statusID, bookerID);
                list.add(tmp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //get all interview by status ID of an interviewer or hr staff
    public ArrayList<InterviewDTO> getInterviewOfInterviewerByStatus(int interviewerID, int statusID) {
        ArrayList<InterviewDTO> list = new ArrayList<>();

        String sql = " SELECT * FROM Interview\n"
                + "WHERE StatusID = ?  AND InterviewID IN (SELECT DISTINCT InterviewID\n"
                + "					FROM Interviewer\n"
                + "					WHERE UserID = ?)";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, statusID);
            ps.setInt(2, interviewerID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int interviewID = rs.getInt("InterviewID");
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime").split("\\.")[0];
                /* Convert date to String using DateFormat*/

                int maxCandidate = rs.getInt("MaxCandidate");
                int stageID = rs.getInt("StageID");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCandidate, stageID, postID, statusID, bookerID);
                list.add(tmp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //get all interview by status ID of an canididate or hr staff
    public ArrayList<InterviewDTO> getInterviewOfCandidateByStatus(int candidateID, int statusID) {
        ArrayList<InterviewDTO> list = new ArrayList<>();

        String sql = " SELECT * FROM Interview\n"
                + " WHERE StatusID = ?  AND InterviewID IN (SELECT DISTINCT InterviewID\n"
                + " FROM Participant\n"
                + " WHERE UserID = ?)";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, statusID);
            ps.setInt(2, candidateID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int interviewID = rs.getInt("InterviewID");
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime").split("\\.")[0];
                /* Convert date to String using DateFormat*/

                int maxCandidate = rs.getInt("MaxCandidate");
                int stageID = rs.getInt("StageID");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCandidate, stageID, postID, statusID, bookerID);
                list.add(tmp);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    //get result of candidate 
    public String getResultOfCandidate(int candidateID, int interviewID) {
        String sql = "SELECT ResultName \n"
                + "FROM InterviewResult\n"
                + " WHERE ResultID = (SELECT ResultID \n"
                + " FROM Participant\n"
                + " WHERE UserID = ? AND InterviewID = ?)";
        String resultName = "";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, candidateID);
            ps.setInt(2, interviewID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                resultName = rs.getString("ResultName");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultName;
    }

    //get interview time of a canidate 
    public String getCandidateInterviewTime(int candidateID, int interviewID) {
        String sql = "SELECT InterviewTime\n"
                + " FROM Participant\n"
                + " WHERE UserID = ? AND InterviewID = ?";
        String time = "";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, candidateID);
            ps.setInt(2, interviewID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                time = rs.getString("InterviewTime").split("\\.")[0];
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return time;
    }

    //get all interview of a stage in a post
    public ArrayList<InterviewDTO> getInterviewByStageID(int stageID) {
        ArrayList<InterviewDTO> interviewList = new ArrayList<>();
        String sql = "SELECT * FROM Interview "
                + " WHERE StageID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int interviewID = rs.getInt("InterviewID");
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime").split("\\.")[0];
                /* Convert date to String using DateFormat*/
                int maxCadidate = rs.getInt("MaxCandidate");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int statusID = rs.getInt("StatusID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCadidate, stageID, postID, statusID, bookerID);
                interviewList.add(tmp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return interviewList;
    }

    //get all interview of a stage in a post by status (Booked, have occured or cancel)
    public ArrayList<InterviewDTO> getInterviewByStageIDAndStatusID(int stageID, int statusID) {
        ArrayList<InterviewDTO> interviewList = new ArrayList<>();
        String sql = "SELECT * FROM Interview "
                + " WHERE StageID = ? AND StatusID  = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, stageID);
            ps.setInt(2, statusID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int interviewID = rs.getInt("InterviewID");
                String description = rs.getString("Description");
                String link = rs.getString("OnlineLink");
                String address = rs.getString("Address");

                /* Convert date to String using DateFormat*/
                String time = rs.getString("InterviewTime").split("\\.")[0];
                /* Convert date to String using DateFormat*/
                int maxCadidate = rs.getInt("MaxCandidate");
                int postID = rs.getInt("PostID");
                int formatID = rs.getInt("FormatID");
                int bookerID = rs.getInt("BookerID");

                InterviewDTO tmp = new InterviewDTO(interviewID, description, formatID, link, address, time, maxCadidate, stageID, postID, statusID, bookerID);
                interviewList.add(tmp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return interviewList;
    }

    //get interview stageName of a post format ("stageID;desctiption")
    public ArrayList<String> getInterviewStagesOfAPost(int postID) {
        ArrayList<String> stage = new ArrayList<>();

        String sql = "SELECT *\n"
                + "FROM Application_Stage\n"
                + "WHERE StageID = 2 AND PostID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, postID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int stageID = rs.getInt("ID");
                String des = rs.getString("Description");

                String stageName = stageID + ";" + des;
                stage.add(des);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return stage;
    }

    //get application id of a user by postID
    public int getApplicationID(int candidateID, int postID) {
        String sql = "SELECT ApplicationID FROM [Application]\n"
                + "WHERE UserID = ? and PostID = ?";
        
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, candidateID);
            ps.setInt(2, postID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("ApplicationID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

}
