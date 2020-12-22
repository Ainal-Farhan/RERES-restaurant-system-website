/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.database;

public interface SQLStatementList {
    // List of SELECT instruction
    String SQL_STATEMENT_RETRIEVE_ALL_USERS_INFORMATION = "SELECT * FROM User;";
    String SQL_STATEMENT_RETRIEVE_ALL_STAFF_AND_USER_INFORMATION = "SELECT * FROM User JOIN Staff ON User.fk_staffID = Staff.staff_id;";
    String SQL_STATEMENT_RETRIEVE_ALL_CUSTOMERS_AND_USER_INFORMATION = "SELECT * FROM User JOIN Customer ON User.fk_customerID = Customer.customer_id;";
    
    // List of INSERT instruction
    
    // List of UPDATE instruction
    
    // List of DELETE instruction
}
