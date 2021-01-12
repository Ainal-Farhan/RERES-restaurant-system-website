/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.model;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author ainal farhan
 */
public class Payment implements Serializable{
    private int paymentID;
    private String paymentStatus;
    private String paymentMethod;
    private double totalPayment;
    private Date datePaid;
    private int fkBookingID;
    
    public Payment() {}

    public int getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(int paymentID) {
        this.paymentID = paymentID;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalPayment() {
        return totalPayment;
    }

    public void setTotalPayment(double totalPayment) {
        this.totalPayment = totalPayment;
    }

    public Date getDatePaid() {
        return datePaid;
    }

    public void setDatePaid(Date datePaid) {
        this.datePaid = datePaid;
    }

    public int getFkBookingID() {
        return fkBookingID;
    }

    public void setFkBookingID(int fkBookingID) {
        this.fkBookingID = fkBookingID;
    }
    
}
