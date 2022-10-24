/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

/**
 *
 * @author MINH TRI
 */
public class ParticipantDTO {
    protected int userID;
    protected int interviewID;
    protected String interviewTime;

    public ParticipantDTO(int userID, int interviewID, String interviewTime) {
        this.userID = userID;
        this.interviewID = interviewID;
        this.interviewTime = interviewTime;
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

    public String getInterviewTime() {
        return interviewTime;
    }

    public void setInterviewTime(String interviewTime) {
        this.interviewTime = interviewTime;
    }

    
    
    
}
