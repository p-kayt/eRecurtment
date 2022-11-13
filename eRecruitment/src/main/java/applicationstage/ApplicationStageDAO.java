/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package applicationstage;

import Util.DBUtil;
import com.t404notfound.erecruitment.bean.application.ApplicationDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Huu Minh
 */
public class ApplicationStageDAO {
    private static Connection cn;

    public ApplicationStageDAO() {
    }

    public ArrayList<ApplicationStageDTO> listAllApplicationStage() {
        String sql = "select ID, [Description], PostID, StageID from Application_Stage";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            ArrayList<ApplicationStageDTO> list = new ArrayList<>();
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationStageDTO dto = new ApplicationStageDTO();
                dto.setId(rs.getInt("ID"));
                dto.setDescription(rs.getNString("[Description]"));
                dto.setPostID(rs.getInt("PostID"));
                dto.setStageID(rs.getInt("StageID"));
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return null;
    }
    
    public ArrayList<ApplicationStageDTO> listAllApplicationStageByPostID(int postID) {
        String sql = "select ID, [Description], PostID, StageID from Application_Stage where PostID = ?";
        try {
            cn = DBUtil.getConnection();
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, String.valueOf(postID));
            ArrayList<ApplicationStageDTO> list = new ArrayList<>();
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                ApplicationStageDTO dto = new ApplicationStageDTO();
                dto.setId(rs.getInt("ID"));
                dto.setDescription(rs.getNString("[Description]"));
                dto.setPostID(rs.getInt("PostID"));
                dto.setStageID(rs.getInt("StageID"));
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            if (cn != null) {
                try {
                    cn.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
        return null;
    }
}
