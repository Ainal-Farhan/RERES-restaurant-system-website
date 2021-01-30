/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.database.SQLStatementList;
import com.RERES.model.Booking;
import com.RERES.model.BookingTable;
import com.RERES.model.Food;
import com.RERES.model.OrderItem;
import com.RERES.model.Payment;
import com.RERES.model.Refund;
import com.RERES.model.User;
import com.RERES.path.Path;
import static com.RERES.path.Path.MAIN_VIEW_PATH;
import static com.RERES.references.TopNavigationBarReference.HOME_PAGE;
import static com.RERES.references.TopNavigationBarReference.SELECTED_PAGE;
import com.RERES.view.View;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ainal farhan
 */
public class BookingServlet extends HttpServlet {

    private final String ACTION_VIEW_BOOKING_LIST = "viewBookingList";
    private final String ACTION_VIEW_BOOKING_LIST_FOR_CUSTOMER = "viewBookingListForCustomer";
    private final String ACTION_VIEW_THE_SELECTED_BOOKING = "viewTheSelectedBooking";
    private final String ACTION_CANCEL_SELECTED_BOOKING = "cancelSelectedBooking";
    private final String ACTION_REFUND_SELECTED_BOOKING = "refundSelectedBooking";
    private final String ACTION_ABSENT_SELECTED_BOOKING = "absentSelectedBooking";
    private final String ACTION_PRESENT_SELECTED_BOOKING = "presentSelectedBooking";
    private final String ACTION_VIEW_BOOKING_DETAILS = "viewBookingDetails";
    private final String ACTION_VIEW_ORDER_DETAILS = "viewOrderDetails";
    private final String ACTION_VIEW_AMOUNT_SUMMARY = "viewAmountSummary";
    private final String ACTION_VIEW_PAYMENT_HISTORY = "viewPaymentHistory";
    private final String ACTION_VIEW_REFUND_DETAILS = "viewRefundDetails";
    
    final String[] PUBLIC_INFO_LABELS = {
        "No",
        "Booking ID",
        "Date",
        "Time Slot",
        "Status",
        "Price",
        "Created",
        "View"
    };
    
    private static ArrayList<Booking> bookingList;
    private static Booking selectedBooking;
    
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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet BookingServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BookingServlet by GET method</h1>");
            out.println("</body>");
            out.println("</html>");
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
        else if(action.equals(ACTION_VIEW_BOOKING_LIST)) {
            request.setAttribute("selectedPage", "bookingListPage");
            processViewBookingList(request, response);
        }
        else if(action.equals(ACTION_VIEW_THE_SELECTED_BOOKING)) {
            request.setAttribute("selectedPage", "bookingListPage");
            request.setAttribute("selectedManageBookingPage", "bookingDetailsPage");
            processViewTheSelectedBooking(request, response, "bookingDetails.jsp");
        }
        else if(action.equals(ACTION_VIEW_BOOKING_DETAILS)) {
            request.setAttribute("selectedManageBookingPage", "bookingDetailsPage");
            request.setAttribute("selectedPage", "bookingListPage");
            processViewTheSelectedBooking(request, response, "bookingDetails.jsp");
        }
        else if(action.equals(ACTION_VIEW_ORDER_DETAILS)) {
            request.setAttribute("selectedManageBookingPage", "orderDetailsPage");
            request.setAttribute("selectedPage", "bookingListPage");
            processViewTheSelectedBooking(request, response, "orderDetails.jsp");
        }
        else if(action.equals(ACTION_VIEW_AMOUNT_SUMMARY)) {
            request.setAttribute("selectedManageBookingPage", "amountSummaryPage");
            request.setAttribute("selectedPage", "bookingListPage");
            processViewTheSelectedBooking(request, response, "amountSummary.jsp");
        }
        else if(action.equals(ACTION_VIEW_REFUND_DETAILS)) {
            request.setAttribute("selectedManageBookingPage", "refundDetailsPage");
            request.setAttribute("selectedPage", "bookingListPage");
            processViewTheSelectedBooking(request, response, "refundDetails.jsp");
        }
        else if(action.equals(ACTION_VIEW_PAYMENT_HISTORY)) {
            request.setAttribute("selectedManageBookingPage", "paymentHistoryPage");
            request.setAttribute("selectedPage", "bookingListPage");
            processViewTheSelectedBooking(request, response, "paymentHistory.jsp");
        }
        else if(action.equals(ACTION_VIEW_BOOKING_LIST_FOR_CUSTOMER)) {
            request.setAttribute("selectedPage", "bookingListPage");
            processViewBookingListForCustomer(request, response);
        }
        else if(action.equals(ACTION_CANCEL_SELECTED_BOOKING)) {
            request.setAttribute("selectedPage", "bookingListPage");
            processChangeBookingStatus(request, response, "cancelled");
        }
        else if(action.equals(ACTION_REFUND_SELECTED_BOOKING)) {
            request.setAttribute("selectedPage", "bookingListPage");            
            processChangeBookingStatus(request, response, "refunded");
        }
        else if(action.equals(ACTION_ABSENT_SELECTED_BOOKING)) {
            request.setAttribute("selectedPage", "bookingListPage");
            processChangeBookingStatus(request, response, "absent");
        }
        else if(action.equals(ACTION_PRESENT_SELECTED_BOOKING)) {
            request.setAttribute("selectedPage", "bookingListPage");
            processChangeBookingStatus(request, response, "present");
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
    
    private boolean isStringIsNullOrEmpty(String inputString) {
        return inputString == null || inputString.equals("");
    }
    
    private void processChangeBookingStatus(HttpServletRequest request, HttpServletResponse response, String status)
            throws ServletException, IOException {
        int bookingID = Integer.parseInt(request.getParameter("bookingID"));
        
        String[] nameLabels = {"bookingID"};
        String[] valueLabels = {Integer.toString(bookingID)};
        String message = "";
        
        if(status.equalsIgnoreCase("present")) {
            updateSuccessBookingMadeInMembershipTable();
        }
        
        if(status.equalsIgnoreCase("refunded")) {
            if(addRefundInfoIntoDatabase(request, response)) {
                if(changeTheSelectedBookingStatus(status, bookingID)) {
                    message = "Successfully refund the booking.";    
                }
                else {
                    message = "Failed change booking status to " + status.toUpperCase();
                }
            } else {
                message = "Failed to refund the booking.";
            }
        }
        else if(changeTheSelectedBookingStatus(status, bookingID)) {
            message = "Successfully change booking status to " + status.toUpperCase();    
        }
        else {
            message = "Failed change booking status to " + status.toUpperCase();
        }
        
        View.setOverlayStatusMessage(request, response, ACTION_VIEW_THE_SELECTED_BOOKING, message, "BookingServlet", nameLabels, valueLabels);
        setAttributesForSelectedBooking(request, response);
        if(selectedBooking != null && getAndSetRequiredInfoFromDatabaseForSelectedBooking(request)) {
            View.includePage(request, response, Path.MAIN_VIEW_PATH + "/manageBooking/bookingDetails.jsp");
        }
        
    }
    
    private void setAttributesForSelectedBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int selectedBookingID = Integer.parseInt(request.getParameter("bookingID"));
        
        if(selectedBooking == null || selectedBooking.getBookingID() != selectedBookingID) {
            
            selectedBooking = new Booking();
            selectedBooking.setBookingID(selectedBookingID);
            
            if(bookingList != null && !bookingList.isEmpty()) {
                for(int i = 0; i < bookingList.size(); i++) {
                    if(bookingList.get(i).getBookingID() == selectedBookingID) {
                        selectedBooking = bookingList.get(i);
                        break;
                    }
                }
            }
        } 
    }
    
    private void processViewTheSelectedBooking(HttpServletRequest request, HttpServletResponse response, String fileName)
            throws ServletException, IOException {
        
        setAttributesForSelectedBooking(request, response);
        
        if(selectedBooking != null && getAndSetRequiredInfoFromDatabaseForSelectedBooking(request)) {
            View.forwardPage(request, response, Path.MAIN_VIEW_PATH + "/manageBooking/" + fileName);
        }
    }
    
    private void processViewBookingList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if(getAllBookingInfoFromDatabase()) {
            request.setAttribute("bookingList", bookingList);
            request.setAttribute("labels", this.PUBLIC_INFO_LABELS);
            request.setAttribute("labelsLength", this.PUBLIC_INFO_LABELS.length);
            View.forwardPage(request, response, MAIN_VIEW_PATH + "/viewBookingListPage.jsp");
        }
    }
    
    private void processViewBookingListForCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        String search;
        
        if(getAllBookingInfoFromDatabaseForCustomer((Integer)session.getAttribute("currentUserID"))) {
            request.setAttribute("bookingList", bookingList);
            request.setAttribute("labels", this.PUBLIC_INFO_LABELS);
            request.setAttribute("labelsLength", this.PUBLIC_INFO_LABELS.length);
            View.forwardPage(request, response, MAIN_VIEW_PATH + "/viewBookingListPage.jsp");
        }
    }
    
    /**
     * totalRefund - the total refund for the customer
     * description - the description for the refund
     * status - status of the refund 
     **** - PARTIAL REFUND - the customer failed to attend for the booking that had been made 
     **** - TOTAL REFUND - the customer get the full refund
    */
    private boolean addRefundInfoIntoDatabase(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        
        Connection con;
        
        try {
            double totalRefund = Double.parseDouble(request.getParameter("totalRefund"));
            String description = request.getParameter("refundDescription");
            String status = request.getParameter("refundStatus");
            int bookingID = Integer.parseInt(request.getParameter("bookingID"));

            con = new Database().getCon();
            
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_INSERT_REFUND_INFO);
            
            st.setDouble(1, totalRefund);
            st.setString(2, description);
            st.setString(3, status);
            st.setInt(4, bookingID);
            
            int result = st.executeUpdate();
            
            return result > 0;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
    private void updateSuccessBookingMadeInMembershipTable() {
        Connection con;
        
        try {
            con = new Database().getCon();
            
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_MEMBERSHIP_SUCCESS_ORDER_MADE);
            
            st.setInt(1, selectedBooking.getFkUserID());
            
            st.executeUpdate();
            
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    private boolean changeTheSelectedBookingStatus(String status, int bookingID)
        throws ServletException, IOException {
        Connection con;
        
        try {
            con = new Database().getCon();
            
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_UPDATE_THE_BOOKING_STATUS);
            
            st.setString(1, status);
            st.setInt(2, bookingID);
            
            int result = st.executeUpdate();
            
            if(result > 0) {
                if(!bookingList.isEmpty() && bookingList != null) {
                    for(int i = 0; i < bookingList.size(); i++) {
                        if(bookingList.get(i).getBookingID() == bookingID) {
                            selectedBooking = bookingList.get(i);
                            selectedBooking.setBookingStatus(status);
                            bookingList.set(i, selectedBooking);
                            break;
                        }
                    }
                }
                return true;
            }
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return false;
    }
    
    private boolean getAndSetRequiredInfoFromDatabaseForSelectedBooking(HttpServletRequest request)
            throws ServletException, IOException {
        Connection con;
        
        try {
            con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_ALL_BOOKING_WITH_PAYMENT_ORDER_TABLE_AND_CUSTOMER_NAME_INFORMATION_BY_BOOKING_ID);
            
            st.setInt(1, selectedBooking.getBookingID());
            st.setInt(2, selectedBooking.getBookingID());
            st.setInt(3, selectedBooking.getBookingID());
            st.setInt(4, selectedBooking.getBookingID());
            
            ResultSet result = st.executeQuery();

            ArrayList<OrderItem> orderItems = new ArrayList<>();
            ArrayList<Food> foods = new ArrayList<>();
            
            Payment payment = new Payment();
            Booking booking = new Booking();
            BookingTable bookingTable = new BookingTable();
            User user = new User();
            Refund refund = new Refund();
            
            int count = 1;
            
            while(result.next()) {
                
                if(count == 1) {
                    int stat = result.getInt("payment_id");
                
                    if(stat != 0) {
                        payment.setPaymentID(result.getInt("payment_id"));
                        payment.setPaymentStatus(result.getString("payment_status"));
                        payment.setPaymentMethod(result.getString("payment_method"));
                        payment.setTotalPayment(result.getDouble("total_payment"));
                        payment.setDatePaid(result.getDate("date_paid"));
                        payment.setFkBookingID(result.getInt("fk_bookingID"));
                    }

                    booking.setBookingID(result.getInt("booking_id"));
                    booking.setBookingDescription(result.getString("booking_description"));
                    booking.setBookingDate(result.getDate("booking_date"));
                    booking.setTimeCode(result.getInt("time_code"));
                    booking.setTimeSlot(result.getString("time_slot"));
                    booking.setBookingStatus(result.getString("booking_status"));
                    booking.setBookingQuantity(result.getInt("booking_quantity"));
                    booking.setBookingPrice(result.getDouble("booking_price"));
                    booking.setBookingDateCreated(result.getTimestamp("booking_date_created"));
                    booking.setFkUserID(result.getInt("fk_userID"));
                    booking.setFkBookingTableID(result.getInt("fk_bookingTableID"));

                    user.setName(result.getString("name"));
                    
                    bookingTable.setBookingTableID(result.getInt("bookingTable_id"));
                    bookingTable.setBookingTableStatus(result.getString("bookingTable_status"));
                    bookingTable.setBookingTableCode(result.getInt("bookingTable_code"));
                    bookingTable.setBookingTableCapacity(result.getInt("bookingTable_capacity"));
                    
                    result.getInt("refund_id");
                    
                    if(!result.wasNull()) {
                        refund.setRefundID(result.getInt("refund_id"));
                        refund.setRefundStatus(result.getString("refund_status"));
                        refund.setRefundDescription(result.getString("refund_description"));
                        refund.setRefundPrice(result.getDouble("refund_price"));
                        refund.setRefundDate(result.getDate("refund_date"));
                        refund.setFkBookingID(result.getInt("fk_bookingID"));
                    }
                    
                    count++;
                }
                
                int stat2 = result.getInt("order_item_id");
                
                if(stat2 != 0) {
                    OrderItem orderItem = new OrderItem();
                
                    orderItem.setOrderItemID(result.getInt("order_item_id"));
                    orderItem.setItemQuantity(result.getInt("item_quantity"));
                    orderItem.setTotalPrice(result.getDouble("total_price"));
                    orderItem.setFkBookingID(result.getInt("fk_bookingID"));

                    orderItems.add(orderItem);
                    
                    Food food = new Food();
                    food.setFoodID(result.getInt("food_id"));
                    food.setFoodName(result.getString("food_name"));
                    food.setFoodDescription(result.getString("food_description"));
                    food.setFoodPrice(result.getDouble("food_price"));
                    food.setFoodPhoto(result.getString("food_photo"));
                    
                    foods.add(food);
                }
            }
            
            if(refund.getRefundID() > 0) {
                request.setAttribute("selectedBookingRefund", refund);
            }
            
            request.setAttribute("selectedBookingPayment", payment);
            request.setAttribute("selectedBooking", booking);
            request.setAttribute("selectedBookingUser", user);
            request.setAttribute("selectedBookingTable", bookingTable);
            request.setAttribute("selectedBookingOrderItems", orderItems);
            request.setAttribute("selectedBookingFoods", foods);
            
            return true;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    private boolean getAllBookingInfoFromDatabaseForCustomer(int userID) {
        Connection con;
        bookingList = new ArrayList<>(); 
        
        try {
            con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_ALL_BOOKING_INFORMATION_FOR_A_CUSTOMER);
            
            st.setInt(1, userID);
            
            ResultSet result = st.executeQuery();

            while(result.next()) {
                Booking booking = new Booking();
                
                booking.setBookingID(result.getInt("booking_id"));
                booking.setBookingDescription(result.getString("booking_description"));
                booking.setBookingDate(result.getDate("booking_date"));
                booking.setTimeCode(result.getInt("time_code"));
                booking.setTimeSlot(result.getString("time_slot"));
                booking.setBookingStatus(result.getString("booking_status"));
                booking.setBookingQuantity(result.getInt("booking_quantity"));
                booking.setBookingPrice(result.getDouble("booking_price"));
                booking.setBookingDateCreated(result.getTimestamp("booking_date_created"));
                booking.setFkUserID(result.getInt("fk_userID"));
                booking.setFkBookingTableID(result.getInt("fk_bookingTableID"));
                
                bookingList.add(booking);
            }
            return true;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
     
    private boolean getAllBookingInfoFromDatabase() {
        Connection con;
        bookingList = new ArrayList<>(); 
        
        try {
            con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_ALL_BOOKING_INFORMATION);
            
            ResultSet result = st.executeQuery();

            while(result.next()) {
                Booking booking = new Booking();
                
                booking.setBookingID(result.getInt("booking_id"));
                booking.setBookingDescription(result.getString("booking_description"));
                booking.setBookingDate(result.getDate("booking_date"));
                booking.setTimeCode(result.getInt("time_code"));
                booking.setTimeSlot(result.getString("time_slot"));
                booking.setBookingStatus(result.getString("booking_status"));
                booking.setBookingQuantity(result.getInt("booking_quantity"));
                booking.setBookingPrice(result.getDouble("booking_price"));
                booking.setBookingDateCreated(result.getTimestamp("booking_date_created"));
                booking.setFkUserID(result.getInt("fk_userID"));
                booking.setFkBookingTableID(result.getInt("fk_bookingTableID"));
                
                bookingList.add(booking);
            }
            return true;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
