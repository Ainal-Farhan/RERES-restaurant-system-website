package com.RERES.path;

import java.io.Serializable;

/*
* This where all of path required by the servlet to their respective web page being stored
*/

public interface Path extends Serializable {
    String MAIN_PATH_ASSETS = "/assets";
    String MAIN_PATH_JSP = "/WEB-INF";
    
    // Path for the main view file
    //--------------------------------------------------------------------------
    String MAIN_VIEW_PATH = MAIN_PATH_JSP + "/jsp/src/views";
    
    // Path for views
    String MANAGE_BOOKING_VIEW_PATH = MAIN_VIEW_PATH + "/manageBooking.jsp";
    String MANAGE_USER_VIEW_PATH = MAIN_VIEW_PATH + "/manageUser.jsp";
    String PAYMENT_FORM_VIEW_PATH = MAIN_VIEW_PATH + "/paymentForm.jsp";
    String USER_SERVLET_VIEW_PATH = MAIN_VIEW_PATH;
    String LOGIN_VIEW_PATH = MAIN_VIEW_PATH + "/login.jsp";
    String PROFILE_VIEW_PATH = MAIN_VIEW_PATH + "/profile.jsp";
    String REGISTRATION_VIEW_PATH = MAIN_VIEW_PATH + "/registration.jsp";
    String BOOKING_TABLE_VIEW_PATH = MAIN_VIEW_PATH + "/bookingTable.jsp";
    String ORDER_FOOD_VIEW_PATH = MAIN_VIEW_PATH + "/orderFood.jsp";
    String DOCUMENTATION_VIEW_PATH = MAIN_VIEW_PATH + "/documentation.jsp";
    String MEMBERSHIP_VIEW_PATH = MAIN_VIEW_PATH + "/membership.jsp";
    String HELP_CHAT_VIEW_PATH = MAIN_VIEW_PATH + "/helpChat.jsp";
    String HOME_VIEW_PATH = MAIN_VIEW_PATH + "/home.jsp";
    String BOOKING_LIST_VIEW_PATH = MAIN_VIEW_PATH + "/viewBookingListPage";
    //--------------------------------------------------------------------------
    
    // Path for the main component file
    //--------------------------------------------------------------------------
    String MAIN_COMPONENT_PATH = MAIN_PATH_JSP + "/jsp/src/components";
    
    // Path for components
    String COMPONENT_PROGRESS_BAR_PATH = MAIN_COMPONENT_PATH + "/progressBar.jsp";
    String COMPONENT_PROCESS_STATUS_OVERLAY_PATH = MAIN_COMPONENT_PATH + "/processStatusOverlay.jsp";
    //--------------------------------------------------------------------------
    
    // Main path for assets img
    //--------------------------------------------------------------------------
    String MAIN_PATH_IMAGE = MAIN_PATH_ASSETS + "/img";
    
    // Path for img
    String RERES_LOGO_PATH = MAIN_PATH_IMAGE + "/RERES";
    String PROFILE_PICTURE_CUSTOMER_PATH = MAIN_PATH_IMAGE + "/profile/customer";
    String PROFILE_PICTURE_STAFF_PATH = MAIN_PATH_IMAGE + "/profile/staff";
    //--------------------------------------------------------------------------

    
}
