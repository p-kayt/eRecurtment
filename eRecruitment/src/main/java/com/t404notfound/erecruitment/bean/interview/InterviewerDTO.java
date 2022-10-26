/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

/**
 *
 * @author MINH TRI
 */
public class InterviewerDTO {
    protected int userID;
    protected int interviewID;

    public InterviewerDTO(int userID, int interviewID) {
        this.userID = userID;
        this.interviewID = interviewID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getInterviewID() {
        return interviewID;
    }

    public void setInterviewID(int interviewID) {
        this.interviewID = interviewID;
    }
    
}
