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
public interface SessionReference {
    // Session attributes for user
    String CURRENT_USER_TYPE = "currentUserType"; // store String value
    String CURRENT_USER_ID = "currentUserID"; // store Integer value
    String IS_AUTHENTICATED = "isAuthenticated"; // store Boolean value
    String PROFILE_PICTURE = "profilePicture"; // store Boolean value
    String NAME = "name"; // store Boolean value
}
