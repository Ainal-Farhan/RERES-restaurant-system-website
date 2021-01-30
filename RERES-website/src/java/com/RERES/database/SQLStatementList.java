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
        "   `food`.`food_id`, `food`.`food_name`, `food`.`food_price`,`food`.`food_description`, `food`.`food_photo`, " +
        "   `refund`.`refund_id`, `refund`.`refund_price`, `refund`.`refund_description`,`refund`.`refund_status`, `refund`.`refund_date`, `refund`.`fk_bookingID` " +
        "FROM `booking` " +
        "LEFT JOIN `payment` ON `payment`.`fk_bookingID` = ? " +
        "INNER JOIN `user` ON `booking`.`fk_userID` = `user`.`user_id` AND `user`.`user_type`='customer' " +
        "INNER JOIN `bookingtable` ON `booking`.`fk_bookingTableID` = `bookingtable`.`bookingTable_id`" +
        "LEFT JOIN `orderitem` ON `payment`.`fk_bookingID` = `orderitem`.`fk_bookingID` AND `orderitem`.`fk_bookingID` = ? " +
        "LEFT JOIN `food` ON `food`.`food_id` = `orderitem`.`fk_foodID` " +
        "LEFT JOIN `refund` ON `refund`.`fk_bookingID` = ? " +
        "WHERE `booking`.`booking_id` = ?;";
    String SQL_STATEMENT_RETRIEVE_ALL_BOOKING_INFORMATION = "SELECT * FROM `booking` ORDER BY `booking_date` DESC;";
    String SQL_STATEMENT_RETRIEVE_ALL_BOOKING_INFORMATION_FOR_A_CUSTOMER = "SELECT * FROM `booking` WHERE `fk_userID` = ? ORDER BY `booking_date` DESC;";
    String SQL_STATEMENT_RETRIEVE_PAYMENT_INFORMATION_WITH_BOOKING_ID = "SELECT * FROM `payment` WHERE `fk_bookingID` =?;";
    String SQL_STATEMENT_RETRIEVE_USER_AUTHENTICATE = "SELECT * FROM `user` WHERE `password` = ? AND `username` = ? OR `email` = ?;";
    String SQL_STATEMENT_RETRIEVE_BOOKING_LIST_AND_TABLE_LIST = "SELECT `booking`.`booking_id`, `booking`.`booking_date`, `booking`.`time_slot`, `booking`.`time_code`, `booking`.`booking_quantity`, `booking`.`fk_bookingTableID`, " + 
            "`bookingTable`.`bookingTable_id`, `bookingTable`.`bookingTable_code`, `bookingTable`.`bookingTable_status`, `bookingTable`.`bookingTable_capacity` " +
            "FROM `booking` " +
            "LEFT JOIN `bookingTable` ON `booking`.`fk_bookingTableID` = `bookingTable`.`bookingTable_id` " +
            "WHERE `booking`.`booking_date` = ? AND `booking`.`time_code` = ?;";
    String SQL_STATEMENT_RETRIEVE_TABLE_LIST = "SELECT * FROM `bookingtable`";
    String SQL_STATEMENT_RETRIEVE_BOOKING_INFO = "SELECT `booking_id` FROM `booking` WHERE `time_code` = ? AND booking_date = ? AND fk_bookingTableID = ? ";
    String SQL_STATEMENT_RETRIEVE_SPECIFIC_MEMBERSHIP_INFORMATION = "SELECT * FROM `membership` WHERE `fk_UserID` = ?";
    String SQL_STATEMENT_RETRIEVE_FOOD_LIST_BY_CATEGORY = "SELECT * FROM `food` WHERE `food_category` = ?;";
    String SQL_STATEMENT_RETRIEVE_FOOD_LIST = "SELECT * FROM `food`";
    String SQL_STATEMENT_RETRIEVE_FOOD_LIST_BY_FOODID = "SELECT * FROM `food` WHERE `food`.`food_id` = ?;";
    String SQL_STATEMENT_RETRIEVE_USERID = "SELECT `user_id` FROM `user` WHERE `email` = ? AND `username` = ?;";
    
    // List of INSERT instruction
    String SQL_STATEMENT_INSERT_SUCCESSFULLY_PAY_FOR_A_BOOKING = "INSERT INTO `payment` "
            + "(`payment_status`, `payment_method`, `total_payment`, `fk_bookingID`) "
            + "VALUES ('done', ?, ?, ?)";
    String SQL_STATEMENT_INSERT_REGISTER_USER = "INSERT INTO User(username, password, user_type, name, age, birth_date, email, address, gender, phone_number, profile_photo) VALUES(?,?,?,?,?,?,?,?,?,?, ?)";
    String SQL_STATEMENT_INSERT_BOOKING_FOOD_LATER = "INSERT INTO `booking` " 
            + "(`booking_description`, `booking_date`, `time_slot`, `time_code`, `booking_quantity`, `booking_price`, `fk_userID`, `fk_bookingTableID`) " 
            +"VALUES (?,?,?,?,?,?,?,?)";
    String SQL_STATEMENT_INSERT_PAYMENT_INFO = "INSERT INTO `payment`(`fk_bookingID`) VALUES (?);";
    String SQL_STATEMENT_INSERT_ORDER_ITEM = "INSERT  INTO `orderitem`(`item_quantity`, `total_price`, `fk_bookingID`, `fk_foodID`) " 
            +"VALUES(?, ?, ?, ?)";
    String SQL_STATEMENT_INSERT_REFUND_INFO = "INSERT INTO `refund`(`refund_price`, `refund_description`, `refund_status`, `fk_bookingID`) VALUES (?,?,?,?);";
    String SQL_STATEMENT_INSERT_NEW_FOOD = "INSERT INTO `food`(`food_name`, `food_price`, `food_description`, `food_category`, `food_photo`) "
            + "VALUES (?, ?, ?, ?, ?);";
    String SQL_STATEMENT_INSERT_MEMBERSHIP_INFO = "INSERT INTO `membership`(`member_name`, `fk_userID`) VALUES (?,?);";
    
    // List of UPDATE instruction
    String SQL_STATEMENT_UPDATE_A_USER_INFORMATION = "UPDATE `user` SET `name`=?,`age`=?, `email`=?,`address`=?,`phone_number`=? WHERE `user`.`user_id`=?;";
    String SQL_STATEMENT_UPDATE_A_PAYMENT_INFORMATION = "UPDATE `payment` SET `payment_status` = ?, `payment_method` = ?, `total_payment` = ?, `date_paid` = ? WHERE `payment`.`fk_bookingID` = ?";
    String SQL_STATEMENT_UPDATE_THE_BOOKING_STATUS = "UPDATE `booking` SET `booking_status` = ? WHERE `booking`.`booking_id` = ?";
    String SQL_STATEMENT_UPDATE_BOOKING_TABLE_STATUS = "UPDATE `bookingtable` SET `bookingTable_status`= ?  WHERE  `bookingTable_id` = ?;";
    String SQL_STATEMENT_UPDATE_MEMBERSHIP_STATUS = "UPDATE `membership` SET `member_status` = ?, `success_booking_made` = 0 WHERE `member_id` = ?";
    String SQL_STATEMENT_UPDATE_USER_PROFILE_PICTURE = "UPDATE `user` SET `profile_photo` = ? WHERE `user_id` = ?";
    String SQL_STATEMENT_UPDATE_MEMBERSHIP_SUCCESS_ORDER_MADE = "UPDATE `membership` SET `success_booking_made` = `success_booking_made` + 1 WHERE `fk_userID` = ? AND `member_status` = 'member'";
    String SQL_STATEMENT_UPDATE_FOOD_DETAILS = "UPDATE `food` SET `food_name`=?, `food_price`=?, `food_description`=?, `food_category`=?, `food_photo`=? WHERE `food`.`food_id` = ?;";
    
    // List of DELETE instruction
    String SQL_STATEMENT_DELETE_A_USER_INFORMATION = "DELETE FROM `user` WHERE `user`.`user_id` = ?;";
    String SQL_STATEMENT_DELETE_A_FOOD = "DELETE FROM `food` WHERE `food`.`food_id` = ?;";
}
