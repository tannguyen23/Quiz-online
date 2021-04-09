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
import tan.daos.UserDAO;
import tan.dtos.UserDTO;
import tan.encrypts.Encrypt;
import org.apache.log4j.Logger;
/**
 *
 * @author tanta
 */
public class LoginServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String ADMIN = "welcomeAdmin.jsp";
    private static final String USER = "welcome.jsp";
    private static final String FAILED = "login.jsp";
    final static Logger LOGGER = Logger.getLogger(LoginServlet.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            String email = request.getParameter("txtEmail");
            String password = request.getParameter("txtPassword");
            String sha256Password = Encrypt.toHexString(password);
            UserDAO userDAO = new UserDAO();
            String role = userDAO.checkLogin(email, sha256Password);
            if (role.equals("failed")) {
                request.setAttribute("errorLogin", "Account is not found");
                url = FAILED;
            } else {
                UserDTO userDTO = userDAO.getUserByEmail(email);
                session.setAttribute("user", userDTO);
                if (role.equals("admin")) {
                    url = ADMIN;
                } else {
                    url = USER;
                }
            }

        } catch (Exception e) {
            LOGGER.error("Error at LoginServlet : " + e.getMessage());
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
