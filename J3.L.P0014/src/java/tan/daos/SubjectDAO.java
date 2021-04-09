/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.daos;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import tan.db.MyConnection;
import tan.dtos.SubjectDTO;

/**
 *
 * @author tanta
 */
public class SubjectDAO implements Serializable {

    private Connection conn = null;
    private PreparedStatement preStm = null;
    private ResultSet rs = null;

    private void closeConnection() throws Exception {
        if (rs != null) {
            rs.close();
        }
        if (preStm != null) {
            preStm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    public List<SubjectDTO> getListSubject() throws Exception {
        List<SubjectDTO> listSubject = new ArrayList<>();
        try {
            String sql = "Select ID,Name,Time,Mount,Description From tblSubject";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            while (rs.next()) {
                SubjectDTO dto = new SubjectDTO();
                dto.setId(rs.getString("ID"));
                dto.setName(rs.getString("Name"));
                dto.setTime(rs.getTime("Time"));
                dto.setMount(rs.getInt("Mount"));
                dto.setDescription(rs.getString("Description"));
                listSubject.add(dto);
            }
        } finally {
            closeConnection();
        }
        return listSubject;
    }

    public SubjectDTO getSubjectByID(String subjectID) throws Exception {
        SubjectDTO subjectDTO;
        try {
            String sql = "Select Name,Time,Mount,Description From tblSubject Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, subjectID);
            rs = preStm.executeQuery();
            subjectDTO = new SubjectDTO();
            if (rs.next()) {
                subjectDTO.setId(subjectID);
                subjectDTO.setName(rs.getString("Name"));
                subjectDTO.setTime(rs.getTime("Time"));
                subjectDTO.setMount(rs.getInt("Mount"));
                subjectDTO.setDescription(rs.getString("Description"));
            }
        } finally {
            closeConnection();
        }
        return subjectDTO;
    }
}
