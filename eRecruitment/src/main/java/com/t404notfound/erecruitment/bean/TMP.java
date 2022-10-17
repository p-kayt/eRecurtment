//public void saveAchievement(ArrayList<AchievementDTO> achievementList, int CVID) {
//        String sql = "INSERT INTO CV_Achievement( "
//                + "AchievementName, "
//                + "AchievementLink, "
//                + "CVID "
//                + ") VALUES (?,?,?) ";
//        try {
//            for (AchievementDTO x : achievementList) {
//                Connection con = DBUtil.getConnection();
//                PreparedStatement ps = con.prepareStatement(sql);
//                ps.setString(1, x.getAchievementName());
//                ps.setString(2, x.getAchievementLink());
//                ps.setInt(3, CVID);
//
//                ps.execute();
//            }
//
//        } catch (SQLException e) {
//            System.out.print("CV save error: " + e.getMessage());
//        }
//    }

import Util.DBUtil;
import com.t404notfound.erecruitment.bean.cv.AchievementDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

