<%-- 
    Document   : manageTable
    Created on : Jan 31, 2021, 6:24:34 PM
    Author     : ainal farhan
--%>

<%@page import="com.RERES.model.BookingTable"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Table</title>
        
        <style>
            <%@include file="../../../css/style/global.css"%>
            
            .custom-shadow {
                box-shadow: 
                    rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, 
                    rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, 
                    rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;
            }
        </style>
               
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <%
            ArrayList<BookingTable> bookingTables = (ArrayList<BookingTable>)request.getAttribute("bookingTables");
        %>
        
        <div class="content-container">
            <div class="container-custom">
                <div class="table-responsive bg-light container-custom" style="width: 700px;">
                    <table class="table table-hover table-striped custom-shadow"  style="text-align: center;margin-bottom: 0;">
                        <thead class="thead-dark">
                            <tr>
                                <th colspan="4"><h4>Manage Booking</h4></th>
                            </tr>
                            <tr>
                                <th>Table Code</th>
                                <th>Table Capacity</th>
                                <th>Table Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for(int i = 0; i < bookingTables.size() ; i++) { %>
                            <tr>
                                <td><%= bookingTables.get(i).getBookingTableCode() %></td>
                                <td><%= bookingTables.get(i).getBookingTableCapacity() %></td>
                                <td><%= bookingTables.get(i).getBookingTableStatus().toUpperCase() %></td>
                                <td>
                                    <form action="BookingTableServlet" method="POST">
                                        <input type="hidden" name="action" value="changeBookingTableStatus">
                                        <input type="hidden" name="bookingTableStatus" value="<%= bookingTables.get(i).getBookingTableStatus() %>">
                                        <input type="hidden" name="bookingTableID" value="<%= bookingTables.get(i).getBookingTableID() %>">
                                        <button type="submit" class="btn btn-danger" style="height:30px;padding: 2px 2px 2px 2px;">Change</button>
                                    </form>
                                </td>
                            </tr>
                            <%  } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>