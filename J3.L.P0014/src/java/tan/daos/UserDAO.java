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
import tan.db.MyConnection;
import tan.dtos.UserDTO;

/**
 *
 * @author tanta
 */
public class UserDAO implements Serializable{
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

    public String checkLogin(String email, String password) throws Exception {
        String role = "failed";
        try {
            String sql = "Select r.Name From tblUser u join tblRole r on u.Role = r.ID\n"
                    + "Where Email = ? And Password = ? And Status = 1";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            preStm.setString(2, password);
            rs = preStm.executeQuery();
            if (rs.next()) {
                role = rs.getString("Name");
            }
        } finally {
            closeConnection();
        }
        return role;
    }
    
    public UserDTO getUserByEmail(String email) throws Exception {
        UserDTO userDTO = new UserDTO();
        try {
            String sql = "Select Email,Name,Role From tblUser Where Email = ?";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, email);
            rs = preStm.executeQuery();
            if (rs.next()) {
                userDTO.setEmail(rs.getString("Email"));
                userDTO.setName(rs.getString("Name"));
                userDTO.setRole(rs.getString("role"));
            }
        } finally {
            closeConnection();
        }
        return userDTO;
    }
    
    public boolean insert(UserDTO userDTO, String password) throws Exception {
        boolean check = false;
        try {
            String sql ="Insert into tblUser(Email,Name,Password,Role,Status) Values(?,?,?,?,?)";
            conn = MyConnection.getMyConnection();
            preStm = conn.prepareStatement(sql);
            preStm.setString(1, userDTO.getEmail());
            preStm.setString(2, userDTO.getName());
            preStm.setString(3, password);
            preStm.setString(4, userDTO.getRole());
            preStm.setBoolean(5, userDTO.isStatus());
            check = preStm.executeUpdate() > 0;
        } finally {
            closeConnection();
        }
        return check;
    }
}
