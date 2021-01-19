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
    String SQL_STATEMENT_RETRIEVE_A_USER_INFORMATION = "SELECT * FROM User WHERE user_type=? AND user_id=?;";
    String SQL_STATEMENT_RETRIEVE_ALL_BOOKING_WITH_PAYMENT_ORDER_TABLE_AND_CUSTOMER_NAME_INFORMATION_BY_BOOKING_ID = "SELECT " +
        "   `payment`.`payment_id`, `payment`.`payment_status`, `payment`.`payment_method`, `payment`.`total_payment`, `payment`.`date_paid`, `payment`.`fk_bookingID`, " +
        "   `booking`.`booking_id`, `booking`.`booking_description`, `booking`.`booking_date`, `booking`.`time_slot`, `booking`.`time_code`, `booking`.`booking_status`, `booking`.`booking_quantity`, `booking`.`booking_price`, `booking`.`booking_date_created`, `booking`.`fk_userID`, `booking`.`fk_bookingTableID`, " +
        "   `user`.`name`, " +
        "   `orderitem`.`order_item_id`, `orderitem`.`item_quantity`, `orderitem`.`total_price`, `orderitem`.`fk_foodID`, " +
        "   `bookingtable`.`bookingTable_id`, `bookingtable`.`bookingTable_status`, `bookingtable`.`bookingTable_code`, `bookingtable`.`bookingTable_capacity`, " +
        "   `food`.`food_id`, `food`.`food_name`, `food`.`food_price`,`food`.`food_description`, `food`.`food_photo` " +
        "FROM `booking` " +
        "LEFT JOIN `payment` ON `payment`.`fk_bookingID` = ? " +
        "INNER JOIN `user` ON `booking`.`fk_userID` = `user`.`user_id` AND `user`.`user_type`='customer' " +
        "INNER JOIN `bookingtable` ON `booking`.`fk_bookingTableID` = `bookingtable`.`bookingTable_id`" +
        "LEFT JOIN `orderitem` ON `payment`.`fk_bookingID` = `orderitem`.`fk_bookingID` AND `orderitem`.`fk_bookingID` = ? " +
        "LEFT JOIN `food` ON `food`.`food_id` = `orderitem`.`fk_foodID`" +
        "WHERE `booking`.`booking_id` = ?";
    String SQL_STATEMENT_RETRIEVE_ALL_BOOKING_INFORMATION = "SELECT * FROM `booking`;";
    String SQL_STATEMENT_RETRIEVE_ALL_BOOKING_INFORMATION_FOR_A_CUSTOMER = "SELECT * FROM `booking` WHERE `fk_userID` = ?;";
    String SQL_STATEMENT_RETRIEVE_PAYMENT_INFORMATION_WITH_BOOKING_ID = "SELECT * FROM `payment` WHERE `fk_bookingID` =?;";
    String SQL_STATEMENT_RETRIEVE_USER_AUTHENTICATE = "SELECT * FROM `user` WHERE `password` = ? AND `username` = ? OR `email` = ?;";
    
    // List of INSERT instruction
    String SQL_STATEMENT_INSERT_SUCCESSFULLY_PAY_FOR_A_BOOKING = "INSERT INTO `payment` "
            + "(`payment_status`, `payment_method`, `total_payment`, `fk_bookingID`) "
            + "VALUES ('done', ?, ?, ?)";
    String SQL_STATEMENT_INSERT_REGISTER_USER = "INSERT INTO User(username, password, user_type, name, age, birth_date, email, address, gender, phone_number) VALUES(?,?,?,?,?,?,?,?,?,?)";
    
    // List of UPDATE instruction
    String SQL_STATEMENT_UPDATE_A_USER_INFORMATION = "UPDATE `user` SET `name`=?,`age`=?,`birth_date`=?,`email`=?,`address`=?,`gender`=?,`phone_number`=?,`profile_photo`=? WHERE `user`.`user_id`=?;";
    String SQL_STATEMENT_UPDATE_A_PAYMENT_INFORMATION = "UPDATE `payment` SET `payment_status` = ?, `payment_method` = ?, `total_payment` = ?, `date_paid` = ? WHERE `payment`.`fk_bookingID` = ?";
    String SQL_STATEMENT_UPDATE_THE_BOOKING_STATUS = "UPDATE `booking` SET `booking_status` = ? WHERE `booking`.`booking_id` = ?";
    
    // List of DELETE instruction
    String SQL_STATEMENT_DELETE_A_USER_INFORMATION = "DELETE FROM `user` WHERE `user`.`user_id` = ?;";
}
