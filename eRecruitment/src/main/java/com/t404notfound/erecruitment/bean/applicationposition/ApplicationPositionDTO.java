/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationposition;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author MSI GF63
 */
public class ApplicationPositionDTO implements Serializable {

    private int positionID;
    private String positionName;
    private String positionDescription;
    private int hiringQuantity;
    private Date createdDate;
    private int statusID;

    public ApplicationPositionDTO() {
    }

    public ApplicationPositionDTO(int positionID, String positionName, String positionDescription, int hiringQuantity, Date createdDate, int statusID) {
        this.positionID = positionID;
        this.positionName = positionName;
        this.positionDescription = positionDescription;
        this.hiringQuantity = hiringQuantity;
        this.createdDate = createdDate;
        this.statusID = statusID;
    }

    public int getPositionID() {
        return positionID;
    }

    public void setPositionID(int positionID) {
        this.positionID = positionID;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }

    public String getPositionDescription() {
        return positionDescription;
    }

    public void setPositionDescription(String positionDescription) {
        this.positionDescription = positionDescription;
    }

    public int getHiringQuantity() {
        return hiringQuantity;
    }

    public void setHiringQuantity(int hiringQuantity) {
        this.hiringQuantity = hiringQuantity;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

}
