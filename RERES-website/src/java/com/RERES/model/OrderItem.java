/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.RERES.model;

/**
 *
 * @author ainal farhan
 */
public class OrderItem {
    private int orderItemID;
    private int itemQuantity;
    private double totalPrice;
    private int fkBookingID;
    private int fkFoodID;
    
    public OrderItem() {}
    
    public int getOrderItemID() {
        return orderItemID;
    }

    public void setOrderItemID(int orderItemID) {
        this.orderItemID = orderItemID;
    }

    public int getItemQuantity() {
        return itemQuantity;
    }

    public void setItemQuantity(int itemQuantity) {
        this.itemQuantity = itemQuantity;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getFkBookingID() {
        return fkBookingID;
    }

    public void setFkBookingID(int fkBookingID) {
        this.fkBookingID = fkBookingID;
    }

    public int getFkFoodID() {
        return fkFoodID;
    }

    public void setFkFoodID(int fkFoodID) {
        this.fkFoodID = fkFoodID;
    }
}
