/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationpost;

import java.io.Serializable;
import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author MSI GF63
 */
public class ApplicationPostDTO implements Serializable {

    private int postID;
    private String postDescription;
    private String salary;
    private int hiringQuantity;
    private Date createdDate;
    private Date startDate;
    private Date expiredDate;
    private int positionID;
    private int formID;
    private int statusID;
    private String positionName;

    private ArrayList<PostBenefitDTO> benefitList;
    private ArrayList<PostSkillDTO> skillList;
    private ArrayList<PostRequirementDTO> requirementList;
    private ArrayList<PostStageDTO> stageList;

    public ApplicationPostDTO() {
    }

    public ApplicationPostDTO(int postID, String postDescription, String salary, int hiringQuantity, Date createdDate, Date startDate, Date expiredDate, int positionID, int formID, int statusID, ArrayList<PostBenefitDTO> benefitList, ArrayList<PostSkillDTO> skillList, ArrayList<PostRequirementDTO> requirementList, ArrayList<PostStageDTO> stageList) {
        this.postID = postID;
        this.postDescription = postDescription;
        this.salary = salary;
        this.hiringQuantity = hiringQuantity;
        this.createdDate = createdDate;
        this.startDate = startDate;
        this.expiredDate = expiredDate;
        this.positionID = positionID;
        this.formID = formID;
        this.statusID = statusID;
        this.benefitList = benefitList;
        this.skillList = skillList;
        this.requirementList = requirementList;
        this.stageList = stageList;
    }

    public String getPositionName() {
        return positionName;
    }

    public void setPositionName(String positionName) {
        this.positionName = positionName;
    }
    
    

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getPostDescription() {
        return postDescription;
    }

    public void setPostDescription(String postDescription) {
        this.postDescription = postDescription;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
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

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(Date expiredDate) {
        this.expiredDate = expiredDate;
    }

    public int getPositionID() {
        return positionID;
    }

    public void setPositionID(int positionID) {
        this.positionID = positionID;
    }

    public int getFormID() {
        return formID;
    }

    public void setFormID(int formID) {
        this.formID = formID;
    }

    public int getStatusID() {
        return statusID;
    }

    public void setStatusID(int statusID) {
        this.statusID = statusID;
    }

    public ArrayList<PostBenefitDTO> getBenefitList() {
        return benefitList;
    }

    public void setBenefitList(ArrayList<PostBenefitDTO> benefitList) {
        this.benefitList = benefitList;
    }

    public ArrayList<PostSkillDTO> getSkillList() {
        return skillList;
    }

    public void setSkillList(ArrayList<PostSkillDTO> skillList) {
        this.skillList = skillList;
    }

    public ArrayList<PostRequirementDTO> getRequirementList() {
        return requirementList;
    }

    public void setRequirementList(ArrayList<PostRequirementDTO> requirementList) {
        this.requirementList = requirementList;
    }

    public ArrayList<PostStageDTO> getStageList() {
        return stageList;
    }

    public void setStageList(ArrayList<PostStageDTO> stageList) {
        this.stageList = stageList;
    }

}
