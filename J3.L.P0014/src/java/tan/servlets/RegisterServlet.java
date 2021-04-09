/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tan.daos.UserDAO;
import tan.dtos.UserDTO;
import tan.encrypts.Encrypt;

/**
 *
 * @author tanta
 */
public class RegisterServlet extends HttpServlet {

    private static final String SUCCESS = "welcome.jsp";
    private static final String ERROR = "error.jsp";
    private static final String FAILED = "register.jsp";
    final static Logger LOGGER = Logger.getLogger(RegisterServlet.class);
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        String url = ERROR;
        try {
            String email = request.getParameter("txtEmail");
            String name = request.getParameter("txtName");
            String password = request.getParameter("txtPassword");
            String sha256Password = Encrypt.toHexString(password);
            UserDTO userDTO = new UserDTO();
            userDTO.setEmail(email);
            userDTO.setName(name);
            userDTO.setRole("us");
            userDTO.setStatus(true);
            UserDAO userDAO = new UserDAO();
            try {
                if (userDAO.insert(userDTO, sha256Password)) {
                    HttpSession session = request.getSession();
                    session.setAttribute("user", userDTO);
                    url = SUCCESS;
                }
            } catch (Exception e) {
                if (e.getMessage().contains("duplicate key")) {
                    request.setAttribute("email", email);
                    request.setAttribute("name", name);
                    request.setAttribute("emailError", "This email has been used !");
                    url = FAILED;
                }
            }

        } catch (Exception e) {
            LOGGER.error("Error at RegisterServlet : " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
