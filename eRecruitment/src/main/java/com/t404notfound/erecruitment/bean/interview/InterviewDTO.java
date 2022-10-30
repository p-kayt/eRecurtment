/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.interview;

import java.sql.Date;
import java.util.logging.Logger;

/**
 *
 * @author MINH TRI
 */
public class InterviewDTO {

    protected int interviewID;
    protected String description;
    protected int formatID;  //online or offline
    protected String link;  //only when format is online (formatID = 2)
    protected String address; //only when format is offline (formatID = 1)
    protected String time;   // date time
    protected int maxCandidate;
    protected int stageID;
    protected int postID;
    protected int inteviewStatusID;  //pending/ occured...
    protected int bookerID; // ID of person who create this interview

    public InterviewDTO(int interviewID, String description, int formatID, String link, String address, String time, int maxCandidate, int stageID, int postID, int inteviewStatusID, int bookerID) {
        this.interviewID = interviewID;
        this.description = description;
        this.formatID = formatID;
        this.link = link;
        this.address = address;
        this.time = time;
        this.maxCandidate = maxCandidate;
        this.stageID = stageID;
        this.postID = postID;
        this.inteviewStatusID = inteviewStatusID;
        this.bookerID = bookerID;
    }

    public int getMaxCandidate() {
        return maxCandidate;
    }

    public void setMaxCandidate(int maxCandidate) {
        this.maxCandidate = maxCandidate;
    }

    public int getInterviewID() {
        return interviewID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getFormatID() {
        return formatID;
    }

    public void setFormatID(int formatID) {
        this.formatID = formatID;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public int getStageID() {
        return stageID;
    }

    public void setStageID(int stageID) {
        this.stageID = stageID;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public int getInteviewStatusID() {
        return inteviewStatusID;
    }

    public void setInteviewStatusID(int inteviewStatusID) {
        this.inteviewStatusID = inteviewStatusID;
    }

    public int getBookerID() {
        return bookerID;
    }

    @Override
    public String toString() {
        return interviewID + " " + description + " " + formatID + " "
                + link + " " + address + " " + time + " " + stageID + " "
                + postID + " " + inteviewStatusID + " " + bookerID;
    }

}
