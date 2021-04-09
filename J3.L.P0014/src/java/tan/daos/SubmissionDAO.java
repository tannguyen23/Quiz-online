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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import tan.db.MyConnection;
import tan.dtos.SubmissionDTO;

/**
 *
 * @author tanta
 */
public class SubmissionDAO implements Serializable {

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

    public String getLastID(String userID, String subjectID) throws Exception {
        String result = "";
        try {
            String sql = "Select MAX(ID) From tblSubmission \n"
                    + "Where UserID = ? And SubjectID = ?\n"
                    + "AND SUBSTRING(ID,LEN(UserID) + Len(SubjectID) + 3,LEN(ID)) \n"
                    + "IN (Select MAX(CONVERT(int,\n"
                    + "SUBSTRING(ID,LEN(UserID) + Len(SubjectID) + 3,LEN(ID)))) \n"
                    + "From tblSubmission Where UserID = ? And SubjectID = ?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, userID);
            preStm.setString(2, subjectID);
            preStm.setString(3, userID);
            preStm.setString(4, subjectID);
            rs = preStm.executeQuery();
            if (rs.next()) {
                result = rs.getString(1);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

    public boolean insert(SubmissionDTO submissionDTO) throws Exception {
        boolean check;
        try {
            String sql = "Insert into tblSubmission(ID,UserID,Point,SubjectID,TimeSubmit) values (?,?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, submissionDTO.getId());
            preStm.setString(2, submissionDTO.getUserId());
            preStm.setFloat(3, submissionDTO.getPoint());
            preStm.setString(4, submissionDTO.getSubjectId());
            preStm.setString(5, submissionDTO.getStringTimeSubmit());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<SubmissionDTO> getListSubmissionSearch(int index, int mountEachPage, String userID, String content, String subjectID) throws Exception {
        List<SubmissionDTO> listSubmission = null;
        try {
            String conditionSubjectID = "AND SubjectID like '%" + subjectID + "%'\n";
            if (subjectID.equals("all")) {
                conditionSubjectID = "";
            }
            String sql = "Select s.ID,Point,s.SubjectID,s.TimeSubmit,su.Name\n "
                    + "From tblSubmission s join tblSubject su on s.SubjectID = su.ID\n "
                    + "Where UserID = ?\n"
                    + conditionSubjectID
                    + "AND su.Name like ?\n"
                    + "Order By TimeSubmit\n"
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, userID);
            preStm.setString(2, "%" + content + "%");
            preStm.setInt(3, mountEachPage * (index - 1));
            preStm.setInt(4, mountEachPage);
            rs = preStm.executeQuery();
            listSubmission = new ArrayList<>();
            while (rs.next()) {
                SubmissionDTO submissionDTO = new SubmissionDTO();
                submissionDTO.setId(rs.getString("ID"));
                submissionDTO.setPoint(rs.getFloat("Point"));
                submissionDTO.setSubjectName(rs.getString("Name"));
                submissionDTO.setSubjectId(rs.getString("SubjectID"));
                Timestamp timeSubmit = rs.getTimestamp("TimeSubmit");
                submissionDTO.setTimeSubmit(timeSubmit.toLocalDateTime());
                submissionDTO.setUserId(userID);
                listSubmission.add(submissionDTO);
            }
        } finally {
            closeConnection();
        }
        return listSubmission;
    }

    public int getTotalPageSubmissionSearch(int mountEachPage, String userID, String content, String subjectID) throws Exception {
        int result = 0;
        int tmp = 0;
        try {
            String conditionSubjectID = "AND SubjectID like '%" + subjectID + "%'\n";
            if (subjectID.equals("all")) {
                conditionSubjectID = "";
            }
            String sql = "Select Count(s.ID) \n"
                    + "From tblSubmission s join tblSubject su on s.SubjectID = su.ID\n"
                    + "Where UserID = ?\n"
                    + conditionSubjectID
                    + "AND su.Name like ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, userID);
            preStm.setString(2, "%" + content + "%");
            rs = preStm.executeQuery();
            if (rs.next()) {
                tmp = rs.getInt(1);
            }
            result = tmp / mountEachPage;
            if (tmp % mountEachPage != 0) {
                result++;
            }
        } finally {
            closeConnection();
        }
        return result;
    }
}
