/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.dtos;

import java.io.Serializable;
import java.sql.Time;

/**
 *
 * @author tanta
 */
public class SubjectDTO implements Serializable {

    private String id, name, description;
    private Time time;
    private boolean status;
    private int mount;

    public SubjectDTO() {
    }

    public SubjectDTO(String id, String name, String description, Time time, boolean status, int mount) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.time = time;
        this.status = status;
        this.mount = mount;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Time getTime() {
        return time;
    }

    public void setTime(Time time) {
        this.time = time;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getMount() {
        return mount;
    }

    public void setMount(int mount) {
        this.mount = mount;
    }

}
