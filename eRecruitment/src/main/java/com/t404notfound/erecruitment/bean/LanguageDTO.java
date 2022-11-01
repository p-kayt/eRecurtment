package com.t404notfound.erecruitment.bean;

public class LanguageDTO {
    private int languageID;
    private String languageName;
    private String languageDescription;
    private int CVID;

    public LanguageDTO() {
    }

    public LanguageDTO(int languageID, String languageName, String languageDescription, int CVID) {
        this.languageID = languageID;
        this.languageName = languageName;
        this.languageDescription = languageDescription;
        this.CVID = CVID;
    }

    public int getLanguageID() {
        return languageID;
    }

    public void setLanguageID(int languageID) {
        this.languageID = languageID;
    }

    public String getLanguageName() {
        return languageName;
    }

    public void setLanguageName(String languageName) {
        this.languageName = languageName;
    }

    public String getLanguageDescription() {
        return languageDescription;
    }

    public void setLanguageDescription(String languageDescription) {
        this.languageDescription = languageDescription;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    @Override
    public String toString() {
        return "LanguageDTO{" + "languageID=" + languageID + ", languageName=" + languageName + ", languageDescription=" + languageDescription + ", CVID=" + CVID + '}';
    }
    
    
}
