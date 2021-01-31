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
public interface UserServletReference {
    
    // list of actions for doPost() method -----------------------------------
    String ACTION_VIEW_USER_LIST = "viewUserList";
    String ACTION_VIEW_A_USER = "ViewAUser";
    String ACTION_VIEW_PROFILE = "viewProfile";
    String ACTION_UPDATE_OR_DELETE_A_USER = "updateOrDeleteUser";
    String ACTION_REGISTER_USER = "registerUser";
    String ACTION_LOGIN_USER = "authLogin";
    String ACTION_LOGOUT_USER = "logout";
    String ACTION_VIEW_HOME_PAGE_AUTHENTICATED = "viewHomePageAuthenticated";
    String ACTION_UPDATE_USER_PROFILE_PICTURE = "updateUserProfilePicture";
    
    // list of actions for doGet() method -----------------------------------
    String ACTION_GET_SELECTED_USER_PROFILE_PICTURE = "getSelectedUserProfilePicture";
    
    // labels for view List of -----------------------------------
    String[] PUBLIC_INFO_LABELS = {
        "No",
        "Name",
        "Age",
        "Email",
        "Profile Picture",
    };
    
    // type of user -----------------------------------
    String USER_TYPE_CUSTOMER = "customer";
    String USER_TYPE_STAFF = "staff";
    String USER_TYPE_ADMIN = "admin";
    
}
