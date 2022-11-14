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
import java.util.ArrayList;

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
                int roleID = getUserRole(userID);
                UserDTO user = new UserDTO(userID, email, password, firstName, lastName, genderID, statusID, roleID);
                user.setAvatarURL(avatarURL);

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

    public int getUserRole(int userID) {
        int role = 0;
        String sql = " SELECT RoleID "
                + " FROM User_Role "
                + " WHERE UserID = ? ";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                role = rs.getInt("RoleID");
            }

        } catch (Exception e) {
            System.out.println("Error when query role!");
            e.printStackTrace();
            return 0;
        }
        return role;
    }

    public UserDTO signup(String email, String password, String firstName, String lastName, String gender) {

        String sql = "INSERT INTO [User](Email, [Password], Avatar, FirstName, LastName, Gender, [Status]) "
                + " VALUES (?,?,null,?,?,?,1) ";

        if (checkEmail(email)) {
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
            if (rs > 0) {
                UserDTO tmp = login(email, password);
                int userID = tmp.getUserID();
                setUserRole(userID, 1);
//                deleteUserRole(userID, 0);
                tmp.setUserRole(1);
                return tmp;
            }

        } catch (Exception e) {
            System.out.print("Query sign up error: ");
            e.printStackTrace();
        }
        return null;
    }

    public boolean setUserRole(int userID, int roleID) {
        String sql = " INSERT INTO User_Role(UserID, RoleID) "
                + " VALUES (?, ?) ";

        //Xoa truoc khi insert de tranh loi
        deleteUserRole(userID, roleID);
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, roleID);
            int result = ps.executeUpdate();
            if (result != 0) {
                return true;
            }
            return false;
        } catch (Exception e) {
            System.out.println("Error when query Update!");
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUserRole(int userID, int roleID) {
        //Hàm delete chi false khi xay ra exception
        String sql = " DELETE FROM User_Role "
                + " WHERE UserID = ? AND RoleID = ? ";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, roleID);
            int rs = ps.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println("Error when query user role!");
            e.printStackTrace();
            return false;
        }
    }

    public boolean changePass(int userID, String password) {

        String sql = "UPDATE [User] "
                + " SET [Password] = ? "
                + " WHERE UserID = ? ";
        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, password);
            ps.setInt(2, userID);
            int rs = ps.executeUpdate();

            if (rs != 0) {
                return true;
            }

        } catch (Exception e) {
            System.out.println("Error when execute update.");
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateProfile(int UserID, String firstName, String lastName, String gender) {
        String sql = "UPDATE [User] "
                + " SET FirstName = ?, LastName = ?, Gender = ? "
                + " WHERE UserID = ? ";

        int genderID;
        switch (gender.toLowerCase()) {
            case "male":
                genderID = 1;
                break;
            case "female":
                genderID = 2;
                break;
            default:
                genderID = 3;
                break;
        }

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setInt(3, genderID);
            ps.setInt(4, UserID);
            int rs = ps.executeUpdate();

            if (rs != 0) {
                return true;
            }
            return false;

        } catch (Exception e) {
            System.out.println("Error when execute update");
            e.printStackTrace();
        }
        return false;
    }

    public boolean changeAvatar(String url, int userID) {

        String sql = "UPDATE [User] "
                + " SET Avatar = ? "
                + " WHERE userID = ? ";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, url);
            ps.setInt(2, userID);
            int rs = ps.executeUpdate();
            if (rs > 0) {
                return true;
            }
        } catch (Exception e) {
            System.out.println("Error when execute query.");
            e.printStackTrace();
            e.getMessage();
        }

        return false;
    }

    public UserDTO getUserByID(int userID) {

        String sql = " SELECT * FROM [User] "
                + " WHERE UserID = ? ";

        try {
            Connection con = DBUtil.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String email = rs.getString("Email");
                String password = rs.getString("Password");
                UserDTO tmp = login(email, password);
                return tmp;
            }
        } catch (Exception e) {
            e.printStackTrace();;
            System.out.println("Error when execute query get user by id.");
        }

        return null;
    }

}
