/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.dtos;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 *
 * @author tanta
 */
public class QuestionDTO implements Serializable {

    private String id, content, answerCorrect;
    private LocalDateTime createDate;
    private String subjectId;
    private boolean status;
    private ArrayList<AnswerDTO> listAnswer;

    public QuestionDTO() {
        listAnswer = new ArrayList<>();
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

    public String getAnswerCorrect() {
        return answerCorrect;
    }

    public void setAnswerCorrect(String answerCorrect) {
        this.answerCorrect = answerCorrect;
    }

    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public String getStringCreateDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return this.createDate.format(formatter);
    }

    public String getTextCreateDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd-MM-yyyy ");
        return this.createDate.format(formatter);
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }

    public void setCreateDate(String createDate) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        this.createDate = LocalDateTime.parse(createDate, formatter);
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public ArrayList<AnswerDTO> getListAnswer() {
        return listAnswer;
    }

    public void setListAnswer(ArrayList<AnswerDTO> listAnswer) {
        this.listAnswer = listAnswer;
    }

}
