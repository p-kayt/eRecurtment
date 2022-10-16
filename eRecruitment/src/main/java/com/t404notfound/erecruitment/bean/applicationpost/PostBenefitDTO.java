/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationpost;

/**
 *
 * @author MSI GF63
 */
public class PostBenefitDTO {

    private int benefitID;
    private String benefit;
    private int postID;

    public PostBenefitDTO() {
    }

    public PostBenefitDTO(int benefitID, String benefit, int postID) {
        this.benefitID = benefitID;
        this.benefit = benefit;
        this.postID = postID;
    }

    public int getBenefitID() {
        return benefitID;
    }

    public void setBenefitID(int benefitID) {
        this.benefitID = benefitID;
    }

    public String getBenefit() {
        return benefit;
    }

    public void setBenefit(String benefit) {
        this.benefit = benefit;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

}
