package com.RERES.path;

/*
* This where all of path required by the servlet to their respective web page being stored
*/

public interface Path {
    String MAIN_PATH = "WEB-INF";
    
    // Path for the main view file
    String MAIN_VIEW_PATH = MAIN_PATH + "/jsp/src/views";
    
    // Path for views
    String MANAGE_BOOKING_VIEW_PATH = MAIN_VIEW_PATH + "/manageBooking.jsp";
    String MANAGE_USER_VIEW_PATH = MAIN_VIEW_PATH + "/manageUser.jsp";
    String PAYMENT_FORM_VIEW_PATH = MAIN_VIEW_PATH + "/paymentForm.jsp";
    String VIEW_USER_LIST_VIEW_PATH = MAIN_VIEW_PATH + "/viewUserList.jsp";
    String LOGIN_VIEW_PATH = MAIN_VIEW_PATH + "/login.jsp";
    String PROFILE_VIEW_PATH = MAIN_VIEW_PATH + "/profile.jsp";
    String REGISTRATION_VIEW_PATH = MAIN_VIEW_PATH + "/registration.jsp";
    String BOOKING_TABLE_VIEW_PATH = MAIN_VIEW_PATH + "/bookingTable.jsp";
    String ORDER_FOOD_VIEW_PATH = MAIN_VIEW_PATH + "/orderFood.jsp";
    String DOCUMENTATION_VIEW_PATH = MAIN_VIEW_PATH + "/documentation.jsp";
    String MEMBERSHIP_VIEW_PATH = MAIN_VIEW_PATH + "/membership.jsp";
    String HELP_CHAT_VIEW_PATH = MAIN_VIEW_PATH + "/helpChat.jsp";

}