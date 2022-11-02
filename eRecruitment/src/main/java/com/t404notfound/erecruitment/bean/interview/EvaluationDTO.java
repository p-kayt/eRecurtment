/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

/**
 *
 * @author Savoy
 */
public class EvaluationDTO {
     
    protected int interviewID;
    protected String interviewerFirstName;
    protected String interviewerLastName;
    protected String comment;
    protected int score;

    public EvaluationDTO(int interviewID, String interviewerFirstName, String interviewerLastName, String comment, int score) {
        this.interviewID = interviewID;
        this.interviewerFirstName = interviewerFirstName;
        this.interviewerLastName = interviewerLastName;
        this.comment = comment;
        this.score = score;
    }

    public int getInterviewID() {
        return interviewID;
    }

    public void setInterviewID(int interviewID) {
        this.interviewID = interviewID;
    }

    public String getInterviewerFirstName() {
        return interviewerFirstName;
    }

    public void setInterviewerFirstName(String interviewerFirstName) {
        this.interviewerFirstName = interviewerFirstName;
    }

    public String getInterviewerLastName() {
        return interviewerLastName;
    }

    public void setInterviewerLastName(String interviewerLastName) {
        this.interviewerLastName = interviewerLastName;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    
}
