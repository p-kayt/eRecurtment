/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean;

/**
 *
 * @author MINH TRI
 */
public class UserDTO {
    
    protected int userID;
    protected String email;
    protected String password;
    protected String avatarURL = null;               // can be null
    protected String firstName;
    protected String lastName;
    protected String CVLink = null;                  // can be null
    protected int CVID;
    protected int statusID;
    protected int roleID;

    public UserDTO(int userID, String email, String password, String avatarURL, String firstName, String lastName, String CVLink, int CVID, int statusID, int roleID) {
        this.userID = userID;
        this.email = email;
        this.password = password;
        this.avatarURL = avatarURL;
        this.firstName = firstName;
        this.lastName = lastName;
        this.CVLink = CVLink;
        this.CVID = CVID;
        this.statusID = statusID;
        this.roleID = roleID;
    }

    public int getUserID() {
        return userID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatarURL() {
        return avatarURL;
    }

    public void setAvatarURL(String avatarURL) {
        this.avatarURL = avatarURL;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getCVLink() {
        return CVLink;
    }

    public void setCVLink(String CVLink) {
        this.CVLink = CVLink;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }
    
    
 }
