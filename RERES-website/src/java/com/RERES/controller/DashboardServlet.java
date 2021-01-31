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
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author ainal farhan
 */
public class DashboardServlet extends HttpServlet {
    private final String ACTION_VIEW_DASHBOARD = "viewDashboard";
    private final String ACTION_VIEW_BOOKING_MONEY_GAINED = "viewBookingMoneyGainedForSelectedYearAndMonth";
    
    private final int MONTHS_PER_YEAR = 12;
    
    private final int DEFAULT_YEAR = 2021;
    private final int DEFAULT_MONTH = 1;
    private final int DEFAULT_DAY = 1;
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
            
        View.forwardPage(request, response, Path.DASHBOARD_PATH);
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
            setupGraphData(request, response);
            View.forwardPage(request, response, Path.DASHBOARD_PATH);
        }else if(action.equals(ACTION_VIEW_BOOKING_MONEY_GAINED)) {
            request.setAttribute(TopNavigationBarReference.SELECTED_PAGE, TopNavigationBarReference.DASHBOARD_PAGE);
            setupGraphData(request, response);
            View.forwardPage(request, response, Path.DASHBOARD_PATH);
        }
    }
    
    private void setupGraphData(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        getBookingPrice(request, response);
        getBookingPriceForSelectedMonthAndYear(request, response);
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

    
    private void getBookingPriceForSelectedMonthAndYear(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try{
            
            String selectedYear = request.getParameter("selectedYear");
            String selectedMonth = request.getParameter("selectedMonth");
            
            if(selectedYear == null || selectedMonth == null) {
                selectedYear = Integer.toString(DEFAULT_YEAR);
                selectedMonth = Integer.toString(DEFAULT_MONTH);
            }
            
            ArrayList<String> dateDays = new ArrayList<>();

            Double[] bookingPriceMonth = new Double[MONTHS_PER_YEAR];
            ArrayList<Double> bookingPriceDay = new ArrayList<>();

            Connection con = new Database().getCon();
            
            PreparedStatement statementForSelectedMonth = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_MONEY_GAINED_SELECTED_MONTH);
            // For YEAR
            statementForSelectedMonth.setInt(1, Integer.parseInt(selectedYear));
            // For MONTH
            statementForSelectedMonth.setInt(2, Integer.parseInt(selectedMonth));
            
            PreparedStatement statementForSelectedYear = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_MONEY_GAINED_SELECTED_YEAR);
            // For YEAR
            statementForSelectedYear.setInt(1, Integer.parseInt(selectedYear));

            ResultSet resultSetForSelectedMonth = statementForSelectedMonth.executeQuery();
            ResultSet resultSetForSelectedYear = statementForSelectedYear.executeQuery();

            ArrayList<String> tempDateDays = new ArrayList<>();
            ArrayList<Double> tempBookingPriceDay = new ArrayList<>();
            
            while(resultSetForSelectedMonth.next()) {
                tempBookingPriceDay.add(resultSetForSelectedMonth.getDouble("booking_price"));
                tempDateDays.add(resultSetForSelectedMonth.getString("EXTRACT(DAY FROM booking_date)"));
            }
            
            for(int i = 0; i < tempDateDays.size(); i++) {
                String day = tempDateDays.get(i);
                double totalPrice = tempBookingPriceDay.get(i);
                
                while(i+1 < tempDateDays.size() && tempDateDays.get(i).equals(tempDateDays.get(i+1))) {
                    totalPrice += tempBookingPriceDay.get(i+1);
                    i++;
                }
                
                dateDays.add(day);
                bookingPriceDay.add(totalPrice);
            }
            
            for(int i = 0; i < MONTHS_PER_YEAR; i++) bookingPriceMonth[i] = .0;
            
            while(resultSetForSelectedYear.next()) {
                bookingPriceMonth[Integer.parseInt(resultSetForSelectedYear.getString("EXTRACT(MONTH FROM booking_date)")) - 1] 
                        += resultSetForSelectedYear.getDouble("booking_price");
            }
            
            request.setAttribute("dateSelectedYear", selectedYear);
            request.setAttribute("dateSelectedMonth", selectedMonth);
            request.setAttribute("dateDays", dateDays);  
            
            request.setAttribute("bookingPricePerMonth", bookingPriceMonth);
            request.setAttribute("bookingPricePerDay", bookingPriceDay);
        
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
    
    private void getBookingPrice(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try{
            ArrayList<String> years = new ArrayList<>();
            ArrayList<Double> totalBookingPricePerYear = new ArrayList<>();

            Connection con = new Database().getCon();
            PreparedStatement statement = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_MONEY_GAINED_LATEST_5_YEARS);

            ResultSet resultSet = statement.executeQuery();
            
            ArrayList<String> tempYears = new ArrayList<>();
            ArrayList<Double> tempTotalBookingPricePerYear = new ArrayList<>();
            
            while(resultSet.next()) {
                tempYears.add(resultSet.getString("EXTRACT(YEAR FROM booking_date)"));
                tempTotalBookingPricePerYear.add(resultSet.getDouble("booking_price"));
            }
            
            for(int i = 0; i < tempYears.size(); i++) {
                String year = tempYears.get(i);
                double totalPrice = tempTotalBookingPricePerYear.get(i);
                
                while(i+1 < tempYears.size() && tempYears.get(i).equals(tempYears.get(i+1))) {
                    totalPrice += tempTotalBookingPricePerYear.get(i+1);
                    i++;
                }
                
                years.add(year);
                totalBookingPricePerYear.add(totalPrice);
            }
            
            request.setAttribute("years", years);
            request.setAttribute("totalBookingPricePerYear", totalBookingPricePerYear);
        
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        } 
    }
}
