package com.t404notfound.erecruitment.bean;

public class CertificateDTO {

    private int certificateID;
    private String certificateName;
    private String certificateLink;
    private int CVID;

    public CertificateDTO() {
    }

    public CertificateDTO(int certificateID, String certificateName, String certificateLink, int CVID) {
        this.certificateID = certificateID;
        this.certificateName = certificateName;
        this.certificateLink = certificateLink;
        this.CVID = CVID;
    }

    public int getCertificateID() {
        return certificateID;
    }

    public void setCertificateID(int certificateID) {
        this.certificateID = certificateID;
    }

    public String getCertificateName() {
        return certificateName;
    }

    public void setCertificateName(String certificateName) {
        this.certificateName = certificateName;
    }

    public String getCertificateLink() {
        return certificateLink;
    }

    public void setCertificateLink(String certificateLink) {
        this.certificateLink = certificateLink;
    }

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    

    @Override
    public String toString() {
        return "CertificateDTO{" + "certificateID=" + certificateID + ", certificateName=" + certificateName + ", certificateLink=" + certificateLink + ", CVID=" + CVID + '}';
    }
    
    
}
