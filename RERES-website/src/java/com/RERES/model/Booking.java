/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author ainal farhan
 */
public class Booking implements Serializable {
    private int bookingID;
    private String bookingDescription;
    private Date bookingDate;
    private int timeCode;
    private String timeSlot;
    private String bookingStatus;
    private int bookingQuantity;
    private double bookingPrice;
    private Timestamp bookingDateCreated;
    private int fkUserID;
    private int fkBookingTableID;

    public Booking() {}  
    
    public int getFkBookingTableID() {
        return fkBookingTableID;
    }

    public void setFkBookingTableID(int fkBookingTableID) {
        this.fkBookingTableID = fkBookingTableID;
    }

    public int getTimeCode() {
        return timeCode;
    }

    public void setTimeCode(int timeCode) {
        this.timeCode = timeCode;
    }

    public String getTimeSlot() {
        return timeSlot;
    }

    public void setTimeSlot(String timeSlot) {
        this.timeSlot = timeSlot;
    }
    
    public int getBookingID() {
        return bookingID;
    }

    public void setBookingID(int bookingID) {
        this.bookingID = bookingID;
    }

    public String getBookingDescription() {
        return bookingDescription;
    }

    public void setBookingDescription(String bookingDescription) {
        this.bookingDescription = bookingDescription;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public int getBookingQuantity() {
        return bookingQuantity;
    }

    public void setBookingQuantity(int bookingQuantity) {
        this.bookingQuantity = bookingQuantity;
    }

    public double getBookingPrice() {
        return bookingPrice;
    }

    public void setBookingPrice(double bookingPrice) {
        this.bookingPrice = bookingPrice;
    }

    public Timestamp getBookingDateCreated() {
        return bookingDateCreated;
    }

    public void setBookingDateCreated(Timestamp bookingDateCreated) {
        this.bookingDateCreated = bookingDateCreated;
    }

    public int getFkUserID() {
        return fkUserID;
    }

    public void setFkUserID(int fkUserID) {
        this.fkUserID = fkUserID;
    }
    
    
}
