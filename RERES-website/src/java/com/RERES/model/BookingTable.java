/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.model;

import java.io.Serializable;

/**
 *
 * @author ainal farhan
 */
public class BookingTable implements Serializable {
    private int bookingTableID;
    private String bookingTableStatus;
    private int bookingTableCode;
    private int bookingTableCapacity;
    
    public BookingTable(){}

    public BookingTable(int bookingTableID, String bookingTableStatus, int bookingTableCode, int bookingTableCapacity) {
        this.bookingTableID = bookingTableID;
        this.bookingTableStatus = bookingTableStatus;
        this.bookingTableCode = bookingTableCode;
        this.bookingTableCapacity = bookingTableCapacity;
    }

    public int getBookingTableID() {
        return bookingTableID;
    }

    public void setBookingTableID(int bookingTableID) {
        this.bookingTableID = bookingTableID;
    }

    public String getBookingTableStatus() {
        return bookingTableStatus;
    }

    public void setBookingTableStatus(String bookingTableStatus) {
        this.bookingTableStatus = bookingTableStatus;
    }

    public int getBookingTableCode() {
        return bookingTableCode;
    }

    public void setBookingTableCode(int bookingTableCode) {
        this.bookingTableCode = bookingTableCode;
    }

    public int getBookingTableCapacity() {
        return bookingTableCapacity;
    }

    public void setBookingTableCapacity(int bookingTableCapacity) {
        this.bookingTableCapacity = bookingTableCapacity;
    }
}
