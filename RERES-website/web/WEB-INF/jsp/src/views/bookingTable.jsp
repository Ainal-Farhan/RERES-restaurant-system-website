<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.RERES.model.BookingTable" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        <title>Booking Table Page</title>
        <style><%@include file="../../../css/style/global.css"%></style>
        <style><%@include file="../../../css/style/bookingTable.css"%></style>
    </head>
    
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
            <%@include file = "../components/bookNavigationBar.jsp" %>
        </header>
       
        <div class="content-container">
            <div class="container-custom bgContent p-4" style="min-height:85vh;">
                <form action="BookingTableServlet" method="POST">
                    <div class="row topForm">

                        <div class="col-3">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                                </div>
                                <% 
                                    Calendar calendar = Calendar.getInstance();
                                    String dd = Integer.toString(calendar.get(Calendar.DAY_OF_MONTH) + 1);
                                    String mm = Integer.toString(calendar.get(Calendar.MONTH) + 1);
                                    String yyyy = Integer.toString(calendar.get(Calendar.YEAR));
                                    if(Integer.parseInt(dd) < 10)dd = '0' + dd;
                                    if(Integer.parseInt(mm) < 10)mm = '0' + mm;
                                    String minDate = "" + yyyy + "-" + mm + "-" + dd;
                                %>
                                <%  if(request.getAttribute("timeCode") != null && request.getAttribute("timeSlot") != null) { %>
                                <input type="date" class="form-control form-control-lg" name="bookDate" min="<%= minDate %>" id="date1" value="<%= request.getAttribute("selectedDate") %>" required/>
                                <%  }  else { %>
                                <input type="date" class="form-control form-control-lg" name="bookDate" min="<%= minDate %>" id="date2" required>
                                <%  } %>
                            </div>
                        </div>

                        <div class="col-3">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="far fa-clock"></i></span>
                                </div>
                                <select class="form-control form-control-lg" placeholder="Time" name="timeCode" id="timeCode" required>
                                    <%  if(request.getAttribute("timeCode") != null && request.getAttribute("timeSlot") != null) { %>
                                    <%= "<option value='" + request.getAttribute("timeCode") + "'>" + request.getAttribute("timeSlot") + "</option>" %>
                                    <%  } %>
                                    <option value="1">9.00 AM - 10.00 AM</option>
                                    <option value="2">10.00 AM - 11.00 AM</option>
                                    <option value="3">11.00 AM - 12.00 PM</option>
                                    <option value="4">12.00 PM - 1.00 PM</option>
                                    <option value="5">1.00 PM - 2.00 PM</option>
                                    <option value="6">2.00 PM - 3.00 PM</option>
                                    <option value="7">3.00 PM - 4.00 PM</option>
                                    <option value="8">4.00 PM - 5.00 PM</option>
                                    <option value="9">5.00 PM - 6.00 PM</option>
                                    <option value="10">6.00 PM - 7.00 PM</option>
                                    <option value="11">7.00 PM - 8.00 PM</option>
                                    <option value="12">8.00 PM - 9.00 PM</option>
                                    <option value="13">9.00 PM - 10.00 PM</option>
                                    <option value="14">10.00 PM - 11.00 PM</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-3">
                            <div class="input-group mb-3">
                                <div class="input-group-prepend">
                                    <span class="input-group-text"><i class="far fa-user"></i></span>
                                </div>

                                <select class="form-control form-control-lg" placeholder="Person(s)" name="bookQuantity" id="bookQuantity" required>
                                    <!--<option value="1">1 person</option>-->
                                    <%  if(request.getAttribute("bookQuantity") != null) { %>
                                    <%= "<option value='" + request.getAttribute("bookQuantity") + "'>" + request.getAttribute("bookQuantity") + " persons</option>" %>
                                    <%  } %>
                                    <option value="2">2 persons</option>
                                    <option value="3">3 persons</option>
                                    <option value="4">4 persons</option>
                                    <option value="5">5 persons</option>
                                    <option value="6">6 persons</option>
                                    <option value="7">7 persons</option>
                                    <option value="8">8 persons</option>
                                    <option value="9">9 persons</option>
                                    <option value="10">10 persons</option>
                                    <option value="11">11 persons</option>
                                    <option value="12">12 persons</option>
                                    <option value="13">13 persons</option>
                                    <option value="14">14 persons</option>
                                    <option value="15">15 persons</option>
                                </select>
                            </div>
                        </div>

                        <div class="col-3">
                            <input type="hidden" name="action" value="checkAvailability">
                            <input class="btn btn-danger btn-block btn-lg" type="submit" value="Check Availability">
                        </div>

                    </div>
                </form>

                <div class="row">
                    <div class="col-12" style="text-align: center">
                        <%
                            if(request.getAttribute("isCheck") != null && (Boolean)request.getAttribute("isCheck")) {
                        %>
                        <h1><%= request.getAttribute("displayMessage") %></h1>
                        <% } %>
                    </div>
                </div>

                <form action="BookingTableServlet" method="POST">
                    <div class="row mt-4">
                        <div class="col mt-4 table-table-status">
                            <table class="table table-striped mt-2" style="text-align: center;">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Table Number</th>
                                        <th>Status</th>
                                        <th>Capacity</th>
                                    </tr>
                                    <tbody>
                                        <% 
                                            if(request.getAttribute("isCheck") != null && (Boolean)request.getAttribute("isCheck")) {
                                                ArrayList<BookingTable> btlist = (ArrayList<BookingTable>)request.getAttribute("btlist");
                                                for(BookingTable bt: btlist) {
                                        %>
                                        <tr>
                                            <td><strong><h5><%= bt.getBookingTableCode() %></h5></strong></td>
                                            <td><strong><h5><%= bt.getBookingTableStatus().toUpperCase() %></h5></strong></td>
                                            <td><strong><h5><%= bt.getBookingTableCapacity() %></h5></strong></td>
                                        </tr>
                                        <%  
                                                }
                                            }
                                            else { %>
                                        <tr>
                                            <td colspan="3">Please check table availability to show the list of available table here</td>
                                        </tr>
                                        <% } %>
                                    </tbody>
                                </thead>
                            </table>
                        </div>
                                    
                        <div class="col-lg-6 booking-table-layout">
                            <div>
                                <h5>RERES table layout:</h5>
                                <img src="${pageContext.servletContext.contextPath}/assets/img/bookingtable/tableLayout.png" alt="logo" style="width: 750px;" class="booking-table-layout-image">
                            </div>
                        </div>
                            
                        <div class="col mt-4 booking-table-form">
                            <label for="tableNumber"><h5>Please select the available table number here:</h5></label>
                            <select class="form-control form-control-lg" placeholder="Person(s)" name="tableCode" id="tableCode" required>
                            <% 
                                if(request.getAttribute("isCheck") != null && (Boolean)request.getAttribute("isCheck")) {
                                    ArrayList<BookingTable> btlist = (ArrayList<BookingTable>)request.getAttribute("btlist");
                                    for(int i=0; i<btlist.size(); i++) {
                                        if(btlist.get(i).getBookingTableStatus().compareToIgnoreCase("available") > 0){
                                            btlist.remove(i);
                                            i--;
                                        }
                                    }
                                    for(BookingTable bt: btlist) {
                            %>
                            <option value="<%= bt.getBookingTableCode() %>"><%= bt.getBookingTableCode() %></option>
                            <%
                                    }
                                }
                            %>
                            </select><br>

                            <div class="form-group">
                                <label for="bookDescription"><h5>Please enter your booking description:</h5></label>
                                <input type="text" class="form-control form-control-lg" name="bookDescription" id="bookDescription" placeholder="Enter booking description">
                            </div>

                            <label for="foodOrder" ><h5>Order your food: </h5></label>
                            <div class="form-check">
                                <label class="form-check-label">
                                    <input type="radio" class="form-check-input" name="foodOrder" value="now">Now
                                </label>
                            </div>
                            <div class="form-check">
                                <label class="form-check-label">
                                    <input type="radio" class="form-check-input" name="foodOrder" value="later" checked>Later
                                </label>
                            </div>
                            <p>*You have to pay now if you want to order food now</p><br>
                        <%
                        if(request.getAttribute("isCheck") != null && (Boolean)request.getAttribute("isCheck")) {
                        %>
                            <h4><%= String.format("Price: RM%.2f (%s)", request.getAttribute("bookPrice"), request.getAttribute("discountMessage")) %></h4>
                            <input type="hidden" name="action" value="makeReserve">
                            <input class="btn btn-success btn-block btn-lg" type="submit" value="Make Reservation">
                        <%
                        }
                        %>
                            
                        </div>
                    </div>
                </form>
            </div>
        </div>
    
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>