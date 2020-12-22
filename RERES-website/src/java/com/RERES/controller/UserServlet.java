/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.database.SQLStatementList;
import com.RERES.middleware.Customer;
import com.RERES.middleware.Staff;
import com.RERES.path.Path;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
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
public class UserServlet extends HttpServlet {

    private ArrayList<Staff> staff;
    private ArrayList<Customer> customers;
    
    final String[] labels = {
        "No",
        "Username",
        "Password",
        "User Type",
        "ID",
        "Name",
        "Birth Date",
        "Age",
        "Email",
        "Address",
        "Gender",
        "Profile Picture",
    };

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try (PrintWriter out = response.getWriter()) {            
            setStaffInformation();
            setCustomerInformation();
            
            request.setAttribute("customers", this.customers);
            request.setAttribute("staff", this.staff);
            request.setAttribute("labels", this.labels);
            
            String currentUserType = "admin";
            request.setAttribute("currentUserType", currentUserType);
            
            RequestDispatcher reqDispatcher = getServletConfig().getServletContext().getRequestDispatcher(Path.VIEW_USER_LIST_VIEW_PATH);
            reqDispatcher.forward(request,response);
        }
        catch(SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void setStaffInformation() throws SQLException {
        try {
            staff = new ArrayList<Staff>();
                    
            Connection con = null;
            con = new Database().getCon();
            
            Statement st = con.createStatement();
            
            ResultSet result = st.executeQuery(SQLStatementList.SQL_STATEMENT_RETRIEVE_ALL_STAFF_AND_USER_INFORMATION);

            while(result.next()) {
                Staff user = new Staff();

                user.setUserInformation(result.getInt("user_id"), result.getString("username"), 
                        result.getString("password"), result.getString("user_type"));
                
                user.setStaffOrCustomerInformation(result.getString("staff_name"), result.getString("staff_birth_date"), 
                        result.getInt("staff_age"), result.getString("staff_email"), result.getString("staff_address"), 
                        result.getString("staff_phone_number"), result.getString("staff_gender"), result.getString("staff_profile_picture_path"));
                
                user.setStaffID(result.getInt("staff_id"));
                
                staff.add(user);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private void setCustomerInformation() throws SQLException {
        try {
            customers = new ArrayList<Customer>();
                    
            Connection con = null;
            con = new Database().getCon();
            
            Statement st = con.createStatement();
            
            ResultSet result = st.executeQuery(SQLStatementList.SQL_STATEMENT_RETRIEVE_ALL_CUSTOMERS_AND_USER_INFORMATION);

            while(result.next()) {
                Customer user = new Customer();

                user.setUserInformation(result.getInt("user_id"), result.getString("username"), 
                        result.getString("password"), result.getString("user_type"));
                
                user.setStaffOrCustomerInformation(result.getString("customer_name"), result.getString("customer_birth_date"), 
                        result.getInt("customer_age"), result.getString("customer_email"), result.getString("customer_address"), 
                        result.getString("customer_phone_number"), result.getString("customer_gender"), result.getString("customer_profile_picture_path"));
                
                user.setCustomerID(result.getInt("customer_id"));
                
                customers.add(user);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
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
