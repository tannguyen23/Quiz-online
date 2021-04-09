/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.servlets;

import java.io.IOException;
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
public class UpdateQuestionServlet extends HttpServlet {

    private static final String SUCCESS = "SearchQuestionServlet";
    private static final String ERROR = "error.jsp";
    final static Logger LOGGER = Logger.getLogger(UpdateQuestionServlet.class);
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url = ERROR;
        try {
            QuestionDTO questionDTO = new QuestionDTO();
            String idQuestion = request.getParameter("txtID");
            QuestionDAO questionDAO = new QuestionDAO();
            ArrayList<AnswerDTO> listAnswer = (ArrayList<AnswerDTO>) questionDAO.getListAnswerByQuestionID(idQuestion);
            String content = request.getParameter("txtContent");
            String answerCorrect = request.getParameter("rdoAnswer");
            String subjectID = request.getParameter("slSubject");
            String status = request.getParameter("slStatus");
            questionDTO.setId(idQuestion);
            questionDTO.setContent(content);
            questionDTO.setSubjectId(subjectID);
            questionDTO.setAnswerCorrect(String.valueOf(answerCorrect.charAt(answerCorrect.length() - 1)));
            if (status.equals("true")) {
                questionDTO.setStatus(true);
            } else {
                questionDTO.setStatus(false);
            }
            for (AnswerDTO dto : listAnswer) {
                AnswerDTO answerDTO = new AnswerDTO();
                String contentAnswer = request.getParameter("txtAnswer" + dto.getId());
                answerDTO.setId(dto.getId());
                answerDTO.setContent(contentAnswer);
                answerDTO.setQuestionId(idQuestion);
                questionDTO.getListAnswer().add(answerDTO);
            }

            boolean check = false;
            check = questionDAO.update(questionDTO);
            if (check) {
                url = SUCCESS;
            }
        } catch (Exception e) {
            LOGGER.error("Error at UpdateQuestionServlet : " + e.getMessage());
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
