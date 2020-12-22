/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.middleware;

/**
 *
 * @author PC
 */
public class Customer extends User{
    private int customerID;
    
    public Customer() {
    }
    
    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }
    
    public int getCustomerID() {
        return customerID;
    }
}
