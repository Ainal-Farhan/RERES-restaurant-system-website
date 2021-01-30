<%@page import="com.RERES.references.TopNavigationBarReference"%>
<%@page import="com.RERES.path.Path"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style><%@include file="../../../css/style/navigationBar.css"%></style>
        
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
        
        <style>
            * {
                margin: 0;
                padding: 0;
            }
            i {
                margin-right: 10px;
            }
            /*----------multi-level-accordian-menu------------*/
            nav {
                z-index: 1;
            }
            
            .navbar-logo{
                padding: 15px;
                color: #fff;
            }
            .navbar-mainbg{
                background-color: white;
                padding: 0px;
            }
            #navbarSupportedContent{
                overflow: hidden;
                position: relative;
            }
            #navbarSupportedContent ul{
                padding: 0px;
                margin: 0px;
            }
            #navbarSupportedContent ul li a i,
            #navbarSupportedContent ul li form a i{
                margin-right: 10px;
            }
            #navbarSupportedContent li {
                list-style-type: none;
                float: left;
            }
            #navbarSupportedContent ul li form a,
            #navbarSupportedContent ul li a{
                color: black;
                text-decoration: none;
                font-size: 15px;
                display: block;
                padding: 20px 20px;
                transition-duration:0.6s;
                    transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
                position: relative;
            }
            #navbarSupportedContent>ul>li.active>a,
            #navbarSupportedContent>ul>li.active>form>div>a{
                color: white;
                background-color: transparent;
                transition: all 0.7s;
            }
            #navbarSupportedContent a:not(:only-child):after {
                position: absolute;
                right: 20px;
                top: 10px;
                font-size: 14px;
                font-family: "Font Awesome 5 Free";
                display: inline-block;
                padding-right: 3px;
                vertical-align: middle;
                font-weight: 900;
                transition: 0.5s;
            }
            #navbarSupportedContent .active>a:not(:only-child):after {
                transform: rotate(90deg);
            }
            
            .hori-selector{
                display:inline-block;
                position:absolute;
                height: 100%;
                top: 0px;
                left: 0px;
                transition-duration:0.6s;
                transition-timing-function: cubic-bezier(0.68, -0.55, 0.265, 1.55);
                background-color: black;
                border-top-left-radius: 15px;
                border-top-right-radius: 15px;
                margin-top: 10px;
            }
            .hori-selector .right,
            .hori-selector .left{
                position: absolute;
                width: 25px;
                height: 25px;
                background-color: black;
                bottom: 10px;
            }
            .hori-selector .right{
                right: -25px;
            }
            .hori-selector .left{
                left: -25px;
            }
            .hori-selector .right:before,
            .hori-selector .left:before{
                content: '';
                position: absolute;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                background-color: white;
            }
            .hori-selector .right:before{
                bottom: 0;
                right: -25px;
            }
            .hori-selector .left:before{
                bottom: 0;
                left: -25px;
            }

            @media (max-width: 991px){
                #navbarSupportedContent ul li a{
                    padding: 12px 30px;
                }
                .hori-selector{
                    margin-top: 0px;
                    margin-left: 10px;
                    border-radius: 0;
                    border-top-left-radius: 25px;
                    border-bottom-left-radius: 25px;
                }
                .hori-selector .left,
                .hori-selector .right{
                    right: 10px;
                }
                .hori-selector .left{
                    top: -25px;
                    left: auto;
                }
                .hori-selector .right{
                    bottom: -25px;
                }
                .hori-selector .left:before{
                    left: -25px;
                    top: -25px;
                }
                .hori-selector .right:before{
                    bottom: -25px;
                    left: -25px;
                }
            }
            
            .nav-item-custom:hover {
                cursor: pointer;
                box-shadow: 
                    rgba(50, 50, 93, 0.25) 0px 50px 100px -20px, 
                    rgba(0, 0, 0, 0.3) 0px 30px 60px -30px, 
                    rgba(10, 37, 64, 0.35) 0px -2px 6px 0px inset;
                border-radius: 20px;
            }
        </style>
        
        <script>
            // ---------Responsive-navbar-active-animation-----------
            function test(){
                var tabsNewAnim = $('#navbarSupportedContent');
                var selectorNewAnim = $('#navbarSupportedContent').find('li').length;
                var activeItemNewAnim = tabsNewAnim.find('.active');
                var activeWidthNewAnimHeight = activeItemNewAnim.innerHeight();
                var activeWidthNewAnimWidth = activeItemNewAnim.innerWidth();
                var itemPosNewAnimTop = activeItemNewAnim.position();
                var itemPosNewAnimLeft = activeItemNewAnim.position();
                $(".hori-selector").css({
                    "top":itemPosNewAnimTop.top + "px", 
                    "left":itemPosNewAnimLeft.left + "px",
                    "height": activeWidthNewAnimHeight + "px",
                    "width": activeWidthNewAnimWidth + "px"
                });
                $("#navbarSupportedContent").on("click","li",function(e){
                    $('#navbarSupportedContent ul li').removeClass("active");
                    $(this).addClass('active');
                    var activeWidthNewAnimHeight = $(this).innerHeight();
                    var activeWidthNewAnimWidth = $(this).innerWidth();
                    var itemPosNewAnimTop = $(this).position();
                    var itemPosNewAnimLeft = $(this).position();
                    $(".hori-selector").css({
                      "top":itemPosNewAnimTop.top + "px", 
                      "left":itemPosNewAnimLeft.left + "px",
                      "height": activeWidthNewAnimHeight + "px",
                      "width": activeWidthNewAnimWidth + "px"
                    });
                });
            }
            $(document).ready(function(){
                setTimeout(function(){ test(); });
            });
            $(window).on('resize', function(){
                setTimeout(function(){ test(); }, 500);
            });
            $(".navbar-toggler").click(function(){
                setTimeout(function(){ test(); });
            });
        </script>
    </head>
    <body>
        <%
            final String mainStyle = "nav-item-custom";
            String homeActive = mainStyle;
            String staffActive = mainStyle;
            String customersActive = mainStyle;
            String bookingTableActive = mainStyle;
            String bookingListActive = mainStyle;
            String profileActive = mainStyle;
            String FAQActive = mainStyle;
            String membershipActive = mainStyle;
            String manageFoodActive = mainStyle;
            
            if(request.getAttribute(TopNavigationBarReference.SELECTED_PAGE) != null) {
                String selectedPage = (String)request.getAttribute(TopNavigationBarReference.SELECTED_PAGE);
                
                if(selectedPage.equals(TopNavigationBarReference.STAFF_LIST_PAGE)) staffActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.CUSTOMERS_LIST_PAGE)) customersActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.BOOKING_TABLE_PAGE)) bookingTableActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.BOOKING_LIST_PAGE)) bookingListActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.PROFILE_PAGE)) profileActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.FAQ_PAGE)) FAQActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.MEMBERSHIP_PAGE)) membershipActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.HOME_PAGE)) homeActive = "active";
                else if(selectedPage.equals(TopNavigationBarReference.MANAGE_FOOD_PAGE)) manageFoodActive = "active";
            }
        %>
        <nav class="navbar navbar-expand-lg navbar-mainbg">
            <img class="navbar-logo" src="${pageContext.servletContext.contextPath}<% out.println(Path.RERES_LOGO_PATH); %>/RERES-logo.png" width="150" alt="RERES-logo"/>
            
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars text-white"></i>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    
                    <div class="hori-selector"><div class="left"></div><div class="right"></div></div>
                    
                    <li class="nav-item <%= homeActive %>">
                        <a class="nav-link" href="${pageContext.servletContext.contextPath}/index.jsp"><i class="fas fa-home"></i>HOME</a>
                    </li>
                    
                    <%  
                            String currentUserType = (String)session.getAttribute("currentUserType");
                            int currentUserID = (Integer)session.getAttribute("currentUserID");
                            
                        if(currentUserType.equalsIgnoreCase("admin")) {
                            %>
                    
                    <li class="nav-item <%= staffActive %>">
                        <form action="UserServlet" method="POST" name="staff_list">
                            <div onClick="document.forms['staff_list'].submit();">
                                <input type="hidden" name="action" value="viewUserList">
                                <input type="hidden" name="viewUserType" value="staff">
                                <a class="nav-link" href="javascript:void(0);"><i class="fas fa-users"></i>STAFF</a>
                            </div>
                        </form>
                    </li>
                    
                    <%  } 
                        if(currentUserType.equalsIgnoreCase("staff") || currentUserType.equalsIgnoreCase("admin")) { %>
                    <li class="nav-item <%= customersActive %>">
                        <form action="UserServlet" method="POST" name="customer_list">
                            <div onClick="document.forms['customer_list'].submit();">
                                <input type="hidden" name="action" value="viewUserList">
                                <input type="hidden" name="viewUserType" value="customer">
                                <a class="nav-link" href="javascript:void(0);"><i class="fas fa-users"></i>CUSTOMERS</a>
                            </div>
                        </form>
                    </li>
                    
                    <li class="nav-item <%= manageFoodActive %>">
                        <form action="ManageFoodServlet" method="POST" name="manage_menu_list">
                            <div onClick="document.forms['manage_menu_list'].submit();">
                                <input type="hidden" name="action" value="viewListOfMenu">
                                <a class="nav-link" href="javascript:void(0);"><i class="fas fa-utensils"></i>MANAGE MENU</a>
                            </div>
                        </form>
                    </li>
                    
                    <li class="nav-item <%= bookingListActive %>">
                        <form action="BookingServlet" method="POST" name="booking_list">
                            <div onClick="document.forms['booking_list'].submit();">
                                <input type="hidden" name="action" value="viewBookingList">
                                <a class="nav-link" href="javascript:void(0);"><i class="far fa-address-book"></i>BOOKING LIST</a>
                            </div>
                        </form>
                    </li>
                    
                    <%  } 
                        if(currentUserType.equalsIgnoreCase("staff") || currentUserType.equalsIgnoreCase("customer")) { %>
                    <li class="nav-item <%= profileActive %>">
                        <form action="UserServlet" method="POST" name="profile">
                            <div onClick="document.forms['profile'].submit();">
                                <input type="hidden" name="action" value="viewProfile">
                                <input type="hidden" name="userType" value="<%= currentUserType.toLowerCase() %>">
                                <input type="hidden" name="userID" value="<%= currentUserID %>">
                                <a class="nav-link" href="javascript:void(0);"><i class="far fa-user"></i>PROFILE</a>
                            </div>
                        </form>
                    </li>
                    <%  } 
                        if(currentUserType.equalsIgnoreCase("customer")) { %>
                    <li class="nav-item <%= bookingListActive %>">
                        <form action="BookingServlet" method="POST" name="booking_list">
                            <div onClick="document.forms['booking_list'].submit();">
                                <input type="hidden" name="action" value="viewBookingListForCustomer">
                                <a class="nav-link" href="javascript:void(0);"><i class="far fa-address-book"></i>YOUR BOOKING LIST</a>
                            </div>
                        </form>
                    </li>
                    <li class="nav-item <%= bookingTableActive %>">
                        <form action="BookingTableServlet" method="POST" name="booking_table">
                            <div onClick="document.forms['booking_table'].submit();">
                                <input type="hidden" name="action" value="viewBookingTable">
                                <a class="nav-link" href="javascript:void(0);"><i class="far fa-edit"></i>BOOKING TABLE</a>
                            </div>
                        </form>
                    </li>
                    <li class="nav-item <%= membershipActive %>">
                        <form action="MembershipServlet" method="POST" name="membership_view">
                            <div onClick="document.forms['membership_view'].submit();">
                                <input type="hidden" name="action" value="viewMembershipPage">
                                <a class="nav-link" href="javascript:void(0);"><i class="fas fa-user-friends"></i>MEMBERSHIP</a>
                            </div>
                        </form>
                    </li>
                    <%
                        }
                            %>
                    <li class="nav-item <%= FAQActive %>">
                        <form action="FAQServlet" method="POST" name="faq">
                            <div onClick="document.forms['faq'].submit();">
                                <a class="nav-link" href="javascript:void(0);"><i class="far fa-question-circle"></i></i>FAQ</a>
                            </div>
                        </form>
                    </li>
                    <li class="nav-item nav-item-custom">
                        <form action="UserServlet" method="POST" name="logout">
                            <div onClick="document.forms['logout'].submit();">
                                <input type="hidden" name="action" value="logout">
                                <a class="nav-link" href="javascript:void(0);"><i class="fas fa-sign-out-alt"></i>LOGOUT</a>
                            </div>
                        </form>
                    </li>
                </ul>
            </div>
        </nav>
    </body>
</html>
