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
        
        <div class="content-container">
            <div class="container">
                <form>
                    <div class="form-group">
                        <h1>Booking Details</h1>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="CustomerName">Customer Name</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="CustomerName"><jsp:getProperty name="selectedBookingUser" property="name"/></label>
                        </div>
                        <div class="col-1">
                            <button class="btn btn-primary form-control">View</button>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="BookingDescription">Description</label>
                        </div>
                        <div class="col">
                            <textarea class="form-control" name="booking-description" id="BookingDescription" cols="30" rows="10"><jsp:getProperty name="selectedBooking" property="bookingDescription"/></textarea>
                        </div>
                    </div>
                    
                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="BookingiD">Booking ID</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="BookingiD"><jsp:getProperty name="selectedBooking" property="bookingID"/></label>
                        </div>

                        <div class="col-2">
                            <label for="BookingCreated">Booking created</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="BookingCreated"><jsp:getProperty name="selectedBooking" property="bookingDateCreated"/></label>
                        </div>
                    </div>
                    
                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="Quantity">Quantity</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="Quantity"><jsp:getProperty name="selectedBooking" property="bookingQuantity"/></label>
                        </div>

                        <div class="col-2">
                            <label for="Price">Price</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="Price"><jsp:getProperty name="selectedBooking" property="bookingPrice"/></label>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="BookingDate">Date</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="BookingDate"><jsp:getProperty name="selectedBooking" property="bookingDate"/></label>
                        </div>

                        <div class="col-2">
                            <label for="BookingDuration">Duration</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="BookingDuration"><jsp:getProperty name="selectedBooking" property="bookingDuration"/></label>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="StartTime">Start Time</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="StartTime"><jsp:getProperty name="selectedBooking" property="bookingStartTime"/></label>
                        </div>

                        <div class="col-2">
                            <label for="EndTime">End Time</label>
                        </div>
                        <div class="col">
                            <label class="form-control-plaint-text" id="EndTime"><jsp:getProperty name="selectedBooking" property="bookingEndTime"/></label>
                        </div>
                    </div>

                    <div class="form-group form-row align-items-center">
                        <div class="col-2">
                            <label for="PaymentStatus">Payment Status</label>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="payment-status" id="PaymentStatus" value="<jsp:getProperty name="selectedBookingPayment" property="paymentStatus"/>">
                        </div>

                        <div class="col-2">
                            <label for="BookingStatus">Booking Status</label>
                        </div>
                        <div class="col">
                            <input type="text" class="form-control" name="booking-status" id="BookingStatus" value="<jsp:getProperty name="selectedBooking" property="bookingStatus"/>">
                        </div>
                    </div>

                    <div class="form-group btn-group-manage-booking">
                        <button type="button" class="btn btn-primary">Back</button>
                        <button type="button" class="btn btn-danger">Delete</button>
                    </div>
                </form>
            </div>
        </div>
        
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
