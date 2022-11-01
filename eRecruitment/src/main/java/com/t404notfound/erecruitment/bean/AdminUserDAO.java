package com.t404notfound.erecruitment.bean;

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
public class AdminUserDAO {

    public static ArrayList<AdminUserDTO> getUsers(String searchValue)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "SELECT [User].UserID, [User].Email, [User].Password, [User].FirstName, [User].LastName, Gender.GenderName, Role.RoleName, UserStatus.StatusName FROM [User] JOIN UserStatus ON [User].Status = UserStatus.StatusID JOIN User_Role ON [User].UserID = User_Role.UserID JOIN Role ON User_Role.RoleID = Role.RoleID JOIN Gender ON [User].Gender = Gender.GenderID WHERE [User].LastName LIKE ? or [User].FirstName LIKE ?";
        ArrayList<AdminUserDTO> users = new ArrayList<>();
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
                AdminUserDTO user = new AdminUserDTO(ReS.getInt(1), ReS.getString(2), ReS.getString(3), ReS.getString(4), ReS.getString(5), ReS.getString(6), ReS.getString(7), ReS.getString(8));

                users.add(user);

                if (!users.isEmpty()) {
                    int count = 0;
                    for (AdminUserDTO u : users) {
                        if (user.userID == u.userID) {
                            count++;
                        }
                    }
                    if (count != 1) {
                        users.remove(user);
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
        return users;
    }

    public static boolean updateStatus(String email, int status)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "UPDATE [User] SET [User].Status = ? FROM [User] LEFT JOIN UserStatus ON [User].Status = UserStatus.StatusID WHERE [User].Email LIKE ?";
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

    public static boolean updateRoles(String email, int role)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "UPDATE User_Role SET User_Role.RoleID = ? FROM User_Role LEFT JOIN [User] ON User_Role.UserID = [User].UserID WHERE [User].Email LIKE ?";
        Connection conn = null;
        PreparedStatement PreS = null;
        boolean result = false;
        try {
            conn = DBUtil.getConnection();
            PreS = conn.prepareCall(SQLQuery);
            PreS.setInt(1, role);
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

    public static boolean addRoles(int id, int role)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "INSERT INTO User_Role VALUES (?, ?)";
        Connection conn = null;
        PreparedStatement PreS = null;
        boolean result = false;
        try {
            conn = DBUtil.getConnection();
            PreS = conn.prepareCall(SQLQuery);
            PreS.setInt(1, id);
            PreS.setInt(2, role);
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

    public static boolean removeRoles(int id, int role)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "DELETE FROM User_Role WHERE UserID = ? AND RoleID = ?";
        Connection conn = null;
        PreparedStatement PreS = null;
        boolean result = false;
        try {
            conn = DBUtil.getConnection();
            PreS = conn.prepareCall(SQLQuery);
            PreS.setInt(1, id);
            PreS.setInt(2, role);
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
