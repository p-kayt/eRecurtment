/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

import Util.DBUtil;
import static com.t404notfound.erecruitment.bean.AdminUserDAO.checkBooleanRoles;
import com.t404notfound.erecruitment.bean.AdminUserDTO;
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
public class ManagerParticipantDAO {

    public static double calculateAverageScore(ManagerParticipantDTO p) {
        return p.score / p.count;
    }

    public static ArrayList<ManagerParticipantDTO> getParticipants(String searchValue)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "SELECT [User].UserID, [User].Email, [User].FirstName, [User].LastName, Gender.GenderName, AVG(CAST(Evaluation.Score AS float)) AS AvgScore, COUNT(Evaluation.Score) AS CountInterview, InterviewResult.ResultName, ApplicationStatus.StatusName\n"
                + "FROM [User] JOIN Participant ON [User].UserID = Participant.UserID\n"
                + "JOIN InterviewResult ON Participant.ResultID = InterviewResult.ResultID\n"
                + "JOIN Gender ON [User].Gender = Gender.GenderID\n"
                + "JOIN Evaluation ON Participant.ParticipantID = Evaluation.ParticipantID\n"
                + "JOIN [Application] ON [Application].UserID = [User].UserID\n"
                + "JOIN ApplicationStatus ON [Application].StatusID = ApplicationStatus.StatusID\n"
                + "WHERE ([User].FirstName LIKE ? OR [User].LastName LIKE ?)\n"
                + "AND (InterviewResult.ResultID = 3)\n"
                + "AND ([Application].StatusID = 1 OR [Application].StatusID = 3 OR [Application].StatusID = 4)\n"
                + "GROUP BY Evaluation.InterviewID, Participant.UserID, [User].UserID, [User].Email, [User].FirstName, [User].LastName, Gender.GenderName, InterviewResult.ResultName, ApplicationStatus.StatusName";
        ArrayList<ManagerParticipantDTO> participants = new ArrayList<>();
        Connection conn = null;
        PreparedStatement PreS = null;
        ResultSet ReS = null;

        try {
            conn = DBUtil.getConnection();
            PreS = conn.prepareCall(SQLQuery);
            PreS.setString(1, "%" + searchValue + "%");
            PreS.setString(2, "%" + searchValue + "%");
            ReS = PreS.executeQuery();
            while (ReS.next()) {
                ManagerParticipantDTO participant = new ManagerParticipantDTO(ReS.getInt(1), ReS.getString(2), ReS.getString(3), ReS.getString(4), ReS.getString(5), ReS.getDouble(6), ReS.getInt(7), ReS.getString(8), ReS.getString(9));
                participants.add(participant);

                if (!participants.isEmpty()) {
                    int count = 0;
                    for (ManagerParticipantDTO p : participants) {
                        if (p.userID == participant.userID) {
                            count++;
                            p.score = p.score + participant.score;
                            p.score = calculateAverageScore(p);
                        }
                    }
                    if (count != 1) {
                        participants.remove(participant);
                    }
                }
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
        return participants;
    }

    public static boolean updateStatus(String email, int status)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "UPDATE [Application] SET [Application].StatusID = ?\n"
                + "FROM [Application] JOIN [User] ON [Application].UserID = [User].UserID\n"
                + "WHERE [User].Email = ?";
        Connection conn = null;
        PreparedStatement PreS = null;
        boolean result = false;
        try {
            conn = DBUtil.getConnection();
            PreS = conn.prepareCall(SQLQuery);
            PreS.setInt(1, status);
            PreS.setString(2, email);
            final int affectedRow = PreS.executeUpdate();
            if (affectedRow > 0) {
                result = true;
            }
        } catch (SQLException ex) {
        } finally {
            if (conn != null) {
                conn.close();
            }
            if (PreS != null) {
                PreS.close();
            }
        }
        return result;
    }

}
