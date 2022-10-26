/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean;

/**
 *
 * @author Savoy
 */
public class AdminUserDTO {
    protected int userID;
    protected String email;
    protected String password;
    protected String avatarURL = null;               // can be null
    protected String firstName;
    protected String lastName;
    protected String gender;
    protected String status;
    protected String userRole;
    protected boolean isCandidate;
    protected boolean isHRStaff;
    protected boolean isHRManager;
    protected boolean isInterviewer;

    public AdminUserDTO() {
    }

    public AdminUserDTO(int userID, String email, String password, String firstName, String lastName, String gender, String userRole, String status, boolean isCandidate, boolean isHRStaff, boolean isHRManager, boolean isInterviewer) {
        this.userID = userID;
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.gender = gender;
        this.status = status;
        this.userRole = userRole;
        this.isCandidate = isCandidate;
        this.isHRStaff = isHRStaff;
        this.isHRManager = isHRManager;
        this.isInterviewer = isInterviewer;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public boolean isIsCandidate() {
        return isCandidate;
    }

    public void setIsCandidate(boolean isCandidate) {
        this.isCandidate = isCandidate;
    }

    public boolean isIsHRStaff() {
        return isHRStaff;
    }

    public void setIsHRStaff(boolean isHRStaff) {
        this.isHRStaff = isHRStaff;
    }

    public boolean isIsHRManager() {
        return isHRManager;
    }

    public void setIsHRManager(boolean isHRManager) {
        this.isHRManager = isHRManager;
    }

    public boolean isIsInterviewer() {
        return isInterviewer;
    }

    public void setIsInterviewer(boolean isInterviewer) {
        this.isInterviewer = isInterviewer;
    }
    
    
    
}
