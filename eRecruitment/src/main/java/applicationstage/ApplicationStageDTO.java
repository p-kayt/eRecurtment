
package applicationstage;

import java.io.Serializable;

/**
 *
 * @author HUU MINH
 */
public class ApplicationStageDTO implements Serializable {

    private int id;
    private String description;
    private int postID;
    private int stageID;
    
    public ApplicationStageDTO() {
    }

    public ApplicationStageDTO(int id, String description, int postID, int stageID) {
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
