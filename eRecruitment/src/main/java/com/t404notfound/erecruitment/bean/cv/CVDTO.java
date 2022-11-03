/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.cv;

import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author Huu Minh
 */
public class CVDTO {

    protected int CVID;
    protected String firstName;
    protected String lastName;
    protected String avatar;
    protected String dob;
    protected String introduction;
    protected String email;
    protected String phoneNumber;
    protected String address;
    protected String city;
    protected int gender;
    protected int userID;
    private ArrayList<SkillDTO> skills;
    protected ArrayList<InterestDTO> interests;
    protected ArrayList<CertificateDTO> certificates;
    protected ArrayList<AchievementDTO> achievements;
    protected ArrayList<ExperienceDTO> experiences;
    protected ArrayList<LanguageDTO> languages;
    protected ArrayList<EducationDTO> educations;
    protected ArrayList<SocialMediaDTO> socialMedias;

    public int getCVID() {
        return CVID;
    }

    public void setCVID(int CVID) {
        this.CVID = CVID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public CVDTO() {
    }

    public CVDTO(int CVID, String firstName, String lastName,  String dob, String introduction, String email, String phoneNumber, String address, String city, int gender, int userID, ArrayList<SkillDTO> skills, ArrayList interests, ArrayList certificates, ArrayList achievements, ArrayList experiences, ArrayList languages, ArrayList educations, ArrayList socialMedias) {
        this.CVID = CVID;
        this.firstName = firstName;
        this.lastName = lastName;
//        this.avatar = avatar;
        this.dob = dob;
        this.introduction = introduction;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.city = city;
        this.gender = gender;
        this.userID = userID;
        this.skills = skills;
        this.interests = interests;
        this.certificates = certificates;
        this.achievements = achievements;
        this.experiences = experiences;
        this.languages = languages;
        this.educations = educations;
        this.socialMedias = socialMedias;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getGender() {
        return gender;
    }

    public void setGender(int gender) {
        this.gender = gender;
    }

    public ArrayList getSkills() {
        return skills;
    }

    public void setSkills(ArrayList skills) {
        this.skills = skills;
    }

    public ArrayList getInterests() {
        return interests;
    }

    public void setInterests(ArrayList interests) {
        this.interests = interests;
    }

    public ArrayList getCertificates() {
        return certificates;
    }

    public void setCertificates(ArrayList certificates) {
        this.certificates = certificates;
    }

    public ArrayList getAchievements() {
        return achievements;
    }

    public void setAchievements(ArrayList achievements) {
        this.achievements = achievements;
    }

    public ArrayList getExperiences() {
        return experiences;
    }

    public void setExperiences(ArrayList experiences) {
        this.experiences = experiences;
    }

    public ArrayList getLanguages() {
        return languages;
    }

    public void setLanguages(ArrayList languages) {
        this.languages = languages;
    }

    public ArrayList getEducations() {
        return educations;
    }

    public void setEducations(ArrayList educations) {
        this.educations = educations;
    }

    public ArrayList getSocialMedias() {
        return socialMedias;
    }

    public void setSocialMedias(ArrayList socialMedias) {
        this.socialMedias = socialMedias;
    }

    @Override
    public String toString() {
        return "CVDTO{" + "CVID=" + CVID + ", firstName=" + firstName + ", lastName=" + lastName + ", avatar=" + avatar + ", dob=" + dob + ", introduction=" + introduction + ", email=" + email + ", phoneNumber=" + phoneNumber + ", address=" + address + ", city=" + city + ", gender=" + gender + ", userID=" + userID + ", \nskills=" + skills + ", \ninterests=" + interests + ", \ncertificates=" + certificates + ", \nachievements=" + achievements + ", \nexperiences=" + experiences + ", \nlanguages=" + languages + ", \neducations=" + educations + ", \nsocialMedias=" + socialMedias + '}';
    }

}
