package com.t404notfound.erecruitment.bean.cv;

public class EducationDTO {

    private int educationID;
    private String educationName;
    private String organizationName;
    private int status;
    private int CVID;

    public EducationDTO() {
    }

    public EducationDTO(int educationID, String educationName, String organizationName, int status, int CVID) {
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
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
