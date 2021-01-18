<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.RERES.model.Food"%>
<%@page import="com.RERES.model.OrderItem"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Booking Page</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/manageBooking.css"%></style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
            <jsp:useBean id="selectedBookingPayment" class="com.RERES.model.Payment" scope="request" />
            <jsp:useBean id="selectedBooking" class="com.RERES.model.Booking" scope="request" />
            <jsp:useBean id="selectedBookingUser" class="com.RERES.model.User" scope="request" />
            <%  
                ArrayList<OrderItem> orderItems = (ArrayList<OrderItem>)request.getAttribute("selectedBookingOrderItems");
                ArrayList<Food> foods = (ArrayList<Food>)request.getAttribute("selectedBookingFoods");
                
                double totalPriceForOrders = .0;
                for(int i = 0; i < orderItems.size(); i++) {
                    totalPriceForOrders += orderItems.get(i).getTotalPrice();
                }
            %>
        
        <div class="content-container">
            <div style="padding-bottom: 150px;padding-left: 5%;padding-right: 5%;">
                <div class="table-responsive manage-booking-container">
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
                                <th>Duration</th>
                                <td><%= selectedBooking.getBookingDuration() + " H" %></td>
                            </tr>
                            <tr>
                                <th>Start Time</th>
                                <td><%= selectedBooking.getBookingStartTime().toString().substring(0, 5) + "H" %></td>
                                <th>End Time</th>
                                <td><%= selectedBooking.getBookingEndTime().toString().substring(0, 5) + "H" %></td>
                            </tr>
                            <tr>
                                <th>Payment Status</th>
                                <td style="color:<%= selectedBookingPayment.getPaymentStatus().toUpperCase().equals("DONE")? "green" : "red" %>;font-weight:bolder;"><%= selectedBookingPayment.getPaymentStatus().toUpperCase() %></td>
                                <th>Booking Status</th>
                                <td style="color:<%= selectedBooking.getBookingStatus().toUpperCase().equals("SUCCESS")? "green" : "red" %>;font-weight:bolder;"><%= selectedBooking.getBookingStatus().toUpperCase() %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                            
                
                <div class="table-responsive manage-booking-container">
                    <table class="table table-light table-striped">
                        <thead class="thead-dark">
                            <tr>
                                <th colspan="5"><h1>Orders Details</h1></th>
                            </tr>
                            <tr>
                                <th>Name</th>
                                <th>Description</th>
                                <th>Price Per Menu (RM)</th>
                                <th>Quantity</th>
                                <th>Total Price (RM)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%  if(orderItems.size() == 0) { %>
                            <tr>
                                <td colspan="5"><%= "No Order had been made" %></td>
                            </tr>
                            <%  } %>
 
                            <%  if(orderItems.size() > 0) {
                                    for(int i = 0; i < orderItems.size(); i++) { %>
                            <tr>
                                <td><%= foods.get(i).getFoodName() %></td>
                                <td><%= foods.get(i).getFoodDescription() %></td>
                                <td><%= String.format("RM%.2f", foods.get(i).getFoodPrice()) %></td>
                                <td><%= orderItems.get(i).getItemQuantity() %></td>
                                <td><%= String.format("RM%.2f", orderItems.get(i).getTotalPrice()) %></td>
                            </tr>
                            <%      } 
                                } %>                                     
                        </tbody>
                    </table>
                </div>
                
                <div class="row">
                    <div class="col">
                        <div class="table-responsive manage-booking-container">
                            <table class="table table-light table-striped">
                                <thead class="thead-dark">
                                    <tr>
                                        <th colspan="<%= 2 + orderItems.size() %>"><h1>Amount Summary</h1></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th>Booking</th>
                                        <td><label class="form-control-plaint-text" id="Price"><%= String.format("RM%.2f", selectedBooking.getBookingPrice()) %></label></td>
                                    </tr>
                                    <%  if(orderItems.size() > 0) { %>
                                    <tr>
                                        <th>Order</th>
                                        <td><label class="form-control-plaint-text" id="Price"><%= String.format("RM%.2f", totalPriceForOrders) %></td>
                                    </tr>
                                    <%  } %>
                                    <tr>
                                        <th>Grand Total</th>
                                        <td><label class="form-control-plaint-text" id="Price"><%= String.format("RM%.2f", totalPriceForOrders + selectedBooking.getBookingPrice()) %></label></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                                    
                    <div class="col">
                        <div class="table-responsive manage-booking-container">
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
            </div>
        </div>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
