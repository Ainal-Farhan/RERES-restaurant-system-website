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
public class User {
    
    // This is data from the Table User
    //----------------------
    private  int userID;
    private String username;
    private String password;
    private String userType;
    
    // This the data from the Table Customer/ Staff which has the same attribute
    //--------------------------------
    private String name;
    private String birthDate;
    private int age;
    private String email;
    private String address;
    private String phoneNumber;
    private String gender;
    private String profilePicturePath;
    //--------------------------------
    
    public User() {
        
    }
    
    public void setUserInformation(int userID, String username, String password, String userType) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.userType = userType;
    }
    
    public void setStaffOrCustomerInformation(String name, String birthDate, int age, String email, String address, String phoneNumber, String gender, String profilePicturePath) {
        this.name = name;
        this.birthDate = birthDate;
        this.age = age;
        this.email = email;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.gender = gender;
        this.profilePicturePath = profilePicturePath;
    }
    
    // Return the data of the user
    //---------------------------
    public int getUserID() {
        return userID;
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public String getUserType() {
        return userType;
    }
    //----------------------------
    
    // Return the data of the staff/ customer
    //--------------------------------------
    public String getName() {
        return name;
    }
    public String getBirthDate() {
        return birthDate;
    }
    public int getAge() {
        return age;
    }
    public String getEmail() {
        return email;
    }
    public String getAddress() {
        return address;
    }
    public String getPhoneNumber() {
        return phoneNumber;
    }
    public String getGender() {
        return gender;
    }
    public String getProfilePicturePath() {
        return profilePicturePath;
    }
    //--------------------------------------
}
