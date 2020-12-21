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
    Connection con;
    
    public Database(){
        
    }
    
    public Connection getCon() {
        try {
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
                
                Connection con new Database().getCon();
            */
            
//            Please change the user and password based on your own information
            DriverManager.getConnection("jdbc:mysql://johnny.heliohost.org:3306/ainalfa_RERES-db", "ainalfa_Danial", "danial@123");
            
//            Please use this one if you want to connect to the local database
//            All of the information may changes depends on the database beinng setup in the localhost
//            DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb", "root", "1234");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return con;
    }
}
