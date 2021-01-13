/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.controller;

import com.RERES.database.Database;
import com.RERES.database.SQLStatementList;
import com.RERES.model.Booking;
import com.RERES.model.OrderItem;
import com.RERES.model.Payment;
import com.RERES.model.User;
import com.RERES.path.Path;
import static com.RERES.path.Path.MAIN_VIEW_PATH;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
 * @author ainal farhan
 */
public class BookingServlet extends HttpServlet {

    private final String ACTION_VIEW_BOOKING_LIST = "viewBookingList";
    private final String ACTION_VIEW_THE_SELECTED_BOOKING = "viewTheSelectedBooking";
    
    final String[] PUBLIC_INFO_LABELS = {
        "No",
        "Date",
        "Start Time",
        "Duration",
        "Status",
        "Price",
        "Created",
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
            out.println("<h1>Servlet BookingServlet at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        
        if(isStringIsNullOrEmpty(action)) {
            
        }
        else if(action.equals(ACTION_VIEW_BOOKING_LIST)) {
            processViewBookingList(request, response);
        }
        else if(action.equals(ACTION_VIEW_THE_SELECTED_BOOKING)) {
            processViewTheSelectedBooking(request, response);
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
    
    private void processViewTheSelectedBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int selectedBookingID = Integer.parseInt(request.getParameter("bookingID"));
        selectedBooking = new Booking();
        
        if(!bookingList.isEmpty() && bookingList != null) {
            for(int i = 0; i < bookingList.size(); i++) {
                if(bookingList.get(i).getBookingID() == selectedBookingID) {
                    selectedBooking = bookingList.get(i);
                    break;
                }
            }
            
            if(selectedBooking != null) {
                if(getAndSetRequiredInfoFromDatabaseForSelectedBooking(request)) {
                    forwardPage(request, response, Path.MAIN_VIEW_PATH + "/manageBooking.jsp");
                }
            }
        }
    }
    
    private void processViewBookingList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if(getAllBookingInfoFromDatabase()) {
            request.setAttribute("bookingList", bookingList);
            request.setAttribute("labels", this.PUBLIC_INFO_LABELS);
            request.setAttribute("labelsLength", this.PUBLIC_INFO_LABELS.length);
            forwardPage(request, response, MAIN_VIEW_PATH + "/viewBookingListPage.jsp");
        }
    }
    
    private void forwardPage(HttpServletRequest request, HttpServletResponse response,String pagePath)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher(pagePath);
        dispatcher.forward(request, response);
    }
    
    private boolean getAndSetRequiredInfoFromDatabaseForSelectedBooking(HttpServletRequest request)
            throws ServletException, IOException {
        Connection con;
        
        try {
            con = new Database().getCon();
            PreparedStatement st = con.prepareStatement(SQLStatementList.SQL_STATEMENT_RETRIEVE_ALL_BOOKING_WITH_PAYMENT_ORDER_AND_CUSTOMER_NAME_INFORMATION_BY_BOOKING_ID);
            
            st.setInt(1, selectedBooking.getBookingID());
            st.setInt(2, selectedBooking.getBookingID());
            
            ResultSet result = st.executeQuery();

            ArrayList<OrderItem> orderItems = new ArrayList<>();
            
            boolean status = false;
            
            Payment payment = new Payment();
            Booking booking = new Booking();
            User user = new User();
            
            while(result.next()) {
                payment.setPaymentID(result.getInt("payment_id"));
                payment.setPaymentStatus(result.getString("payment_status"));
                payment.setPaymentMethod(result.getString("payment_method"));
                payment.setTotalPayment(result.getDouble("total_payment"));
                payment.setDatePaid(result.getDate("date_paid"));
                payment.setFkBookingID(result.getInt("fk_bookingID"));
                                
                booking.setBookingID(result.getInt("fk_bookingID"));
                booking.setBookingDescription(result.getString("booking_description"));
                booking.setBookingDate(result.getDate("booking_date"));
                booking.setBookingDuration(result.getInt("booking_duration"));
                booking.setBookingStartTime(result.getTime("booking_start_time"));
                booking.setBookingEndTime(result.getTime("booking_end_time"));
                booking.setBookingStatus(result.getString("booking_status"));
                booking.setBookingQuantity(result.getInt("booking_quantity"));
                booking.setBookingPrice(result.getDouble("booking_price"));
                booking.setBookingDateCreated(result.getTimestamp("booking_date_created"));
                booking.setFkUserID(result.getInt("fk_userID"));
                                                
                user.setName(result.getString("name"));
                
                result.getInt("order_item_id");
                status = result.wasNull();
                
                if(status) {
                    OrderItem orderItem = new OrderItem();
                
                    orderItem.setOrderItemID(result.getInt("order_item_id"));
                    orderItem.setItemQuantity(result.getInt("item_quantity"));
                    orderItem.setTotalPrice(result.getDouble("total_price"));
                    orderItem.setFkBookingID(result.getInt("fk_bookingID"));

                    orderItems.add(orderItem);
                }
            }
            
            request.setAttribute("selectedBookingPayment", payment);
            request.setAttribute("selectedBooking", booking);
            request.setAttribute("selectedBookingUser", user);
            request.setAttribute("selectedBookingOrderItems", orderItems);
            
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
                booking.setBookingDuration(result.getInt("booking_duration"));
                booking.setBookingStartTime(result.getTime("booking_start_time"));
                booking.setBookingEndTime(result.getTime("booking_end_time"));
                booking.setBookingStatus(result.getString("booking_status"));
                booking.setBookingQuantity(result.getInt("booking_quantity"));
                booking.setBookingPrice(result.getDouble("booking_price"));
                booking.setBookingDateCreated(result.getTimestamp("booking_date_created"));
                booking.setFkUserID(result.getInt("fk_userID"));
                
                bookingList.add(booking);
            }
            return true;
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
}
