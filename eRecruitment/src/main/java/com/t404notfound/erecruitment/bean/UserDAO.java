/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean;

import Util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author MINH TRI
 */
public class UserDAO {

    public UserDTO login(String email, String password) {

        String sql = "SELECT * FROM [User] "
                + " WHERE Email = ? AND [Password] = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userID = rs.getInt("UserID");
                String avatarURL = rs.getString("Avatar");               // can be null
                String firstName = rs.getString("FirstName");
                String lastName = rs.getString("LastName");
                int genderID = rs.getInt("Gender");
                int statusID = rs.getInt("Status");
                UserDTO user = new UserDTO(userID, email, password, firstName, lastName, genderID, statusID);
                return user;
            }

        } catch (Exception e) {
            System.out.print("Query login error: ");
            e.printStackTrace();
        }

        return null;
    }
    
    public static void main(String[] args) {
        String email = "testCandidate@gmail.com";
        String password = "111111";
        UserDAO dao = new UserDAO();
        UserDTO user = dao.login(email, password);
        System.out.println(user.toString());
    }

}
