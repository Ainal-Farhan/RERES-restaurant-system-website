/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Database {
    final String DATABASE_URL = "jdbc:mysql://johnny.heliohost.org:3306/ainalfa_RERES-db?useTimeZone=true&serverTimezone=UTC&autoReconnect=true&useSSL=false";
    
    private static Connection con = null;
    
    public Database(){
    }
    
    public Connection getCon() throws SQLException, ClassNotFoundException {
        if(Database.con != null)
            return Database.con;
        
        Class.forName("com.mysql.cj.jdbc.Driver");
            
            /*
                Database: ainalfa_RERES-db
                Host: johnny.heliohost.org
                
            Danial:
                user: ainalfa_Danial
                password: danial@123

            Zahir:
                user: ainalfa_Zahir
                password: zahir@123

            Hasan:
                user: ainalfa_Hasan
                password: hasan@123
            */
            
            /*
                Suggested method for accessing the remote database from the other class:
                
                Connection con = new Database().getCon();
            */
            
//            Please change the user and password based on your own information
//
//        String[] username = {
//            "ainalfa_Danial",
//            "ainalfa_Zahir",
//            "ainalfa_Hasan"
//        };
//        
//        String[] password = {
//            "danial@123",
//            "zahir@123",
//            "hasan@123"
//        };
//            
//        for(int i = 0; i < 3; i++) {
//            try {
//                Database.con = DriverManager.getConnection(DATABASE_URL, username[i], password[i]);
//            }
//            catch(SQLException ex) {
//                if(i < 3)
//                    continue;
//                Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
//            }
//            if(Database.con != null) {
//                break;
//            }
//        }
//            Please use this one if you want to connect to the local database
//            All of the information may changes depends on the database beinng setup in the localhost
        Database.con = DriverManager.getConnection("jdbc:mysql://localhost:3307/reres-db", "root", "");
                
        return Database.con;
    }
}
