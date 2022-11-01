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
    protected int interviewerID;
    protected String comment;
    protected int score;

    public EvaluationDTO(int interviewID, int interviewerID, String comment, int score) {
        this.interviewID = interviewID;
        this.interviewerID = interviewerID;
        this.comment = comment;
        this.score = score;
    }

    public int getInterviewID() {
        return interviewID;
    }

    public void setInterviewID(int interviewID) {
        this.interviewID = interviewID;
    }

    public int getInterviewerID() {
        return interviewerID;
    }

    public void setInterviewerID(int interviewerID) {
        this.interviewerID = interviewerID;
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
