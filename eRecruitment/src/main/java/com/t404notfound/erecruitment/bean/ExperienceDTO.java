package com.t404notfound.erecruitment.bean;

public class ExperienceDTO {

    private int experienceID;
    private String jobTitle;
    private String organizationName;
    private String experienceDescription;
    private String experienceDuration;
    private int CVID;

    public ExperienceDTO() {
    }

    public ExperienceDTO(int experienceID, String jobTitle, String organizationName, String experienceDescription, String experienceDuration, int CVID) {
        this.experienceID = experienceID;
        this.jobTitle = jobTitle;
        this.organizationName = organizationName;
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

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
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
        return "ExperienceDTO{" + "experienceID=" + experienceID + ", jobTitle=" + jobTitle + ", organizationName=" + organizationName + ", experienceDescription=" + experienceDescription + ", experienceDuration=" + experienceDuration + ", CVID=" + CVID + '}';
    }
    
    
}
