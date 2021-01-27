<%-- 
    Document   : orderDetails
    Created on : Jan 27, 2021, 7:47:18 AM
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
        <title>Order Details</title>
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../../css/style/global.css"%></style>
        <style><%@include file="../../../../css/style/manageBooking.css"%></style>
    </head>
    <body>
        <%  com.RERES.utility.SessionValidator.checkSession(request, response); %>
        
        <header>
            <%@include file = "../../components/navigationBar.jsp" %>
        </header>
        
        <%  
            ArrayList<OrderItem> orderItems = (ArrayList<OrderItem>)request.getAttribute("selectedBookingOrderItems");
            ArrayList<Food> foods = (ArrayList<Food>)request.getAttribute("selectedBookingFoods");

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
                    </div>
                </div>
                <footer>
                    <%@include file = "../../components/footer.jsp" %>
                </footer>
            </div>
        </div>
    </body>
</html>
