<%-- 
    Document   : amountSummary
    Created on : Jan 27, 2021, 7:47:36 AM
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
        <title>Amount Summary</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../../css/style/global.css"%></style>
        <style><%@include file="../../../../css/style/manageBooking.css"%></style>
    </head>
    <body>
        <%  com.RERES.utility.SessionValidator.checkSession(request, response); %>
        
        <header>
            <%@include file = "../../components/navigationBar.jsp" %>
        </header>
        
        <jsp:useBean id="selectedBooking" class="com.RERES.model.Booking" scope="request" />
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
                                        <th colspan="<%= 2 + orderItems.size() %>"><h1>Amount Summary</h1></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Booking</th>
                                        <td><label class="form-control-plaintext" id="Price"><%= String.format("RM%.2f %s", selectedBooking.getBookingPrice(), request.getAttribute("selectedBookingRefund") != null ? "(REFUNDED)" : "" ) %></label></td>
                                    </tr>
                                    <%  if(orderItems.size() > 0) { %>
                                    <tr>
                                        <th>Order</th>
                                        <td><label class="form-control-plaintext" id="Price"><%= String.format("RM%.2f %s", totalPriceForOrders,  request.getAttribute("selectedBookingRefund") != null ? "(NO REFUND)" : "") %></td>
                                    </tr>
                                    <%  } %>
                                    <tr>
                                        <th>Grand Total</th>
                                        <td><label class="form-control-plaintext" id="Price"><%= String.format("RM%.2f", totalPriceForOrders + selectedBooking.getBookingPrice()) %></label></td>
                                    </tr>
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
