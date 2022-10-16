/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationpost;

/**
 *
 * @author MSI GF63
 */
public class PostSkillDTO {

    private int skillID;
    private String skillName;
    private String skillDescription;
    private int postID;

    public PostSkillDTO() {
    }

    public PostSkillDTO(int skillID, String skillName, String skillDescription, int postID) {
        this.skillID = skillID;
        this.skillName = skillName;
        this.skillDescription = skillDescription;
        this.postID = postID;
    }

    public int getSkillID() {
        return skillID;
    }

    public void setSkillID(int skillID) {
        this.skillID = skillID;
    }

    public String getSkillName() {
        return skillName;
    }

    public void setSkillName(String skillName) {
        this.skillName = skillName;
    }

    public String getSkillDescription() {
        return skillDescription;
    }

    public void setSkillDescription(String skillDescription) {
        this.skillDescription = skillDescription;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

}
