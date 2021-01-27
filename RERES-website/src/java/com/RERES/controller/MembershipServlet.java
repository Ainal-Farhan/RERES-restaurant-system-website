/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.database.SQLStatementList;
import com.RERES.model.Membership;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class MembershipServlet extends HttpServlet {
    final String ACTION_VIEW_MEMBERSHIP_PAGE="viewMembershipPage";
    final String ACTION_RENEW_MEMBERSHIP="RenewMembership";
  
    private static Membership membership;
    
    final String[] PUBLIC_INFO_LABELS = {
        "No",
        "Name",
        "Age",
        "Email",
        "Profile Picture",
    };
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String action=request.getParameter("action");
        
            if(action==null){

            }
            else if (action.equals(ACTION_VIEW_MEMBERSHIP_PAGE)){
                request.setAttribute("selectedPage", "membershipPage");
                setSpecificUserMembershipInformation(request);
                request.setAttribute("membership",membership);
                request.getRequestDispatcher("/WEB-INF/jsp/src/views/membership.jsp").forward(request, response);
            }
            else if (action.equals(ACTION_RENEW_MEMBERSHIP)){
                request.setAttribute("selectedPage", "membershipPage");
                setRenewMembership(request);
                request.setAttribute("membership",membership);
                request.getRequestDispatcher("/WEB-INF/jsp/src/views/membership.jsp").forward(request, response);
            }
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
        if(!com.RERES.utility.SessionValidator.checkSession(request, response)) return;
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
        if(!com.RERES.utility.SessionValidator.checkSession(request, response)) return;
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

    private void setRenewMembership(HttpServletRequest request) 
            throws ServletException, IOException {
        
        try {
       
           Connection con = new Database().getCon();
           PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_MEMBERSHIP_STATUS);
          
           st.setString(1 ,"member");
           st.setInt(2, membership.getMemberID());
           
           int result=st.executeUpdate();
            if(result>0) {

                membership.setMemberStatus("member");
             }
        }
        catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }  
    }
    
    private void setSpecificUserMembershipInformation(HttpServletRequest request) 
            throws ServletException, IOException {

        try {
           membership = new Membership();
           HttpSession session= request.getSession();        
           Connection con = new Database().getCon();


           PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_SPECIFIC_MEMBERSHIP_INFORMATION);
          
           st.setInt(1 ,(Integer)session.getAttribute("currentUserID") );
           

           ResultSet result = st.executeQuery();

            if(result.next()) {

                membership.setFkUserID(result.getInt("fk_userID"));
                membership.setMemberID(result.getInt("member_id"));
                membership.setMemberName(result.getString("member_name"));
                membership.setMemberStatus(result.getString("member_status"));
                membership.setSuccessBookingMade(result.getInt("success_booking_made"));


             }
        }
        catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }       
    }
}
