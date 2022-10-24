package com.t404notfound.erecruitment.bean.cv;

public class SocialMediaDTO {

    private int socialMediaID;
    private String socialMediaLink;
    private int platformID;
    private int CVID;

    public SocialMediaDTO() {
    }

    public SocialMediaDTO(int socialMediaID, String socialMediaLink, int platformID, int CVID) {
        this.socialMediaID = socialMediaID;
        this.socialMediaLink = socialMediaLink;
        this.platformID = platformID;
        this.CVID = CVID;
    }

    public int getSocialMediaID() {
        return socialMediaID;
    }

    public void setSocialMediaID(int socialMediaID) {
        this.socialMediaID = socialMediaID;
    }

    public String getSocialMediaLink() {
        return socialMediaLink;
    }

    public void setSocialMediaLink(String socialMediaLink) {
        this.socialMediaLink = socialMediaLink;
    }

    public int getPlatformID() {
        return platformID;
    }

    public void setPlatformID(int platformID) {
        this.platformID = platformID;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    @Override
    public String toString() {
        return "SocialMediaDTO{" + "socialMediaID=" + socialMediaID + ", socialMediaLink=" + socialMediaLink + ", platformID=" + platformID + ", CVID=" + CVID + '}';
    }

}
