/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Util;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author MINH TRI
 */
public class TestConnection {
        
    public static void main(String[] args) {
        System.out.println("Test connection: ");
        try {
            Connection con = DBUtil.getConnection();
            System.out.println("Connect success.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}
