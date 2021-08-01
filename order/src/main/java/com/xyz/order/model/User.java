package com.xyz.order.model;

public class User {

    private long id;
    private String name;
    private String password;
    private String role;
    private String isDeleted;
    private String company;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() { return role;}

    public void setRole(String role) { this.role = role;}

    public String getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(String isDeleted) {
        this.isDeleted = isDeleted;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password +
                ", role='" + role +
                ", isDeleted='" + isDeleted +
                '}';
    }

    public User(long id, String name, String password, String role, String isDeleted, String company) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.role = role;
        this.isDeleted = isDeleted;
        this.company = company;
    }

    public User(String name, String password, String role, String isDeleted) {
        this.name = name;
        this.password = password;
        this.role = role;
        this.isDeleted = isDeleted;
    }
}
