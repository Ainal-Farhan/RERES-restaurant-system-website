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
        
        <content>
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
                                <input type="text" class="form-control" name="customer-name" id="CustomerName">
                            </div>
                            <div class="col-1">
                                <button class="btn btn-primary">View</button>
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col-2">
                                <label for="BookingDescription">Description</label>
                            </div>
                            <div class="col">
                                <textarea class="form-control" name="booking-description" id="BookingDescription" cols="30" rows="10"></textarea>
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="BookingDate">Date</label>
                            </div>
                            <div class="col">
                                <input type="date" class="form-control" name="booking-date" id="BookingDate">
                            </div>

                            <div class="col">
                                <label for="BookingDuration">Duration</label>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="booking-duration" id="BookingDuration">
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="StartTime">Start Time</label>
                            </div>
                            <div class="col">
                                <input type="time" class="form-control" name="start-time" id="StartTime">
                            </div>

                            <div class="col">
                                <label for="EndTime">End Time</label>
                            </div>
                            <div class="col">
                                <input type="time" class="form-control" name="end-time" id="EndTime">
                            </div>
                        </div>

                        <div class="form-group form-row align-items-center">
                            <div class="col">
                                <label for="PaymentStatus">Payment Status</label>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="payment-status" id="PaymentStatus">
                            </div>

                            <div class="col">
                                <label for="BookingStatus">Booking Status</label>
                            </div>
                            <div class="col">
                                <input type="text" class="form-control" name="booking-status" id="BookingStatus">
                            </div>
                        </div>

                        <div class="form-group btn-group-manage-booking">
                            <button class="btn btn-success">Update</button>
                            <button class="btn btn-primary">Back</button>
                            <button class="btn btn-danger">Delete</button>
                        </div>
                    </form>
                </div>
            </div>
        </content>
        
        <footer>
            <%@include file = "../components/footer.jsp" %>
        </footer>
    </body>
</html>
