/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

/**
 *
 * @author MINH TRI
 */
public class EvaluateDTO {
    protected int evaluationID;
    protected String evaluationDescription;
    protected int score;
    protected int interviewerID;
    protected int participantID;
    protected int interviewID;

    public EvaluateDTO(int evaluationID, String evaluationDescription, int score, int interviewerID, int participantID, int interviewID) {
        this.evaluationID = evaluationID;
        this.evaluationDescription = evaluationDescription;
        this.score = score;
        this.interviewerID = interviewerID;
        this.participantID = participantID;
        this.interviewID = interviewID;
    }

    public int getEvaluationID() {
        return evaluationID;
    }

    public String getEvaluationDescription() {
        return evaluationDescription;
    }

    public void setEvaluationDescription(String evaluationDescription) {
        this.evaluationDescription = evaluationDescription;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getInterviewerID() {
        return interviewerID;
    }

    public int getParticipantID() {
        return participantID;
    }

    public int getInterviewID() {
        return interviewID;
    }
    
}
