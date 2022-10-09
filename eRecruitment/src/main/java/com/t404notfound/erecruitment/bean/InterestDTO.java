package com.t404notfound.erecruitment.bean;

public class InterestDTO {

    private int interestID;
    private String interestName;
    private int CVID;

    public InterestDTO() {
    }

    public InterestDTO(int interestID, String interestName, int CVID) {
        this.interestID = interestID;
        this.interestName = interestName;
        this.CVID = CVID;
    }

    public int getInterestID() {
        return interestID;
    }

    public void setInterestID(int interestID) {
        this.interestID = interestID;
    }

    public String getInterestName() {
        return interestName;
    }

    public void setInterestName(String interestName) {
        this.interestName = interestName;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    @Override
    public String toString() {
        return "InterestDTO{" + "interestID=" + interestID + ", interestName=" + interestName + ", CVID=" + CVID + '}';
    }
    
    
}
