<%-- 
    Document   : bookingDetails
    Created on : Jan 27, 2021, 7:47:08 AM
    Author     : ainal farhan
--%>
<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.RERES.model.Food"%>
<%@page import="com.RERES.model.OrderItem"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Details</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../../css/style/global.css"%></style>
        <style><%@include file="../../../../css/style/manageBooking.css"%></style>
    </head>
    <body>
        <%  com.RERES.utility.SessionValidator.checkSession(request, response); %>
        
        <header>
            <%@include file = "../../components/navigationBar.jsp" %>
        </header>
        
        <jsp:useBean id="selectedBookingPayment" class="com.RERES.model.Payment" scope="request" />
        <jsp:useBean id="selectedBooking" class="com.RERES.model.Booking" scope="request" />
        <jsp:useBean id="selectedBookingTable" class="com.RERES.model.BookingTable" scope="request" />
        
        <div class="row">
            <div class="col-1">
                <jsp:include page="../../components/manageBookingSideNavigationBar.jsp" />
            </div>
            <div class="col">
                <div class="content-container" style="padding-bottom: 0;width:100%; height:500px; overflow:auto;">
                    <div class="manage-booking-container">                        
                        <div class="table-responsive">
                            <table class="table table-light table-striped">
                                <thead class="thead-dark">
                                    <tr>
                                        <th colspan="4"><h1>Booking Details</h1></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Customer Name</th>
                                        <td colspan="2"><jsp:getProperty name="selectedBookingUser" property="name"/></td>
                                        <td>
                                            <form action="UserServlet" method="POST">
                                                <input type="hidden" name="action" value="viewProfile">
                                                <input type="hidden" name="userType" value="customer">
                                                <input type="hidden" name="userID" value="<jsp:getProperty name="selectedBooking" property="fkUserID"/>">
                                                <input type="submit" class="btn btn-primary form-control" value="View" style="width:100px;padding:0 0 0 0;display: block;margin-right: auto;margin-left: auto;">
                                            </form>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Description</th>
                                        <td><jsp:getProperty name="selectedBooking" property="bookingDescription"/></td>
                                        <th>Number of People</th>
                                        <td><jsp:getProperty name="selectedBooking" property="bookingQuantity"/></td>
                                    </tr>
                                    <tr>
                                        <th>Booking ID</th>
                                        <td><jsp:getProperty name="selectedBooking" property="bookingID"/></td>
                                        <th>Booking Created</th>
                                        <td><%= selectedBooking.getBookingDateCreated().toString().substring(0, 16) + "H" %></td>
                                    </tr>
                                    <tr>
                                        <th>Date</th>
                                        <td><jsp:getProperty name="selectedBooking" property="bookingDate"/></td>
                                        <th>Time Slot</th>
                                        <td><%= selectedBooking.getTimeSlot() %></td>
                                    </tr>
                                    <tr>
                                        <th>Table Number</th>
                                        <td><jsp:getProperty name="selectedBookingTable" property="bookingTableCode"/></td>
                                        <th>Table Capacity</th>
                                        <td><jsp:getProperty name="selectedBookingTable" property="bookingTableCapacity"/></td>
                                    </tr>
                                    <tr>
                                        <th>Payment Status</th>
                                        <td style="color:<%= selectedBookingPayment.getPaymentStatus().toUpperCase().equals("DONE")? "green" : "red" %>;font-weight:bolder;"><%= selectedBookingPayment.getPaymentStatus().toUpperCase() %></td>
                                        <th>Booking Status</th>
                                        <td style="color:<%= selectedBooking.getBookingStatus().toUpperCase().equals("SUCCESS") || selectedBooking.getBookingStatus().toUpperCase().equals("PRESENT")? "green" : "red" %>;font-weight:bolder;"><%= selectedBooking.getBookingStatus().toUpperCase() %></td>
                                    </tr>
                                    <%  if(selectedBookingPayment.getPaymentStatus().equalsIgnoreCase("done")) { %>
                                    <tr>
                                        <%
                                            // calculate difference
                                            long days = Period.between(LocalDate.now(), LocalDate.parse(selectedBooking.getBookingDate().toString())).getDays();
                                        %>

                                        <%  if(selectedBooking.getBookingStatus().equalsIgnoreCase("success")) { %>
                                            <%  if(days == 0) { %>
                                            <th>Action</th>
                                            <td style="text-align:right">
                                                <form action="BookingServlet" method="POST">
                                                    <input type="hidden" name="action" value="absentSelectedBooking">
                                                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                                                    <input type="submit" class="btn-custom" value="Absent">
                                                </form>
                                            </td>
                                            <td>
                                                <form action="BookingServlet" method="POST">
                                                    <input type="hidden" name="action" value="presentSelectedBooking">
                                                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                                                    <input type="submit" class="btn-custom" value="Present">
                                                </form>
                                            </td>
                                            <td>Today is the booked date</td>
                                            <%  } else if(days > 1) {%>
                                            <th>Action</th>
                                            <td>
                                                <form action="BookingServlet" method="POST">
                                                    <input type="hidden" name="action" value="cancelSelectedBooking">
                                                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                                                    <input type="submit" class="btn-custom" value="Cancel Booking">
                                                </form>
                                            </td>
                                            <td colspan="2">You May Cancel Booking at least 2 days before the booking date</td>
                                            <%  } else { %>
                                            <th>Message</th>
                                            <td colspan="3">Cannot cancel booking because you can only cancel it at least 2 days before the booking date</td>
                                            <%  } %>
                                        <%  } else if(selectedBooking.getBookingStatus().equalsIgnoreCase("cancelled")) { %>
                                            <th>Action</th>
                                            <td>
                                                <form action="BookingServlet" method="POST">
                                                    <input type="hidden" name="action" value="refundSelectedBooking">
                                                    <input type="hidden" name="totalRefund" value="<%= selectedBooking.getBookingPrice() %>">
                                                    <input type="hidden" name="refundDescription" value="Successfully make a full refund for the booking">
                                                    <input type="hidden" name="refundStatus" value="TOTAL REFUND">
                                                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                                                    <input type="submit" class="btn-custom" value="Refund Booking">
                                                </form>
                                            </td>
                                            <td colspan="2">You May Refund Booking a the latest 3 days after the booking date</td>
                                        <%  } else if(selectedBooking.getBookingStatus().equalsIgnoreCase("refunded")) { %>
                                            <th>Message</th>
                                            <td colspan="3">Already Refunded</td>
                                        <%  } else if(selectedBooking.getBookingStatus().equalsIgnoreCase("absent")) { %>
                                            <%  if(days >= -3 && days <= 0) {%>
                                            <th>Action</th>
                                            <td>
                                                <form action="BookingServlet" method="POST">
                                                    <input type="hidden" name="action" value="refundSelectedBooking">
                                                    <input type="hidden" name="totalRefund" value="<%= selectedBooking.getBookingPrice() * 0.8 %>">
                                                    <input type="hidden" name="refundDescription" value="Successfully make a partial refund for the booking">
                                                    <input type="hidden" name="refundStatus" value="PARTIAL REFUND">
                                                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                                                    <input type="submit" class="btn-custom" value="Refund Booking (80%)">
                                                </form>
                                            </td>
                                            <td colspan="2">You May Refund Booking (RM<%= String.format("%.2f", selectedBooking.getBookingPrice() * 0.8) %>) within 3 days after the booking date</td>
                                            <%  } else { %>
                                            <th>Message</th>
                                            <td colspan="3"><%= days * -1 %> days have been passed. Refund Booking can only be done within three days after the booked date</td>
                                            <%  } %>
                                        <%  } else if(selectedBooking.getBookingStatus().equalsIgnoreCase("present")) { %>
                                            <th>Message</th>
                                            <td colspan="3">Thank you for coming</td>
                                        <%  } %>
                                    </tr>
                                    <%  } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <footer>
                    <%@include file = "../../components/footer.jsp" %>
                </footer>
            </div>
        </div>
    </body>
</html>
