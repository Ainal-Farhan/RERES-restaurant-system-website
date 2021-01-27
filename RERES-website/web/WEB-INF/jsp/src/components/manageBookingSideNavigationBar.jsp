<%-- 
    Document   : manageBookingSideNavigationBar
    Created on : Jan 27, 2021, 7:32:35 AM
    Author     : ainal farhan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Montserrat">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        
        <style>
            nav {
                top: 0;
                z-index: 2;
            }
            .selected {
                opacity: 0.5;
                background-color: black;
                color: white;
            }
        </style>
    </head>
        
    <body>
        <%
            String activeBookingDetails = "w3-hover-black";
            String activeOrderDetails = "w3-hover-black";
            String activeAmountSummary = "w3-hover-black";
            String activeRefundDetails = "w3-hover-black";
            String activePaymentHistory = "w3-hover-black";
            
            if(request.getAttribute("selectedManageBookingPage") != null) {
                String selectedManageBookingPage = (String)request.getAttribute("selectedManageBookingPage");
                
                if(selectedManageBookingPage.equals("bookingDetailsPage")) {
                    activeBookingDetails = "selected";
                } else if(selectedManageBookingPage.equals("orderDetailsPage")) {
                    activeOrderDetails = "selected";
                } else if(selectedManageBookingPage.equals("amountSummaryPage")) {
                    activeAmountSummary = "selected";
                } else if(selectedManageBookingPage.equals("refundDetailsPage")) {
                    activeRefundDetails = "selected";
                } else if(selectedManageBookingPage.equals("paymentHistoryPage")) {
                    activePaymentHistory = "selected";
                }
            }
        %>
        
        <jsp:useBean id="selectedBooking" class="com.RERES.model.Booking" scope="request" />
        
        <!-- Icon Bar (Sidebar - hidden on small screens) -->
        <nav class="w3-sidebar w3-white w3-bar-block w3-small w3-hide-small w3-center">
            <p class="w3-bar-item" style="margin-top:20px;margin-bottom:20px;font-weight:bold;"><i class="far fa-address-book"></i> MANAGE BOOKING</p>
            
            <form action="BookingServlet" method="POST" name="booking-details">
                <div class="w3-bar-item w3-button w3-padding-large <%= activeBookingDetails %>" onClick="document.forms['booking-details'].submit();">
                    <input type="hidden" name="action" value="viewBookingDetails">
                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                    <i class="fas fa-book w3-xlarge"></i>
                    <p>BOOKING DETAILS</p>
                </div>
            </form>
            <form action="BookingServlet" method="POST" name="order-details">
                <div class="w3-bar-item w3-button w3-padding-large <%= activeOrderDetails %>" onClick="document.forms['order-details'].submit();">
                    <input type="hidden" name="action" value="viewOrderDetails">
                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                    <i class="fas fa-utensils w3-xlarge"></i>
                    <p>ORDER DETAILS</p>
                </div>
            </form>
            <form action="BookingServlet" method="POST" name="amount-summary">
                <div class="w3-bar-item w3-button w3-padding-large <%= activeAmountSummary %>" onClick="document.forms['amount-summary'].submit();">
                    <input type="hidden" name="action" value="viewAmountSummary">
                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                    <i class="fas fa-money-bill-alt w3-xlarge"></i>
                    <p>AMOUNT SUMMARY</p>
                </div>
            </form>
            <%  if(request.getAttribute("selectedBookingRefund") != null) { %>
            <form action="BookingServlet" method="POST" name="refund-details">
                <div class="w3-bar-item w3-button w3-padding-large <%= activeRefundDetails %>" onClick="document.forms['refund-details'].submit();">
                    <input type="hidden" name="action" value="viewRefundDetails">
                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                    <i class="fas fa-receipt w3-xlarge"></i>
                    <p>REFUND DETAILS</p>
                </div>
            </form>
            <%  } %>
            <form action="BookingServlet" method="POST" name="payment-history">
                <div class="w3-bar-item w3-button w3-padding-large <%= activePaymentHistory %>" onClick="document.forms['payment-history'].submit();">
                    <input type="hidden" name="action" value="viewPaymentHistory">
                    <input type="hidden" name="bookingID" value="<%= selectedBooking.getBookingID() %>">
                    <i class="fas fa-credit-card w3-xlarge"></i>
                    <p>PAYMENT HISTORY</p>
                </div>
            </form>
        </nav>
    </body>
</html>
