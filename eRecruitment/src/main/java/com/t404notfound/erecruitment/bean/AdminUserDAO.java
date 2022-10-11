
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
    public static ArrayList<UserDTO> getUsers(String searchValue)
            throws SQLException, NamingException, ClassNotFoundException {
        String SQLQuery = "SELECT UserID, Email, Password, FirstName, LastName, Gender, Status "
                + "FROM [User] "
                + "WHERE LastName LIKE ? or FirstName LIKE ?";
        ArrayList<UserDTO> users = new ArrayList<>();
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
                UserDTO user = new UserDTO(ReS.getInt(1), ReS.getString(2), ReS.getString(3), ReS.getString(4), ReS.getString(5), ReS.getInt(6), ReS.getInt(7));
                users.add(user);
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
}
