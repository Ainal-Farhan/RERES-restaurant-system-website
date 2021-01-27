<%-- 
    Document   : refundDetails
    Created on : Jan 27, 2021, 11:59:11 AM
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
        <title>Refund Details</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../../css/style/global.css"%></style>
        <style><%@include file="../../../../css/style/manageBooking.css"%></style>
    </head>
    <body>
        <%  com.RERES.utility.SessionValidator.checkSession(request, response); %>
        
        <header>
            <%@include file = "../../components/navigationBar.jsp" %>
        </header>
        
        <jsp:useBean id="selectedBookingRefund" class="com.RERES.model.Refund" scope="request" />
        
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
                                        <th colspan="5"><h1>Refund Details</h1></th>
                                    </tr>
                                    <tr>
                                        <th>Refund Status</th>
                                        <th>Refund Description</th>
                                        <th>Refund Amount</th>
                                        <th>Date Refund</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= selectedBookingRefund.getRefundStatus().toUpperCase() %></td>
                                        <td><%= selectedBookingRefund.getRefundDescription() %></td>
                                        <td><%= String.format("RM%.2f", selectedBookingRefund.getRefundPrice()) %></td>
                                        <td><%= selectedBookingRefund.getRefundDate() %></td>
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
