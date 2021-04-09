/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.servlets;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tan.daos.QuestionDAO;
import tan.daos.SubmissionDAO;
import tan.dtos.QuestionDTO;
import tan.dtos.SubmissionDTO;
import tan.dtos.UserDTO;

/**
 *
 * @author tanta
 */
public class SubmitQuizServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "result.jsp";
    final static Logger LOGGER = Logger.getLogger(SubmitQuizServlet.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            HttpSession session = request.getSession();
            QuestionDAO questionDAO = new QuestionDAO();
            SubmissionDAO submissionDAO = new SubmissionDAO();
            ArrayList<QuestionDTO> listQuestionSubmit = (ArrayList<QuestionDTO>) session.getAttribute("listQuestion");
            float point = questionDAO.getPoint(listQuestionSubmit);
            String subjectID = listQuestionSubmit.get(0).getSubjectId();
            UserDTO userDTO = (UserDTO) session.getAttribute("user");
            String userID = userDTO.getEmail();
            String lastID = submissionDAO.getLastID(userID, subjectID);
            String submissionID = "";
            if (lastID == null) {
                submissionID = userID + "-" + subjectID + "-" + "0";
            } else {
                String tmp[] = lastID.split("-");
                int index = Integer.parseInt(tmp[2]) + 1;
                submissionID = userID + "-" + subjectID + "-" + String.valueOf(index);
            }

            SubmissionDTO submissionDTO = new SubmissionDTO();
            submissionDTO.setId(submissionID);
            submissionDTO.setPoint(point);
            submissionDTO.setSubjectId(subjectID);
            submissionDTO.setUserId(userID);
            submissionDTO.setTimeSubmit(LocalDateTime.now());
            if (submissionDAO.insert(submissionDTO)) {
                request.setAttribute("point", submissionDTO.getPoint());
                request.setAttribute("timeSubmit", submissionDTO.getTextTimeSubmit());
                request.setAttribute("subject", submissionDTO.getSubjectId());
                url = SUCCESS;
            }
        } catch (Exception e) {
            LOGGER.error("Error at SubmitQuizServlet : " + e.getMessage());
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
