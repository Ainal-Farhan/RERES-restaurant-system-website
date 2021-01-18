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
public class Membership implements Serializable {
    private int memberID;
    private String memberName;
    private String voucherRedeem;
    private String memberStatus;
    private int fkUserID;
    
    public Membership() {}

    public int getMemberID() {
        return memberID;
    }

    public void setMemberID(int memberID) {
        this.memberID = memberID;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getVoucherRedeem() {
        return voucherRedeem;
    }

    public void setVoucherRedeem(String voucherRedeem) {
        this.voucherRedeem = voucherRedeem;
    }

    public String getMemberStatus() {
        return memberStatus;
    }

    public void setMemberStatus(String memberStatus) {
        this.memberStatus = memberStatus;
    }

    public int getFkUserID() {
        return fkUserID;
    }

    public void setFkUserID(int fkUserID) {
        this.fkUserID = fkUserID;
    }
    
}
