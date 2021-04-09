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
import tan.daos.SubjectDAO;
import tan.dtos.QuestionDTO;
import tan.dtos.SubjectDTO;

/**
 *
 * @author tanta
 */
public class SearchQuestionServlet extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "admin.jsp";
    private static final int MOUNTEACHPAGE = 20;
    final static Logger LOGGER = Logger.getLogger(SearchQuestionServlet.class);
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url = ERROR;
        try {
            QuestionDAO questionDAO = new QuestionDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            String searchContent = request.getParameter("txtSearchContent");
            String slSearchStatus = request.getParameter("slSearchStatus");
            String slSearchSubject = request.getParameter("slSearchSubject");
            if (searchContent == null) {
                searchContent = "";
            }
            if (slSearchStatus == null) {
                slSearchStatus ="all";
            }
            if (slSearchSubject == null) {
                slSearchSubject = "all";
            }
            int totalPage = questionDAO.getTotalPageQuestionSearch(MOUNTEACHPAGE,searchContent,slSearchStatus,slSearchSubject);
            String txtIndex = request.getParameter("txtIndex");
            int index = 1;
            if (txtIndex != null) {
                index = Integer.parseInt(txtIndex);
            }
            ArrayList<QuestionDTO> listQuestion = (ArrayList<QuestionDTO>) questionDAO.getListQuestionSearchByIndex(index, MOUNTEACHPAGE,searchContent,slSearchStatus,slSearchSubject);
            ArrayList<SubjectDTO> listSubject = (ArrayList<SubjectDTO>) subjectDAO.getListSubject();
            request.setAttribute("listQuestion", listQuestion);
            request.setAttribute("listSubject", listSubject);
            request.setAttribute("index", index);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("txtSearchContent", searchContent);
            request.setAttribute("slSearchStatus", slSearchStatus);
            request.setAttribute("slSearchSubject", slSearchSubject);
            request.setAttribute("sequenceNumber", (index-1)*MOUNTEACHPAGE);
            url = SUCCESS;
        } catch (Exception e) {
            LOGGER.error("Error at SearchQuestionServlet : " + e.getMessage());
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
