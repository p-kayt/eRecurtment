package com.t404notfound.erecruitment.bean;

public class SkillDTO {
    private int skillID;
    private String skillName;
    private String skillDescription;
    private int CVID;

    public SkillDTO() {
    }

    public SkillDTO(int skillID, String skillName, String skillDescription, int CVID) {
        this.skillID = skillID;
        this.skillName = skillName;
        this.skillDescription = skillDescription;
        this.CVID = CVID;
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

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    @Override
    public String toString() {
        return "SkillDTO{" + "skillID=" + skillID + ", skillName=" + skillName + ", skillDescription=" + skillDescription + ", CVID=" + CVID + '}';
    }

    

    
}
