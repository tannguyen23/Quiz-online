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
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tan.daos.SubjectDAO;
import tan.daos.SubmissionDAO;
import tan.dtos.SubjectDTO;
import tan.dtos.SubmissionDTO;
import tan.dtos.UserDTO;

/**
 *
 * @author tanta
 */
public class SearchHistoryServlet extends HttpServlet {

    private static final String SUCCESS = "history.jsp";
    private static final String ERROR = "error.jsp";
    private static final int MOUNTEACHPAGE = 20;
    final static Logger LOGGER = Logger.getLogger(SearchHistoryServlet.class);
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String searchContent = request.getParameter("txtSearchContent");
            String slSearchSubject = request.getParameter("slSearchSubject");
            if (searchContent == null) {
                searchContent = "";
            }
            if (slSearchSubject == null) {
                slSearchSubject = "all";
            }
            String txtIndex = request.getParameter("txtIndex");
            int index = 1;
            if (txtIndex != null) {
                index = Integer.parseInt(txtIndex);
            }
            HttpSession session = request.getSession();
            UserDTO userDTO = (UserDTO) session.getAttribute("user");
            SubmissionDAO submissionDAO = new SubmissionDAO();
            SubjectDAO subjectDAO = new SubjectDAO();
            int totalPage = submissionDAO.getTotalPageSubmissionSearch(MOUNTEACHPAGE, userDTO.getEmail(), searchContent, slSearchSubject);
            ArrayList<SubjectDTO> listSubject = (ArrayList<SubjectDTO>) subjectDAO.getListSubject();
            ArrayList<SubmissionDTO> listSubmission
                    = (ArrayList<SubmissionDTO>) submissionDAO.getListSubmissionSearch(index, MOUNTEACHPAGE, userDTO.getEmail(), searchContent, slSearchSubject);
            request.setAttribute("listSubject", listSubject);
            request.setAttribute("listSubmission", listSubmission);
            request.setAttribute("totalPage", totalPage);
            request.setAttribute("txtSearchContent", searchContent);
            request.setAttribute("slSearchSubject", slSearchSubject);
            request.setAttribute("sequenceNumber", (index - 1)* MOUNTEACHPAGE);
            url = SUCCESS;
        } catch (Exception e) {
            LOGGER.error("Error at SearchHistoryServlet : " + e.getMessage());
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
