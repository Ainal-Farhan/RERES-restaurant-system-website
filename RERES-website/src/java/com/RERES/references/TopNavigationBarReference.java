/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.references;

/**
 *
 * @author ainal farhan
 */
public interface TopNavigationBarReference {
    String SELECTED_PAGE = "selectedPage";
    
    
    // List of pageSelected values for authenticated user
    String STAFF_LIST_PAGE = "staffListPage";
    String CUSTOMERS_LIST_PAGE = "customersListPage";
    String BOOKING_TABLE_PAGE = "bookingTablePage";
    String BOOKING_LIST_PAGE = "bookingListPage";
    String PROFILE_PAGE = "profilePage";
    String FAQ_PAGE = "FAQPage";
    String MEMBERSHIP_PAGE = "membershipPage";
    String MANAGE_FOOD_PAGE = "manageFoodPage";
    String DASHBOARD_PAGE = "dashboardPage";
    
    // List of pageSelected values for public
    String LOGIN_PAGE = "loginPage";
    String REGISTRATION_PAGE = "registrationPage";
    
    // List of pageSelected values for both public and authenticated user
    String HOME_PAGE = "homePage";
}
