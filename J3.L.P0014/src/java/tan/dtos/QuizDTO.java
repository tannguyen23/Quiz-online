/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.dtos;

import java.io.Serializable;
import java.util.HashMap;

/**
 *
 * @author tanta
 */
public class QuizDTO implements Serializable{
    private String userID;
    private HashMap<QuestionDTO,String> listQuestion;

    public QuizDTO() {
    }

    public QuizDTO(String userID) {
        this.userID = userID;
        this.listQuestion = new HashMap<>();
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public HashMap<QuestionDTO, String> getListQuestion() {
        return listQuestion;
    }

    public void setListQuestion(HashMap<QuestionDTO, String> listQuestion) {
        this.listQuestion = listQuestion;
    }
    
    
    
    
}
