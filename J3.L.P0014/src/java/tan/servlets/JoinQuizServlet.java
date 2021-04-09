/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tan.servlets;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tan.daos.QuestionDAO;
import tan.daos.SubjectDAO;
import tan.dtos.QuestionDTO;
import tan.dtos.SubjectDTO;

/**
 *
 * @author tanta
 */
public class JoinQuizServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "quiz.jsp";
    private static final String SUBMIT = "SubmitQuizServlet";
    final static Logger LOGGER = Logger.getLogger(JoinQuizServlet.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            int currentQuestionPos = 0;
            int questionPos = 0;
            String txtQuestionPos = request.getParameter("questionPos");
            if (txtQuestionPos != null) {
                currentQuestionPos = Integer.parseInt(txtQuestionPos);
                questionPos = currentQuestionPos;
            }
            String action = request.getParameter("action");
            if (action != null) {
                if (action.equals("next")) {
                    questionPos++;
                } else if (action.equals("previous")) {
                    questionPos--;
                } else if (action.equals("submit")) {
                    url = SUBMIT;
                }
            }
            LocalDateTime lcTimeStart;
            LocalDateTime lcTimeEnd;
            HttpSession session = request.getSession();
            ArrayList<QuestionDTO> listQuestion = (ArrayList<QuestionDTO>) session.getAttribute("listQuestion");
            String subjectID = request.getParameter("txtSubjectID");
            int totalSecond, timePass = 0;
            if (subjectID != null) {
                SubjectDAO subjectDAO = new SubjectDAO();
                SubjectDTO subjectDTO = subjectDAO.getSubjectByID(subjectID);
                int hour = subjectDTO.getTime().getHours();
                int minute = subjectDTO.getTime().getMinutes();
                int second = subjectDTO.getTime().getSeconds();
                totalSecond = hour * 60 * 60 + minute * 60 + second;
                lcTimeStart = LocalDateTime.now();
                lcTimeEnd = lcTimeStart.plusHours(hour).plusMinutes(minute).plusSeconds(second);
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss dd-MM-yyyy ");
                QuestionDAO questionDAO = new QuestionDAO();
                listQuestion = (ArrayList<QuestionDTO>) questionDAO.getListQuestion(subjectID, subjectDTO.getMount());
            } else {
                totalSecond = (int) session.getAttribute("timeLimit");
                lcTimeStart = (LocalDateTime) session.getAttribute("timeStart");
                lcTimeEnd = (LocalDateTime) session.getAttribute("timeEnd");
                LocalDateTime lcTimeNow = LocalDateTime.now();
                int hour = lcTimeStart.getHour();
                int minute = lcTimeStart.getMinute();
                int second = lcTimeStart.getSecond();
                LocalDateTime lcTimePass = lcTimeNow.minusHours(hour).minusMinutes(minute).minusSeconds(second);
                hour = lcTimePass.getHour();
                minute = lcTimePass.getMinute();
                second = lcTimePass.getSecond();
                timePass = hour * 60 * 60 + minute * 60 + second;

            }
            String answer = request.getParameter("slAnswer");
            if (answer != null) {
                listQuestion.get(currentQuestionPos).setAnswerCorrect(answer);
            }

            session.setAttribute("timeLimit", totalSecond);
            session.setAttribute("listQuestion", listQuestion);
            session.setAttribute("timeStart", lcTimeStart);
            session.setAttribute("timeEnd", lcTimeEnd);
            session.setAttribute("timePass", timePass);
            request.setAttribute("questionQuiz", listQuestion.get(questionPos));
            request.setAttribute("questionPos", questionPos);
            if (!url.equals(SUBMIT)) {
                url = SUCCESS;
            }
        } catch (Exception e) {
            e.printStackTrace();
            LOGGER.error("Error at JoinQuizServlet : " + e.getMessage());
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
