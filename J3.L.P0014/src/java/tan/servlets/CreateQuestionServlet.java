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
import org.apache.log4j.Logger;
import tan.daos.QuestionDAO;
import tan.dtos.AnswerDTO;
import tan.dtos.QuestionDTO;

/**
 *
 * @author tanta
 */
public class CreateQuestionServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "viewListQuestion";
    final static Logger LOGGER = Logger.getLogger(CreateQuestionServlet.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            QuestionDAO questionDAO = new QuestionDAO();
            String lastID = questionDAO.getLastID();
            String idQuestion = "";
            if (lastID.isEmpty()) {
                idQuestion = "Q-1";
            } else {
                String[] tmp = lastID.split("-");
                int index = Integer.parseInt(tmp[1]);
                idQuestion = tmp[0] + "-" + String.valueOf(index + 1);
            }
            QuestionDTO questionDTO = new QuestionDTO();
            ArrayList<AnswerDTO> listAnswer = (ArrayList<AnswerDTO>) questionDAO.getListAnswerByQuestionID(idQuestion);
            String content = request.getParameter("txtContent");
            String answerCorrect = request.getParameter("rdoAnswer");
            String subjectID = request.getParameter("slSubject");
            String status = request.getParameter("slStatus");
            questionDTO.setId(idQuestion);
            questionDTO.setContent(content);
            questionDTO.setSubjectId(subjectID);
            questionDTO.setAnswerCorrect(answerCorrect);
            if (status.equals("true")) {
                questionDTO.setStatus(true);
            } else {
                questionDTO.setStatus(false);
            }
            questionDTO.setCreateDate(LocalDateTime.now());
            String[] listAnswerCharacter = {"A", "B", "C", "D"};
            for (String characterAnswer : listAnswerCharacter) {
                String contentAnswer = request.getParameter("txtAnswer" + characterAnswer);
                String idAnswer = idQuestion + "-" + characterAnswer;
                AnswerDTO answerDTO = new AnswerDTO();
                answerDTO.setId(idAnswer);
                answerDTO.setContent(contentAnswer);
                answerDTO.setQuestionId(idQuestion);
                questionDTO.getListAnswer().add(answerDTO);
            }
            boolean check = questionDAO.insert(questionDTO);
            if (check) {
                url = SUCCESS;
            }
        } catch (Exception e) {
            LOGGER.error("Error at CreateQuestionServlet : " + e.getMessage());
        } finally {
            response.sendRedirect(url);
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
