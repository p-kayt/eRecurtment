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

    public boolean checkEmail(String email) {
        String sql = "SELECT * FROM [User] "
                + " WHERE Email = ?";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            System.out.print("Error when query string: ");
            e.printStackTrace();
        }
        return false;
    }

    public UserDTO signup(String email, String password, String firstName, String lastName, String gender) {

        String sql = "INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) "
                + " VALUES (?,?,null,?,?,?,1) ";
        
        if(checkEmail(email)) {
            return null;
        }

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ps.setString(3, firstName);
            ps.setString(4, lastName);
            int genderID = 0;

            switch (gender.toLowerCase()) {
                case "female":
                    genderID = 2;
                    break;
                case "other":
                    genderID = 3;
                    break;
                default:
                    genderID = 1;
                    break;
            }

            ps.setInt(5, genderID);

            int rs = ps.executeUpdate();
            if (rs == 1) {
                return login(email, password);
            }

        } catch (Exception e) {
            System.out.print("Query sign up error: ");
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        String email = "testCandidate@gmail.com";
        String email2 = "daominhtri1@gmail.com";
        String password = "111111";
        UserDAO dao = new UserDAO();
        UserDTO user = dao.login(email, password);
        System.out.println("Print user: ");
        System.out.println(user.toString());
        System.out.println("===========================================");
        System.out.println("Check email " + email + ":" + dao.checkEmail(email2));
        System.out.println("===========================================");
        dao.signup("daominhtri1000@gmail.com", "123456", "Tri", "Dao Minh", "Male");
        user = dao.login("daominhtri1000@gmail.com", "123456");
        System.out.println("Print user: ");
        System.out.println(user.toString());

    }

}
