/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.path.Path;
import com.RERES.database.SQLStatementList;
import com.RERES.model.BookingTable;
import com.RERES.references.TopNavigationBarReference;
import static com.RERES.references.TopNavigationBarReference.HOME_PAGE;
import static com.RERES.references.TopNavigationBarReference.SELECTED_PAGE;
import com.RERES.view.View;

import java.io.IOException;
import java.sql.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author PC
 */
public class BookingTableServlet extends HttpServlet {
    
    private final String ACTION_VIEW_BOOKING_TABLE = "viewBookingTable";
    private final String ACTION_CHECK_AVAILABILITY = "checkAvailability";
    private final String ACTION_MAKE_RESERVATION = "makeReserve";
    private final String ACTION_MANAGE_TABLE = "manageTableBooking";
    private final String ACTION_CHANGE_BOOKING_TABLE_STATUS = "changeBookingTableStatus";
    
    
    private final String BOOKING_TABLE_STATUS_AVAILABLE = "available";
    private final String BOOKING_TABLE_STATUS_UNAVAILABLE = "unavailable";
    
    private static java.sql.Date bookDate;
    private static int timeCode;
    private static String timeSlot;
    private static int bookQuantity;
    private static double bookPrice;
    private static String checkMessage;
    private static String checkNoTableMessage;
    private static String discountMessage;
    
    private static ArrayList<BookingTable> bookingTables;

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
        request.setAttribute(SELECTED_PAGE, HOME_PAGE);
        View.setOverlayStatusMessage(request, response, "none", "doGet() is not used. Back to Home Page", "none", null, null);
        View.includePage(request, response, Path.HOME_VIEW_PATH);
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
            request.setAttribute(SELECTED_PAGE, HOME_PAGE);
            View.setOverlayStatusMessage(request, response, "none", "Some errors happen. Back to Home Page", "none", null, null);
            View.includePage(request, response, Path.HOME_VIEW_PATH);
        }
        else if(action.equals(ACTION_VIEW_BOOKING_TABLE)) {
            request.setAttribute("selectedPage", "bookingTablePage");
            forwardPage(request, response, Path.BOOKING_TABLE_VIEW_PATH);
        }
        else if(action.equals(ACTION_CHECK_AVAILABILITY)) {
            request.setAttribute("selectedPage", "bookingTablePage");
            processCheckTable(request, response);
        }
        else if(action.equals(ACTION_MAKE_RESERVATION)) {
            processMakeReservation(request, response);
        }
        else if(action.equals(ACTION_MANAGE_TABLE)) {
            request.setAttribute(TopNavigationBarReference.SELECTED_PAGE, TopNavigationBarReference.MANAGE_TABLE_PAGE);
            processManageTable(request, response);
        }
        else if (action.equals(ACTION_CHANGE_BOOKING_TABLE_STATUS)) {
            request.setAttribute(TopNavigationBarReference.SELECTED_PAGE, TopNavigationBarReference.MANAGE_TABLE_PAGE);
            processChangeBookingTableStatus(request, response);
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
    
    private void processChangeBookingTableStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String status = request.getParameter("bookingTableStatus");
        int bookingTableID = Integer.parseInt(request.getParameter("bookingTableID"));
        
        if(status.toLowerCase().equals(BOOKING_TABLE_STATUS_AVAILABLE)) status = BOOKING_TABLE_STATUS_UNAVAILABLE;
        else status = BOOKING_TABLE_STATUS_AVAILABLE;
        
        String message = "";
        
        if(changeBookingTableStatusInDatabase(status, bookingTableID, request)) {
            message = "Successfully change booking status to " + status.toUpperCase();
        }
        else {
            message = "Failed to change the booking status to " + status.toUpperCase();
        }
        
        View.setOverlayStatusMessage(request, response, "manageTableBooking", message, "BookingTableServlet", null, null);
        
        request.setAttribute("bookingTables", bookingTables);
        View.includePage(request, response, Path.MANAGE_TABLE_PATH);
    }
    
    private boolean changeBookingTableStatusInDatabase(String status, int bookingTableID, HttpServletRequest request) 
            throws ServletException, IOException {
        try {            
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_BOOKING_TABLE_STATUS);
            
            st.setString(1, status);
            st.setInt(2, bookingTableID);
            
            while(st.executeUpdate() > 0) {
                if(bookingTables != null) {
                    for(int i =0; i < bookingTables.size(); i++) {
                        if(bookingTables.get(i).getBookingTableID() == bookingTableID) {
                            bookingTables.get(i).setBookingTableStatus(status);
                            break;
                        }
                    }
                }
                else {
                    getAllBookingTableInfo(request);
                }
                return true;
            }
            
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingTableServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    private void processCheckTable(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if(getTableAvailability(request)){
            forwardPage(request, response, Path.BOOKING_TABLE_VIEW_PATH);
        }
//        getTableAvailability(request);
//        forwardPage(request, response, Path.BOOKING_TABLE_VIEW_PATH);
    }
    
    private void processManageTable(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if(getAllBookingTableInfo(request)) {
            request.setAttribute("bookingTables", bookingTables);
            View.forwardPage(request, response, Path.MANAGE_TABLE_PATH);
        }
    }
    
    private boolean getAllBookingTableInfo(HttpServletRequest request) 
            throws ServletException, IOException {
        
            bookingTables = new ArrayList<>();
            
        try {            
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_BOOKING_TABLE);
            
            ResultSet rs = st.executeQuery();
            
            while(rs.next()) {
                BookingTable bookingTable = new BookingTable();
                
                bookingTable.setBookingTableID(rs.getInt("bookingTable_id"));
                bookingTable.setBookingTableCode(rs.getInt("bookingTable_code"));
                bookingTable.setBookingTableStatus(rs.getString("bookingTable_status"));
                bookingTable.setBookingTableCapacity(rs.getInt("bookingTable_capacity"));
                
                bookingTables.add(bookingTable);
            }
            
            return true;
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingTableServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
        
    }
    
    private void processMakeReservation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String orderFood = request.getParameter("foodOrder");
        if(orderFood.equals("now")) {
            if(setBookingTableIntoDatabase(request, response)) {
//                session.setAttribute("tableCode", request.getParameter("tableCode"));
//                session.setAttribute("bookDesc", request.getParameter("bookDescription"));
                session.setAttribute("timeCode", timeCode);
                
                String[] nameLabels = {"bookingPrice"};
                String[] valueLabels = {Double.toString(bookPrice)};
                
                View.setOverlayStatusMessage(request, response, "viewOrderFood", "Successfully booked a table. Proceed to Order Food", "OrderFoodServlet", nameLabels, valueLabels);
                
                View.includePage(request, response, Path.BOOKING_TABLE_VIEW_PATH);
            }
        }
        else {
            if(setBookingTableIntoDatabase(request, response)) {
                String[] nameLabels = {"payAmount", "payName", "ID", "actionPay", "actionCancelPay"};
                String[] valueLabels = {Double.toString(bookPrice), "" , Integer.toString((Integer)session.getAttribute("bookingID")), "payBooking", "cancelPayBooking"};

                View.setOverlayStatusMessage(request, response, "viewPaymentFormBooking", "Successfully booked a table. Proceed to payment page", "PaymentServlet", nameLabels, valueLabels);

                View.includePage(request, response, Path.BOOKING_TABLE_VIEW_PATH);
            }else {
                View.setOverlayStatusMessage(request, response, "viewBookingTable", "Failed to book a table", "BookingTableServlet", null, null);

                View.includePage(request, response, Path.BOOKING_TABLE_VIEW_PATH);
            }
        }
    }
    
    private boolean getTableAvailability(HttpServletRequest request) {
        
        try {
            ArrayList<BookingTable> bookingTableList;
            
            setStaticAttributes(request);
            
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_BOOKING_LIST_AND_TABLE_LIST);
            
            st.setDate(1, bookDate);
            st.setInt(2, timeCode);
            
            ResultSet rs = st.executeQuery();
            
            bookingTableList = getTablebookingList();
            
            if (!rs.isBeforeFirst()) {
                bookingTableList = filterTableBasedOnPerson(bookingTableList, personPicker(bookQuantity));
//                Logger.getLogger(Database.class.getName()).log(Level.INFO, bookDate.toString() + time + person + "inside isbeforefirst");
            }
            else {
                while(rs.next()) {
                    for(int i = 0;i<bookingTableList.size();i++) {
                        if((bookingTableList.get(i).getBookingTableID() == rs.getInt("bookingTable_id")) || (bookingTableList.get(i).getBookingTableCapacity() != personPicker(bookQuantity)) ) {
                            bookingTableList.remove(i);
                            i--;
//                            bookingTableList.removeAll(bookingTableList);
                        }
                    }
                }
                //Logger.getLogger(Database.class.getName()).log(Level.INFO, rs.getString("time_slot") + "inside while rs next");
            }
            
            request.setAttribute("isCheck", true);
            if(bookingTableList.isEmpty()){
                request.setAttribute("displayMessage", checkNoTableMessage);
            }
            else {
                request.setAttribute("displayMessage", checkMessage);
            }
            
            request.setAttribute("selectedDate", bookDate);
            request.setAttribute("bookDate", bookDate);
            request.setAttribute("timeCode", timeCode);
            request.setAttribute("bookQuantity", bookQuantity);
            request.setAttribute("timeSlot", timeSlot);
            request.setAttribute("btlist", bookingTableList);
            request.setAttribute("bookPrice", bookPrice);
            request.setAttribute("discountMessage", discountMessage);
            
            return true;
            
        } catch (ParseException | SQLException | ClassNotFoundException | ServletException | IOException ex) {
            Logger.getLogger(BookingTableServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    private boolean setBookingTableIntoDatabase(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            
            if(isStaticAttributesIsNull()) return false;
            
            if(MembershipServlet.fulfilRequirementForDiscount(request)) {
                MembershipServlet.setMembershipStatusToExpired(request);
            }
            
            int tableCode = Integer.parseInt(request.getParameter("tableCode"));
            String bookDesc = request.getParameter("bookDescription");
            int userId = (Integer)session.getAttribute("currentUserID");
            
            Logger.getLogger(Database.class.getName()).log(Level.INFO, bookDate.toString() + timeCode + timeSlot + tableCode + bookDesc + userId + bookQuantity + bookPrice);
            
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_INSERT_BOOKING_FOOD_LATER);
            
            st.setString(1, bookDesc);
            st.setDate(2, bookDate);
            st.setString(3, timeSlot);
            st.setInt(4, timeCode);
            st.setInt(5, bookQuantity);
            st.setDouble(6, bookPrice);
            st.setInt(7, userId);
            st.setInt(8, tableCode);
            
            // Statement to retrieve booking_id
            PreparedStatement st2 = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_BOOKING_INFO);
            st2.setInt(1, timeCode);
            st2.setDate(2, bookDate);
            st2.setInt(3, tableCode);
            
            // Statement to update the selected table status to unavailable
//            PreparedStatement st3 = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_BOOKING_TABLE_STATUS);
//            st3.setString(1, "unavailable");
//            st3.setInt(2, tableCode);
                    
            if(st.executeUpdate() > 0) {
                ResultSet result2 = st2.executeQuery();
                
                if(result2.next()) {
                    // Statement to insert the payment info
                    PreparedStatement st4 = con.prepareStatement(SQLStatementList.SQL_STATEMENT_INSERT_PAYMENT_INFO);
                    st4.setInt(1, result2.getInt("booking_id"));
                    session.setAttribute("bookingID", result2.getInt("booking_id"));
                    
                    if(st4.executeUpdate() > 0) {
                        return true;
                    }
                    
                } 
            }
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingTableServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    private boolean isStaticAttributesIsNull() {
        return bookDate == null || timeCode == 0 || bookQuantity == 0;
    }
    
    private void setStaticAttributes(HttpServletRequest request)
        throws ServletException, IOException, ParseException {
        
        String date = request.getParameter("bookDate");
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date myDate = formatter.parse(date);
        bookDate = new java.sql.Date(myDate.getTime());
        timeCode = Integer.parseInt(request.getParameter("timeCode"));
        timeSlot = timePicker(request.getParameter("timeCode"));
        bookQuantity = Integer.parseInt(request.getParameter("bookQuantity"));
        
        //check whether the customer fulfil the requirement for getting the discount
        if(MembershipServlet.fulfilRequirementForDiscount(request)) {
            discountMessage = "50% Discount";
            bookPrice = bookQuantity * 15.00 * 0.5;
        }
        else {
            discountMessage = "No Discount";
            bookPrice = bookQuantity * 15.00;
        }
        
        
        checkMessage = "Available table for " + bookQuantity + " person(s)" + " on " + bookDate + " at " + timePicker(request.getParameter("timeCode"));
        checkNoTableMessage = "Sorry no available table for " + bookQuantity + " person(s)" + " on " + bookDate + " at " + timePicker(request.getParameter("timeCode"));
        
        System.out.println(bookDate.toString() + timeCode + bookQuantity + bookPrice);
    }
    
    private ArrayList<BookingTable> getTablebookingList() {
        ArrayList<BookingTable> bookingTableList = new ArrayList<>();
        
        try {
            Connection con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_TABLE_LIST);
            ResultSet rs = st.executeQuery();
            
            while(rs.next()) {
                bookingTableList.add(new BookingTable(rs.getInt("bookingTable_id"), rs.getString("bookingTable_status"), rs.getInt("bookingTable_code"), rs.getInt("bookingTable_capacity")));
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(BookingTableServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bookingTableList;
    }
    
    private void forwardPage(HttpServletRequest request, HttpServletResponse response,String pagePath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagePath);
        dispatcher.forward(request, response);
    }
    
    private boolean isStringIsNullOrEmpty(String inputString) {
        return inputString == null || inputString.equals("");
    }
    
    private ArrayList<BookingTable> filterTableBasedOnPerson(ArrayList<BookingTable> btlist, int person){
        //filter table list for table size based on person book
        for(int j=0;j<btlist.size();j++) {
            if( btlist.get(j).getBookingTableCapacity() != person ) {
                btlist.remove(j);
                j--;
            }
        }
        return btlist;
    }
    
    private String timePicker(String timeCode) {
        int time = Integer.parseInt(timeCode);
        
        switch(time) {
            case 1:
                return "9.00 AM - 10.00 AM";
            case 2:
                return "10.00 AM - 11.00 AM";
            case 3:
                return "11.00 AM - 12.00 PM";
            case 4:
                return "12.00 PM - 1.00 PM";
            case 5:
                return "1.00 PM - 2.00 PM";
            case 6:
                return "2.00 PM - 3.00 PM";
            case 7:
                return "3.00 PM - 4.00 PM";
            case 8:
                return "4.00 PM - 5.00 PM";
            case 9:
                return "5.00 PM - 6.00 PM";
            case 10:
                return "6.00 PM - 7.00 PM";
            case 11:
                return "7.00 PM - 8.00 PM";
            case 12: 
                return "8.00 PM - 9.00 PM";
            case 13:
                return "9.00 PM - 10.00 PM";
            case 14:
                return "10.00 PM - 11.00 PM";
            default:
                
        } 
        return null;
    }

    private int personPicker(int person) {
        if(person <= 5)
            return 5;
        else if((person > 5) && (person <= 7))
            return 7;
        else if((person > 7) && (person <= 10))
            return 10;
        else if((person > 10) && (person <= 15))
            return 15;
        else
            return 0;
    }

}
