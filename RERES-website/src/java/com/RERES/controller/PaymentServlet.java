/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.database.SQLStatementList;
import com.RERES.path.Path;
import com.RERES.view.View;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
public class PaymentServlet extends HttpServlet {
    private final String ACTION_VIEW_PAYMENT_FORM = "viewPaymentForm";
    private final String ACTION_PAY = "pay";
    
    
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
            RequestDispatcher dispatcher = getServletConfig().getServletContext().getRequestDispatcher(Path.PAYMENT_FORM_VIEW_PATH);
            dispatcher.forward(request, response);
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
        String action = request.getParameter("action");
        
        if(isStringIsNullOrEmpty(action)) {
            
        }
        else if(action.equals(ACTION_VIEW_PAYMENT_FORM)) {
            request.setAttribute("selectedPage", "bookingTablePage");
            processViewPaymentForm(request, response);
        }
        else if(action.equals(ACTION_PAY)) {
            request.setAttribute("selectedPage", "bookingTablePage");
            processPay(request, response);
        }
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
    
    private void processViewPaymentForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        double payAmount = Double.parseDouble(request.getParameter("payAmount"));
        String payName = request.getParameter("payName");
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        
        request.setAttribute("payAmount", payAmount);
        request.setAttribute("payName", payName);
        request.setAttribute("bookingID", bookingID);
        
        forwardPage(request, response, Path.MAIN_VIEW_PATH + "/paymentForm.jsp");
    }
    
    private void processPay(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String payMethod = request.getParameter("PaymentOptions");
        double paidAmount = Double.parseDouble(request.getParameter("total-payment"));
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        
        String message = "";
        
        if(isStringIsNullOrEmpty(payMethod)) {
            
        }
        else {
            if(updateBookingAndPaymentStatusInTheDatabase(payMethod, paidAmount, bookingID)) {
                message = String.format("Successfully paid RM%.2f", paidAmount);
                
            }
            else {
                message = String.format("Failed to pay RM%.2f for the booking", paidAmount);
            }
            
            String[] nameLabels = {"bookingID"};
            String[] valueLabels = {Integer.toString(bookingID)};
            
            View.setOverlayStatusMessage(request, response, "viewPaymentHistory", message, "BookingServlet", nameLabels, valueLabels);
            View.includePage(request, response, Path.HOME_VIEW_PATH);
        }
        
    }
    
    private void forwardPage(HttpServletRequest request, HttpServletResponse response,String pagePath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagePath);
        dispatcher.forward(request, response);
    }
    
    private boolean isStringIsNullOrEmpty(String inputString) {
        return inputString == null || inputString.equals("");
    }
    
    private boolean updateBookingAndPaymentStatusInTheDatabase(String payMethod, double paidAmount, int bookingID) {
        Connection con;
        try {
            con = new Database().getCon();
            PreparedStatement st1 = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_PAYMENT_INFORMATION_WITH_BOOKING_ID);
            st1.setInt(1, bookingID);
            
            ResultSet result1 = st1.executeQuery();
                        
            if(result1 == null) {
                PreparedStatement st2 = con.prepareStatement(SQLStatementList.SQL_STATEMENT_INSERT_SUCCESSFULLY_PAY_FOR_A_BOOKING);
                st2.setString(1, payMethod);
                st2.setDouble(2, paidAmount);
                st2.setInt(3, bookingID);
                
                st2.executeUpdate();
            }
            else {
                PreparedStatement st3 = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_A_PAYMENT_INFORMATION);
                st3.setString(1, "done");
                st3.setString(2, payMethod);
                st3.setDouble(3, paidAmount);
                                
                st3.setDate(4, new java.sql.Date(Calendar.getInstance().getTime().getTime()));
                st3.setInt(5, bookingID);
                
                st3.executeUpdate();
            }
            
            PreparedStatement st4 = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_THE_BOOKING_STATUS);
            
            st4.setString(1, "success");
            st4.setInt(2, bookingID);
            
            int result4 = st4.executeUpdate();
            
            return result4 != 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
