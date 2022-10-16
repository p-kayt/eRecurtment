/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.t404notfound.erecruitment.bean.applicationpost;

/**
 *
 * @author MSI GF63
 */
public class PostStageDTO {

    private int id;
    private String description;
    private int postID;
    private int stageID;

    public PostStageDTO() {
    }

    public PostStageDTO(int id, String description, int postID, int stageID) {
        this.id = id;
        this.description = description;
        this.postID = postID;
        this.stageID = stageID;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public int getStageID() {
        return stageID;
    }

    public void setStageID(int stageID) {
        this.stageID = stageID;
    }

}
