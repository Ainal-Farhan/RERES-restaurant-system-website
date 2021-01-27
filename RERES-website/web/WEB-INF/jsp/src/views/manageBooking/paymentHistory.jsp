<%-- 
    Document   : paymentHistory
    Created on : Jan 27, 2021, 7:47:54 AM
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
        <title>Payment History</title>
        
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
        <jsp:useBean id="selectedBookingUser" class="com.RERES.model.User" scope="request" />
        <%  
            ArrayList<OrderItem> orderItems = (ArrayList<OrderItem>)request.getAttribute("selectedBookingOrderItems");

            double totalPriceForOrders = .0;
            for(int i = 0; i < orderItems.size(); i++) {
                totalPriceForOrders += orderItems.get(i).getTotalPrice();
            }
        %>
        
        <div class="row">
            <div class="col-1">
                <jsp:include page="../../components/manageBookingSideNavigationBar.jsp" />
            </div>
            <div class="col">
                <div class="content-container">
                    <div class="manage-booking-container">
                        <div class="table-responsive">
                            <table class="table table-light table-striped">
                                <thead class="thead-dark">
                                    <tr>
                                        <th colspan="5"><h1>Payment History</h1></th>
                                    </tr>
                                    <tr>
                                        <th>Payment Status</th>
                                        <th>Payment Method</th>
                                        <th>Paid Amount</th>
                                        <th>Date Paid</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= selectedBookingPayment.getPaymentStatus().toUpperCase() %></td>
                                        <td><%= selectedBookingPayment.getPaymentStatus().toUpperCase().equals("DONE")? selectedBookingPayment.getPaymentMethod().toUpperCase() : "-" %></td>
                                        <td><%= selectedBookingPayment.getPaymentStatus().toUpperCase().equals("DONE")? String.format("RM%.2f", selectedBookingPayment.getTotalPayment()) : "RM0.00" %></td>
                                        <td><%= selectedBookingPayment.getPaymentStatus().toUpperCase().equals("DONE")? selectedBookingPayment.getDatePaid() : "-" %></td>
                                    </tr>
                                    <%  if(!selectedBookingPayment.getPaymentStatus().toUpperCase().equals("DONE")) { %>
                                    <tr>
                                        <th colspan="4" style="text-align: center">
                                            <form action="PaymentServlet" method="POST">
                                                <input type="hidden" name="action" value="viewPaymentForm">
                                                <input type="hidden" name="payAmount" value="<%= totalPriceForOrders + selectedBooking.getBookingPrice() %>">
                                                <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                                                <input type="hidden" name="payName" value="<%= selectedBookingUser.getName() %>">
                                                <input type="submit" class="btn btn-success" value="Pay <%= String.format("RM%.2f", totalPriceForOrders + selectedBooking.getBookingPrice()) %> Now?">
                                            </form>
                                        </th> 
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
