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
import tan.dtos.AnswerDTO;
import tan.dtos.QuestionDTO;

/**
 *
 * @author tanta
 */
public class QuestionDAO implements Serializable {

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

    public List<QuestionDTO> getListQuestion(String subjectID, int numQuestion) throws Exception {
        List<QuestionDTO> listQuestion = new ArrayList<QuestionDTO>();
        try {
            String sql = "SELECT TOP(?) ID,Content,CreateDate,SubjectID,Status from tblQuestion\n"
                    + "Where SubjectID = ?\n"
                    + "ORDER BY NEWID()";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setInt(1, numQuestion);
            preStm.setString(2, subjectID);
            rs = preStm.executeQuery();
            while (rs.next()) {
                QuestionDTO questionDTO = new QuestionDTO();
                questionDTO.setId(rs.getString("ID"));
                questionDTO.setContent(rs.getString("Content"));
                questionDTO.setStatus(rs.getBoolean("Status"));
                questionDTO.setSubjectId(rs.getString("SubjectID"));
                sql = "Select ID,Content,QuestionID\n"
                        + "From tblAnswer\n"
                        + "Where QuestionID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, questionDTO.getId());
                ResultSet resultSet = preStm.executeQuery();
                while (resultSet.next()) {
                    AnswerDTO answerDTO = new AnswerDTO();
                    answerDTO.setId(resultSet.getString("ID"));
                    answerDTO.setContent(resultSet.getString("Content"));
                    answerDTO.setQuestionId(resultSet.getString("QuestionID"));
                    questionDTO.getListAnswer().add(answerDTO);
                }
                listQuestion.add(questionDTO);
            }
        } finally {
            closeConnection();
        }
        return listQuestion;
    }

    public QuestionDTO getQuestionByID(String idQuestion) throws Exception {
        QuestionDTO questionDTO = null;
        try {
            String sql = "SELECT ID,Content,AnswerCorrect,CreateDate,Status from tblQuestion\n"
                    + "Where ID = ?\n";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, idQuestion);
            rs = preStm.executeQuery();
            if (rs.next()) {
                questionDTO = new QuestionDTO();
                questionDTO.setId(rs.getString("ID"));
                questionDTO.setContent(rs.getString("Content"));
                questionDTO.setStatus(rs.getBoolean("Status"));
                sql = "Select ID,Content,QuestionID\n"
                        + "From tblAnswer\n"
                        + "Where QuestionID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, questionDTO.getId());
                ResultSet resultSet = preStm.executeQuery();
                while (resultSet.next()) {
                    AnswerDTO answerDTO = new AnswerDTO();
                    answerDTO.setId(resultSet.getString("ID"));
                    answerDTO.setContent(resultSet.getString("Content"));
                    answerDTO.setQuestionId(resultSet.getString("QuestionID"));
                    questionDTO.getListAnswer().add(answerDTO);
                }
            }
        } finally {
            closeConnection();
        }
        return questionDTO;
    }

    public float getPoint(ArrayList<QuestionDTO> listQuestionSubmit) throws Exception {
        float point = 0;
        try {
            conn = MyConnection.getMyConnection();
            for (QuestionDTO questionSubmit : listQuestionSubmit) {
                
                String sql = "Select ID From tblQuestion Where ID = ? and AnswerCorrect = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, questionSubmit.getId());
                preStm.setString(2, questionSubmit.getAnswerCorrect());
                rs = preStm.executeQuery();
                if (rs.next()) {
                    point += (float) 10 / listQuestionSubmit.size();
                }
            }

        } finally {
            closeConnection();
        }
        return point;
    }

   

    public int getTotalPageQuestionSearch(int mountEachPage, String content, String status, String subjectID) throws Exception {
        int result = 0;
        int tmp = 0;
        try {
            String conditionStatus = "AND Status like '%" + status + "%'\n";
            String conditionSubjectID = "AND SubjectID like '%" + subjectID + "%'\n";
            if (status.equals("all")) {
                conditionStatus = "";
            }
            if (subjectID.equals("all")) {
                conditionSubjectID = "";
            }
            String sql = "Select Count(ID) From tblQuestion Where Content like ?\n"
                    + conditionStatus
                    + conditionSubjectID;
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + content + "%");
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


    public List<QuestionDTO> getListQuestionSearchByIndex(int index, int mountEachPage, String content, String status, String subjectID) throws Exception {
        List<QuestionDTO> listQuestion = new ArrayList<QuestionDTO>();
        try {
            String conditionStatus = "AND Status like '%" + status + "%'\n";
            String conditionSubjectID = "AND SubjectID like '%" + subjectID + "%'\n";
            if (status.equals("all")) {
                conditionStatus = "";
            }
            if (subjectID.equals("all")) {
                conditionSubjectID = "";
            }
            String sql = "Select ID,Content,AnswerCorrect,CreateDate,SubjectID,Status From tblQuestion\n"
                    + "Where Content like ?\n"
                    + conditionStatus
                    + conditionSubjectID
                    + "Order By Content\n"
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, "%" + content + "%");
            preStm.setInt(2, mountEachPage * (index - 1));
            preStm.setInt(3, mountEachPage);
            rs = preStm.executeQuery();
            while (rs.next()) {
                QuestionDTO questionDTO = new QuestionDTO();
                questionDTO.setId(rs.getString("ID"));
                questionDTO.setContent(rs.getString("Content"));
                questionDTO.setStatus(rs.getBoolean("Status"));
                questionDTO.setSubjectId(rs.getString("SubjectID"));
                questionDTO.setAnswerCorrect(rs.getString("AnswerCorrect"));
                Timestamp createDate = (Timestamp.valueOf(rs.getString("CreateDate")));
                questionDTO.setCreateDate(createDate.toLocalDateTime());
                sql = "Select ID,Content,QuestionID\n"
                        + "From tblAnswer\n"
                        + "Where QuestionID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, questionDTO.getId());
                ResultSet resultSet = preStm.executeQuery();
                while (resultSet.next()) {
                    AnswerDTO answerDTO = new AnswerDTO();
                    answerDTO.setId(resultSet.getString("ID"));
                    answerDTO.setContent(resultSet.getString("Content"));
                    answerDTO.setQuestionId(resultSet.getString("QuestionID"));
                    questionDTO.getListAnswer().add(answerDTO);
                }
                listQuestion.add(questionDTO);
            }
        } finally {
            closeConnection();
        }
        return listQuestion;
    }

    public boolean delete(String id) throws Exception {
        boolean check = false;
        try {
            String sql = "Update tblQuestion Set Status = 0 Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, id);
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean update(QuestionDTO questionDTO) throws Exception {
        boolean check1 = false;
        boolean check2 = false;
        try {
            String sql = "Update tblQuestion Set Content = ?,\n"
                    + "AnswerCorrect = ?,\n"
                    + "SubjectID = ?,\n"
                    + "Status = ?\n"
                    + "Where ID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, questionDTO.getContent());
            preStm.setString(2, questionDTO.getAnswerCorrect());
            preStm.setString(3, questionDTO.getSubjectId());
            preStm.setBoolean(4, questionDTO.isStatus());
            preStm.setString(5, questionDTO.getId());
            check1 = preStm.executeUpdate() > 0;
            for (AnswerDTO answerDTO : questionDTO.getListAnswer()) {
                sql = "Update tblAnswer Set Content = ?,\n"
                        + "QuestionID = ?\n"
                        + "Where ID = ?";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, answerDTO.getContent());
                preStm.setString(2, answerDTO.getQuestionId());
                preStm.setString(3, answerDTO.getId());
                check2 = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return (check1 || check2);
    }

    public boolean insert(QuestionDTO questionDTO) throws Exception {
        boolean check1 = false;
        boolean check2 = false;
        try {
            String sql = "Insert into tblQuestion(ID,Content,AnswerCorrect,CreateDate,SubjectID,Status) Values (?,?,?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, questionDTO.getId());
            preStm.setString(2, questionDTO.getContent());
            preStm.setString(3, questionDTO.getAnswerCorrect());
            preStm.setString(4, questionDTO.getStringCreateDate());
            preStm.setString(5, questionDTO.getSubjectId());
            preStm.setBoolean(6, questionDTO.isStatus());
            check1 = preStm.executeUpdate() > 0;
            for (AnswerDTO answerDTO : questionDTO.getListAnswer()) {
                sql = "Insert into tblAnswer(ID,Content,QuestionID) Values(?,?,?) ";
                preStm = conn.prepareStatement(sql);
                preStm.setString(1, answerDTO.getId());
                preStm.setString(2, answerDTO.getContent());
                preStm.setString(3, answerDTO.getQuestionId());
                check2 = preStm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return (check1 && check2);
    }

    public List<AnswerDTO> getListAnswerByQuestionID(String questionID) throws Exception {
        List<AnswerDTO> listAnswer = new ArrayList<>();
        try {
            String sql = "Select ID,Content,QuestionID\n"
                    + "From tblAnswer\n"
                    + "Where QuestionID = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, questionID);
            rs = preStm.executeQuery();
            while (rs.next()) {
                AnswerDTO answerDTO = new AnswerDTO();
                answerDTO.setId(rs.getString("ID"));
                answerDTO.setContent(rs.getString("Content"));
                answerDTO.setQuestionId(rs.getString("QuestionID"));
                listAnswer.add(answerDTO);
            }
        } finally {
            closeConnection();
        }
        return listAnswer;
    }

    public String getLastID() throws Exception {
        String result = "";
        try {
            String sql = "Select ID From tblQuestion\n"
                    + "Where \n"
                    + "SUBSTRING(ID,3,LEN(ID)) IN (Select MAX(CONVERT(int,SUBSTRING(ID,3,LEN(ID)))) From tblQuestion)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            rs = preStm.executeQuery();
            if (rs.next()) {
                result = rs.getString(1);
            }
        } finally {
            closeConnection();
        }
        return result;
    }

}
