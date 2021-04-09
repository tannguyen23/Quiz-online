/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.dtos;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author tanta
 */
public class SubmissionDTO implements Serializable {

    private String id, userId, subjectId,subjectName;
    private float point;
    private LocalDateTime timeSubmit;

    public SubmissionDTO() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getSubjectId() {
        return subjectId;
    }

    public void setSubjectId(String subjectId) {
        this.subjectId = subjectId;
    }

    public float getPoint() {
        return point;
    }

    public void setPoint(float point) {
        this.point = point;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
    

    public LocalDateTime getTimeSubmit() {
        return timeSubmit;
    }
    
    public String getStringTimeSubmit() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        return this.timeSubmit.format(formatter);
    }

    public String getTextTimeSubmit() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd-MM-yyyy ");
        return this.timeSubmit.format(formatter);
    }
    
    public void setTimeSubmit(LocalDateTime timeSubmit) {
        this.timeSubmit = timeSubmit;
    }
    
    public void setTimeSubmit(String timeSubmit) {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        this.timeSubmit = LocalDateTime.parse(timeSubmit, formatter);
    }

    @Override
    public String toString() {
        return "SubmissionDTO{" + "id=" + id + ", userId=" + userId + ", subjectId=" + subjectId + ", point=" + point + ", timeSubmit=" + getStringTimeSubmit() + '}';
    }
    
    

}
