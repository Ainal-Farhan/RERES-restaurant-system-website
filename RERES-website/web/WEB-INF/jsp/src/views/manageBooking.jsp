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
            <div class="container">                    
                <table class="table table-light table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th colspan="4"><h1>Booking Details<h1></th>
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
                                    <input type="submit" class="btn btn-primary form-control" value="View">
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <th>Description</th>
                            <td><jsp:getProperty name="selectedBooking" property="bookingDescription"/></td>
                            <th>Quantity</th>
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
                            <td><jsp:getProperty name="selectedBookingPayment" property="paymentStatus"/></td>
                            <th>Booking Status</th>
                            <td><jsp:getProperty name="selectedBooking" property="bookingStatus"/></td>
                        </tr>
                    </tbody>
                </table>
                
                <%  if(orderItems.size() > 0) { %>
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
                        <%  for(int i = 0; i < orderItems.size(); i++) { %>
                        <tr>
                            <td><%= foods.get(i).getFoodName() %></td>
                            <td><%= foods.get(i).getFoodDescription() %></td>
                            <td><%= String.format("RM%.2f", foods.get(i).getFoodPrice()) %></td>
                            <td><%= orderItems.get(i).getItemQuantity() %></td>
                            <td><%= String.format("RM%.2f", orderItems.get(i).getTotalPrice()) %></td>
                        </tr>
                        <%  } %>                                     
                    </tbody>
                </table>
                <%  } %>
                
                <table class="table table-light table-striped">
                    <thead class="thead-dark">
                        <tr>
                            <th colspan="<%= 2 + orderItems.size() %>"><h1>Payment<h1></th>
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
                            <th>Total</th>
                            <td><label class="form-control-plaint-text" id="Price"><%= String.format("RM%.2f", selectedBookingPayment.getTotalPayment()) %></label></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
