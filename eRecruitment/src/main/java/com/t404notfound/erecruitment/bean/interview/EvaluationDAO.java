/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;

/**
 *
 * @author Savoy
 */
public class EvaluationDAO {

    public static ArrayList<EvaluationDTO> getEvaluations(String email)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "SELECT Evaluation.InterviewID, u2.FirstName, u2.LastName, Evaluation.EvaluationDescription, Evaluation.Score\n"
                + "FROM [User] u1 JOIN Participant ON u1.UserID = Participant.UserID\n"
                + "JOIN InterviewResult ON Participant.ResultID = InterviewResult.ResultID\n"
                + "JOIN Evaluation ON Participant.ParticipantID = Evaluation.ParticipantID\n"
                + "JOIN [Application] ON [Application].UserID = u1.UserID\n"
                + "JOIN ApplicationStatus ON [Application].StatusID = ApplicationStatus.StatusID\n"
                + "JOIN UserStatus ON u1.Status = UserStatus.StatusID\n"
                + "JOIN [User] u2 ON u2.UserID = Evaluation.InterviewerID\n"
                + "WHERE u1.Email = ?\n"
                + "AND (InterviewResult.ResultID = 3)\n"
                + "AND (UserStatus.StatusName = 'Active')\n"
                + "AND ([Application].StatusID = 1 OR [Application].StatusID = 3 OR [Application].StatusID = 4)";

        ArrayList<EvaluationDTO> evaluations = new ArrayList<>();
        Connection conn = null;
        PreparedStatement PreS = null;
        ResultSet ReS = null;

        try {
            conn = DBUtil.getConnection();
            PreS = conn.prepareCall(SQLQuery);
            PreS.setString(1, email);
            ReS = PreS.executeQuery();
            while (ReS.next()) {
                EvaluationDTO evaluation = new EvaluationDTO(ReS.getInt(1), ReS.getString(2), ReS.getString(3), ReS.getString(4), ReS.getInt(5));
                evaluations.add(evaluation);
            }
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (PreS != null) {
                PreS.close();
            }
            if (ReS != null) {
                ReS.close();
            }
        }
        return evaluations;
    }
}
