package com.t404notfound.erecruitment.bean.cv;

public class SocialMediaDTO {
    private int socialMediaID;
    private String socialMediaLink;
    private String platformName;
    private int CVID;

    public SocialMediaDTO() {
    }

    public SocialMediaDTO(int socialMediaID, String socialMediaLink, String platformName, int CVID) {
        this.socialMediaID = socialMediaID;
        this.socialMediaLink = socialMediaLink;
        this.platformName = platformName;
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

    public String getPlatformName() {
        return platformName;
    }

    public void setPlatformName(String platformName) {
        this.platformName = platformName;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    @Override
    public String toString() {
        return "SocialMediaDTO{" + "socialMediaID=" + socialMediaID + ", socialMediaLink=" + socialMediaLink + ", PlatformName=" + platformName + ", CVID=" + CVID + '}';
    }
    
    
}
