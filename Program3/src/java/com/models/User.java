package com.models;
public class User {
    private String firstName;
    private String lastName;
    private String email;
    private long mobileno;
    private String address;
    private String role;


    public User(String firstName, String lastName, String email, Long mobileno, String address, String role){
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.mobileno = mobileno;
        this.address = address;
        this.role = role;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public long getMobileno() {
        return mobileno;
    }

    public void setMobileno(long mobileno) {
        this.mobileno = mobileno;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

  

}