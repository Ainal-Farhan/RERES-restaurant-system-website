/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.database.SQLStatementList;
import com.RERES.path.Path;
import java.sql.Connection;
import com.RERES.references.TopNavigationBarReference;
import com.RERES.view.View;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*; 
import java.text.ParseException;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author ainal farhan
 */
public class DashboardServlet extends HttpServlet {
    private final String ACTION_VIEW_DASHBOARD = "viewDashboard";
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
            /* TODO output your page here. You may use following sample code. */
            
            RequestDispatcher dispatcher = getServletConfig().getServletContext().getRequestDispatcher(Path.DASHBOARD_PATH);
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
                
        if(action == null) {
            
        }
        else if(action.equals(ACTION_VIEW_DASHBOARD)) {
            request.setAttribute(TopNavigationBarReference.SELECTED_PAGE, TopNavigationBarReference.DASHBOARD_PAGE);
            
            getBookingPrice(request, response);
            
            View.forwardPage(request, response, Path.DASHBOARD_PATH);
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

    
    private void getBookingPrice(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try{
        ArrayList <String> dateYear = new ArrayList<>();
        ArrayList <String> dateMonth = new ArrayList<>();
        ArrayList <String> dateDay= new ArrayList<>();

        ArrayList<Double> bookingPriceYear = new ArrayList<>();
        ArrayList<Double> bookingPriceMonth = new ArrayList<>();
        ArrayList<Double> bookingPriceDay = new ArrayList<>();
        
        Connection con = new Database().getCon();
        PreparedStatement statement = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_DATAPOINTYEAR);

        ResultSet resultSet = statement.executeQuery();

            while(resultSet.next()){
                dateYear.add(resultSet.getString("EXTRACT(YEAR FROM booking_date)"));
                dateMonth.add(resultSet.getString("EXTRACT(Month FROM booking_date)"));
                dateDay.add(resultSet.getString("EXTRACT(Day FROM booking_date)"));
                bookingPriceYear.add(resultSet.getDouble("booking_price"));
                bookingPriceMonth.add(resultSet.getDouble("booking_price"));
                bookingPriceDay.add(resultSet.getDouble("booking_price"));

            }
        request.setAttribute("dateYear", dateYear);
        request.setAttribute("dateMonth", dateMonth);
        request.setAttribute("dateDay", dateDay);

        request.setAttribute("bookingPrice", bookingPriceYear);        
        
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
