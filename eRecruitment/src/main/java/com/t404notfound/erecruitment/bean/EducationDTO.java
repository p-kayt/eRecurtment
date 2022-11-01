package com.t404notfound.erecruitment.bean;

public class EducationDTO {

    private int educationID;
    private String educationName;
    private String organizationName;
    private String status;
    private int CVID;

    public EducationDTO() {
    }

    public EducationDTO(int educationID, String educationName, String organizationName, String status, int CVID) {
        this.educationID = educationID;
        this.educationName = educationName;
        this.organizationName = organizationName;
        this.status = status;
        this.CVID = CVID;
    }

    public int getEducationID() {
        return educationID;
    }

    public void setEducationID(int educationID) {
        this.educationID = educationID;
    }

    public String getEducationName() {
        return educationName;
    }

    public void setEducationName(String educationName) {
        this.educationName = educationName;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    @Override
    public String toString() {
        return "EducationDTO{" + "educationID=" + educationID + ", educationName=" + educationName + ", organizationName=" + organizationName + ", status=" + status + ", CVID=" + CVID + '}';
    }

    
    
    

}
