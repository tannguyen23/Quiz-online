/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.dtos;

import java.io.Serializable;

/**
 *
 * @author tanta
 */
public class AnswerDTO implements Serializable {

    private String id, content, questionId;

    public AnswerDTO() {
    }

    public AnswerDTO(String id, String content, String questionId) {
        this.id = id;
        this.content = content;
        this.questionId = questionId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public String getHtmlContent() {
        String htmlContent = content;
        htmlContent = htmlContent.replace("<", "&lt;");
        htmlContent = htmlContent.replace(">", "&gt;");
        htmlContent = htmlContent.replace("\"", "&#8221;");
        htmlContent = htmlContent.replace("\n", "<br>");
        return htmlContent;
    }

    public void setContent(String content) {

        this.content = content;
    }

    public String getQuestionId() {
        return questionId;
    }

    public void setQuestionId(String questionId) {
        this.questionId = questionId;
    }

    public String getCharAnswer() {
        return String.valueOf(id.charAt(id.length() - 1));
    }

}
