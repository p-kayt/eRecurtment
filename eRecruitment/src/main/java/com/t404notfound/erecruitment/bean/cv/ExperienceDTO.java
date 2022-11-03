package com.t404notfound.erecruitment.bean.cv;

public class ExperienceDTO {

    private int experienceID;
    private String jobTitle;
    private String experienceOrganizationName;
    private String experienceDescription;
    private String experienceDuration;
    private int CVID;

    public ExperienceDTO() {
    }

    public ExperienceDTO(int experienceID, String jobTitle, String experienceOrganizationName, String experienceDescription, String experienceDuration, int CVID) {
        this.experienceID = experienceID;
        this.jobTitle = jobTitle;
        this.experienceOrganizationName = experienceOrganizationName;
        this.experienceDescription = experienceDescription;
        this.experienceDuration = experienceDuration;
        this.CVID = CVID;
    }

    public int getExperienceID() {
        return experienceID;
    }

    public void setExperienceID(int experienceID) {
        this.experienceID = experienceID;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getExperienceOrganizationName() {
        return experienceOrganizationName;
    }

    public void setExperienceOrganizationName(String experienceOrganizationName) {
        this.experienceOrganizationName = experienceOrganizationName;
    }

    public String getExperienceDescription() {
        return experienceDescription;
    }

    public void setExperienceDescription(String experienceDescription) {
        this.experienceDescription = experienceDescription;
    }

    public String getExperienceDuration() {
        return experienceDuration;
    }

    public void setExperienceDuration(String experienceDuration) {
        this.experienceDuration = experienceDuration;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    @Override
    public String toString() {
        return "ExperienceDTO{" + "experienceID=" + experienceID + ", jobTitle=" + jobTitle + ", experienceOrganizationName=" + experienceOrganizationName + ", experienceDescription=" + experienceDescription + ", experienceDuration=" + experienceDuration + ", CVID=" + CVID + '}';
    }
    
    
}
