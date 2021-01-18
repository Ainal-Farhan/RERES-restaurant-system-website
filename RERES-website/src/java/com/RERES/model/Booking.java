/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

/**
 *
 * @author ainal farhan
 */
public class Booking implements Serializable {
    private int bookingID;
    private String bookingDescription;
    private Date bookingDate;
    private int bookingDuration;
    private Time bookingStartTime;
    private Time bookingEndTime;
    private String bookingStatus;
    private int bookingQuantity;
    private double bookingPrice;
    private Timestamp bookingDateCreated;
    private int fkUserID;

    public Booking() {}    
    
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

    public int getBookingDuration() {
        return bookingDuration;
    }

    public void setBookingDuration(int bookingDuration) {
        this.bookingDuration = bookingDuration;
    }

    public Time getBookingStartTime() {
        return bookingStartTime;
    }

    public void setBookingStartTime(Time bookingStartTime) {
        this.bookingStartTime = bookingStartTime;
    }

    public Time getBookingEndTime() {
        return bookingEndTime;
    }

    public void setBookingEndTime(Time bookingEndTime) {
        this.bookingEndTime = bookingEndTime;
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
