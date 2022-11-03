package com.t404notfound.erecruitment.bean.cv;

public class AchievementDTO {
    private int achivementID;
    private String achivementName;
    private String AchievementDescription;
    private String achivementLink;
    private int CVID;

    public AchievementDTO() {
    }

    public AchievementDTO(int achivementID, String achivementName, String AchievementDescription, int CVID) {
        this.achivementID = achivementID;
        this.achivementName = achivementName;
        this.AchievementDescription = AchievementDescription;
        this.achivementLink = "";
        this.CVID = CVID;
    }

    public int getAchievementID() {
        return achivementID;
    }

    public void setAchievementID(int achivementID) {
        this.achivementID = achivementID;
    }

    public String getAchievementName() {
        return achivementName;
    }

    public void setAchievementName(String achivementName) {
        this.achivementName = achivementName;
    }

    public String getAchievementDescription() {
        return AchievementDescription;
    }

    public void setAchievementDescription(String AchievementDescription) {
        this.AchievementDescription = AchievementDescription;
    }

    public String getAchievementLink() {
        return achivementLink;
    }

    public void setAchievementLink(String achivementLink) {
        this.achivementLink = achivementLink;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    @Override
    public String toString() {
        return "AchievementDTO{" + "achivementID=" + achivementID + ", achivementName=" + achivementName + ", AchievementDescription=" + AchievementDescription + ", achivementLink=" + achivementLink + ", CVID=" + CVID + '}';
    }
    
    
}
