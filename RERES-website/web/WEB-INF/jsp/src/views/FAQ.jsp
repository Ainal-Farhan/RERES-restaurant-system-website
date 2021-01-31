<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Frequently Asked Question</title>
        <style>
        <%@include file="../../../css/style/global.css"%>
   
            body {
                background-position: center;
                background-repeat: no-repeat;
                background-size:cover;
                position: relative;
             }
         
            .collapsible {
                background-color: #777;
                color: white;
                cursor: pointer;
                padding: 18px;
                width: 100%;
                border: none;
                text-align: left;
                outline: none;
                font-size: 15px;
            }

            .active, .collapsible:hover {
                background-color: #555;
            }

            .content {
                padding: 0 18px;
                display: none;
                overflow: hidden;
                background-color: #f1f1f1;
            }
            
        </style>
    </head>
    <body>
        <header>
            <%@include file = "../components/navigationBar.jsp" %>
        </header>
        
        <div class="content-container">
            <div class="caption">
                <div class="container-sm">
                    <div class="d-flex justify-content-center mb-3">
                        <div class="card" style="width:600px">
                            <div class="card-header">
                                <h1>Frequently Asked Question</h1>
                            </div>
                     
                            <h2>Below you'll find answers to the questions we get asked the most</h2>


                            <!-- Collapsible Set: -->
                            <button type="button" class="collapsible"><b>1) How to Make a Booking.</b></button>
                            <div class="content">
                                <ol>
                                    <li>Go to the Booking Table Page by clicking at the Booking Table Tab.</li>
                                    <form action="BookingTableServlet" method="POST" name="booking_table">
                                        <div onClick="document.forms['booking_table'].submit();">
                                            <input type="hidden" name="action" value="viewBookingTable">
                                            <a class="nav-link" href="javascript:void(0);"><i class="far fa-edit"></i>BOOKING TABLE</a>
                                        </div>
                                    </form>
                                    <li>Select the date, set up the time and number of person to be booked.</li>
                                    <li>Select the available table numbers.</li>
                                    <li>(Optional)Put in a description of the booking.</li>
                                    <li>Select the option to order the food.</li>
                                    <li>If the you have select order food 'Now' and click on the 'Make Reservation' button, it will directing you to the Order Menu page.</li>
                                    
                                </ol>
                            </div>
                            <button type="button" class="collapsible"><b>2) How to Update Your Personal Detail.</b></button>
                            <div class="content">
                                <ol>
                                    <li>Go to the Profile page by clicking at the Profile Tab.</li>
                                    <form action="UserServlet" method="POST" name="profile">
                                        <div onClick="document.forms['profile'].submit();">
                                            <input type="hidden" name="action" value="viewProfile">
                                            <input type="hidden" name="userType" value="<%= currentUserType.toLowerCase() %>">
                                            <input type="hidden" name="userID" value="<%= currentUserID %>">
                                            <a class="nav-link" href="javascript:void(0);"><i class="far fa-user"></i>PROFILE</a>
                                        </div>
                                    </form>
                                    <li>Click on the Update button </li>
                                    <li>Edit the profile details </li>
                                    <li>Click 'Back' to cancel edit of the profile</li>
                                    <li>Click 'Save' to save the profile details entered.</li>
                                </ol>
                            </div>
                            <button type="button" class="collapsible"><b>3) How to View Booking History.</b></button>
                            <div class="content">
                                <ol>
                                    <li> Go to the Booking List Page by clicking the Booking List Tab.</li>
                                    <li> Click on 'Go' to see further details about the booking and the status.</li>
                                    <form action="BookingServlet" method="POST" name="booking_list">
                                        <div onClick="document.forms['booking_list'].submit();">
                                        <input type="hidden" name="action" value="viewBookingListForCustomer">
                                        <a class="nav-link" href="javascript:void(0);"><i class="far fa-address-book"></i>YOUR BOOKING LIST</a>
                                        </div>
                                    </form>
                                </ol>
                            </div>
                            <button type="button" class="collapsible"><b>4) How to Make a Payment of the Booking.</b></button>
                            <div class="content">
                                <ol>
                                    <li>After making the booking from the Booking Table .</li>
                                    <form action="BookingTableServlet" method="POST" name="booking_table">
                                        <div onClick="document.forms['booking_table'].submit();">
                                            <input type="hidden" name="action" value="viewBookingTable">
                                            <a class="nav-link" href="javascript:void(0);"><i class="far fa-edit"></i>BOOKING TABLE</a>
                                        </div>
                                    </form>
                                    <li>The total payment will be displayed.</li>
                                    <li>Next, click the 'Make Reservation' button to submit </li>
                                    <li>The system will redirecting the users to a payment form page.</li>   
                                </ol>
                            </div>
                            <button type="button" class="collapsible"><b>5) How to Retrieve a Discount as a Member.</b></button>
                            <div class="content">
                                <ol>
                                    
                                    <li>Go to the Membership Page.</li>
                                    <form action="MembershipServlet" method="POST" name="membership_view">
                                        <div onClick="document.forms['membership_view'].submit();">
                                            <input type="hidden" name="action" value="viewMembershipPage">
                                            <a class="nav-link" href="javascript:void(0);"><i class="fas fa-user-friends"></i>MEMBERSHIP</a>
                                        </div>
                                    </form>
                                    <li> Check for the status of amount of booking</li>
                                    <li>The discount can only be redeemed once the customer had booked for at least 3 times and applied on the next booking order.</li>
                                    <li style="color:red;">Non-member or member that has not reached the amount of booking for at least 3 times cannot redeem for the discount. </li>
                                    <li>Then go to the Booking Table Page to make reservation and the discount will be applied on the next reservation.</li>
                                    
                                    <form action="BookingTableServlet" method="POST" name="booking_table">
                                        <div onClick="document.forms['booking_table'].submit();">
                                            <input type="hidden" name="action" value="viewBookingTable">
                                            <a class="nav-link" href="javascript:void(0);"><i class="far fa-edit"></i>BOOKING TABLE</a>
                                        </div>
                                    </form>
                                </ol>
                                    
                            </div>
                            <button type="button" class="collapsible"><b>6) How to Renew Membership.</b></button>
                            <div class="content">
                                <ol>
                                    <li>Renew Membership will be available once the customer have used the discount.</li>
                                    <li>Go to the Membership Page.</li>
                                    <form action="MembershipServlet" method="POST" name="membership_view">
                                        <div onClick="document.forms['membership_view'].submit();">
                                            <input type="hidden" name="action" value="viewMembershipPage">
                                            <a class="nav-link" href="javascript:void(0);"><i class="fas fa-user-friends"></i>MEMBERSHIP</a>
                                        </div>
                                    </form>
                                    <li>Click on the 'Renew Membership'</li>
                                    <li>Then, it will be redirected to a payment page.</li>
                                </ol>
                                    
                            </div>

                            <script>
                                var coll = document.getElementsByClassName("collapsible");
                                var i;

                                for (i = 0; i < coll.length; i++) {
                                    coll[i].addEventListener("click", function() {
                                        this.classList.toggle("active");
                                        var content = this.nextElementSibling;
                                        if (content.style.display === "block") {
                                            content.style.display = "none";
                                        } else {
                                            content.style.display = "block";
                                        }
                                    });
                                }
                            </script>
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
