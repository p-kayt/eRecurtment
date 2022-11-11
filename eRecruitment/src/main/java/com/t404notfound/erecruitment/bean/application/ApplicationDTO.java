/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.application;

import com.t404notfound.erecruitment.bean.interview.EvaluateDTO;
import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author MSI GF63
 */
public class ApplicationDTO implements Serializable {

    private int id;
    private Date applyDate;
    private int statusID;
    private int stageID;
    private int userID;
    private int postID;
    
    private ArrayList<EvaluateDTO> evaluateList;
    
    public ApplicationDTO() {
    }

    public ApplicationDTO(int id, Date applyDate, int statusID, int stageID, int userID, int postID) {
        this.id = id;
        this.applyDate = applyDate;
        this.statusID = statusID;
        this.stageID = stageID;
        this.userID = userID;
        this.postID = postID;
    }

    public ArrayList<EvaluateDTO> getEvaluateList() {
        return evaluateList;
    }

    public void setEvaluateList(ArrayList<EvaluateDTO> evaluateList) {
        this.evaluateList = evaluateList;
    }
    
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public int getStageID() {
        return stageID;
    }

    public void setStageID(int stageID) {
        this.stageID = stageID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }
    
    
}
