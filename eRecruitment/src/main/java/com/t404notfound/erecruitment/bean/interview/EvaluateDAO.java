/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author MINH TRI
 */
public class EvaluateDAO {

    public boolean addEvaluation(String description, int score, int interviewerID, int candidateID, int interviewID) {
        String sql = "INSERT INTO Evaluation(EvaluationDescription, Score, InterviewerID, ParticipantID, InterviewID)\n"
                + "VALUES (?, ?, ?, ?, ?)";
        EvaluateDTO tmp = null;
        ParticipantDAO participantDAO = new ParticipantDAO();

        try {

            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, description);
            ps.setInt(2, score);
            ps.setInt(3, interviewerID);
            ps.setInt(4, candidateID);
            ps.setInt(5, interviewID);

            int rs = ps.executeUpdate();

            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateEvaluation(String description, int score, int interviewerID, int candidateID, int interviewID) {
        String sql = "UPDATE Evaluation\n"
                + "SET EvaluationDescription = ?, Score = ?\n"
                + "WHERE InterviewerID = ?  AND InterviewID = ? AND ParticipantID = ?";

        EvaluateDTO tmp = null;
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, description);
            ps.setInt(2, score);
            ps.setInt(3, interviewerID);
            ps.setInt(4, interviewID);
            ps.setInt(5, candidateID);

            int rs = ps.executeUpdate();

            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public EvaluateDTO getEvaluationByID(int evaluationID) {
        String sql = "SELECT EvaluationID, EvaluationDescription, Score, InterviewerID, ParticipantID, InterviewID \n"
                + " FROM Evaluation\n"
                + " WHERE EvaluationID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, evaluationID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String description = rs.getString("EvaluationDescription");
                int score = rs.getInt("Score");
                int interviewerID = rs.getInt("interviewerID");
                int participantID = rs.getInt("ParticipantID");
                int interviewID = rs.getInt("InterviewID");

                EvaluateDTO tmp = new EvaluateDTO(evaluationID, description, score, interviewerID, participantID, interviewID);
                return tmp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int getNewestEvaluation() {
        String sql = "SELECT MAX(EvaluationID) as EvaluationID\n"
                + " FROM Evaluation";
        int id = 0;
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                id = rs.getInt("EvaluationID");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    public boolean checkEvaluation(int interviewerID, int candidateID, int interviewID) {
        String sql = "SELECT * FROM Evaluation\n"
                + "WHERE InterviewID = ? AND InterviewerID = ? AND ParticipantID = ?";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ps.setInt(2, interviewerID);
            ps.setInt(3, candidateID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //get Evaluation of a candidate that an interviewer has evalauted in an interview
    public EvaluateDTO getEvaluationOfCandidateOfInterviewer(int interviewID, int interviewerID, int candidateID) {
        String sql = "SELECT e.EvaluationID, e.EvaluationDescription, e.Score, e.InterviewerID, e.ParticipantID, e.InterviewID \n"
                + "FROM Evaluation e\n"
                + "WHERE InterviewID = ? AND InterviewerID = ? AND ParticipantID = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ps.setInt(2, interviewerID);
            ps.setInt(3, candidateID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String description = rs.getString("EvaluationDescription");
                int participantID = rs.getInt("ParticipantID");
                int evaluationID = rs.getInt("EvaluationID");
                int score = rs.getInt("Score");

                EvaluateDTO tmp = new EvaluateDTO(evaluationID, description, score, interviewerID, participantID, interviewID);
                return tmp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //get Evaluation of interviewer in an interview
    public ArrayList<EvaluateDTO> getEvaluation(int interviewerID, int interviewID) {
        String sql = "SELECT e.EvaluationID, e.EvaluationDescription, e.Score, e.InterviewerID, e.ParticipantID, e.InterviewID \n"
                + "FROM Evaluation e\n"
                + "INNER JOIN Participant p\n"
                + "ON e.ParticipantID = p.UserID AND e.InterviewerID = ? and e.InterviewID = ?\n"
                + "Order by p.UserID asc";
        ArrayList<EvaluateDTO> evaluate = new ArrayList<>();

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewerID);
            ps.setInt(2, interviewID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String description = rs.getString("EvaluationDescription");
                int participantID = rs.getInt("ParticipantID");
                int evaluationID = rs.getInt("EvaluationID");
                int score = rs.getInt("Score");

                EvaluateDTO tmp = new EvaluateDTO(evaluationID, description, score, interviewerID, participantID, interviewID);
                evaluate.add(tmp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return evaluate;
    }

    //get all evaluation of a candidate
    public ArrayList<EvaluateDTO> getEvaluationOfCandidate(int interviewID, int candidateID) {
        ArrayList<EvaluateDTO> evaluation = new ArrayList<>();
        String sql = "SELECT EvaluationID, EvaluationDescription, Score, InterviewerID, ParticipantID, InterviewID\n"
                + " FROM Evaluation\n"
                + " WHERE InterviewID = ? AND ParticipantID =?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, interviewID);
            ps.setInt(2, candidateID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String description = rs.getString("EvaluationDescription");
                int interviewerID = rs.getInt("InterviewerID");
                int participantID = rs.getInt("ParticipantID");
                int evaluationID = rs.getInt("EvaluationID");
                int score = rs.getInt("Score");

                EvaluateDTO tmp = new EvaluateDTO(evaluationID, description, score, interviewerID, participantID, interviewID);
                evaluation.add(tmp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return evaluation;
    }
}
