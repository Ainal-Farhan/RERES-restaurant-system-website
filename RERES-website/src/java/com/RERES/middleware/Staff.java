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
public class Staff extends User{
    private int staffID;
    
    public Staff() {
    }
    
    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }
    
    public int getStaffID() {
        return staffID;
    }
}
