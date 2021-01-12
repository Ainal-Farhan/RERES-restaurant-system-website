/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.database;

public interface SQLStatementList {
    // List of SELECT instruction
    String SQL_STATEMENT_RETRIEVE_ALL_USERS_INFORMATION = "SELECT * FROM User;";
    String SQL_STATEMENT_RETRIEVE_ALL_SPECIFIC_USER_INFORMATION = "SELECT * FROM User WHERE user_type=?;";
    
    // List of INSERT instruction
    
    // List of UPDATE instruction
    String SQL_STATEMENT_UPDATE_A_USER_INFORMATION = "UPDATE `user` SET `name`=?,`age`=?,`birth_date`=?,`email`=?,`address`=?,`gender`=?,`phone_number`=?,`profile_photo`=? WHERE `user`.`user_id`=?;";
    
    // List of DELETE instruction
    String SQL_STATEMENT_DELETE_A_USER_INFORMATION = "DELETE FROM `user` WHERE `user`.`user_id` = ?;";
}
