/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationpost;

/**
 *
 * @author MSI GF63
 */
public class PostRequirementDTO {

    private int requirementID;
    private String requirement;
    private int postID;

    public PostRequirementDTO() {
    }

    public PostRequirementDTO(int requirementID, String requirement, int postID) {
        this.requirementID = requirementID;
        this.requirement = requirement;
        this.postID = postID;
    }

    public int getRequirementID() {
        return requirementID;
    }

    public void setRequirementID(int requirementID) {
        this.requirementID = requirementID;
    }

    public String getRequirement() {
        return requirement;
    }

    public void setRequirement(String requirement) {
        this.requirement = requirement;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

}
