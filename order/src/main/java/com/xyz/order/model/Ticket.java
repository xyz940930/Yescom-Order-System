package com.xyz.order.model;

public class Ticket {
    private long id;
    private String customerName;
    private String mobile;
    private String price;
    private String status;
    private String device;
    private String devicePassword;
    private String deviceIssue;
    private String date;
    private String createdBy;
    private String amountDue;
    private String paymentMethod;
    private String store;
    private String isDeleted;
    private String notes;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDevice() {
        return device;
    }

    public void setDevice(String device) {
        this.device = device;
    }

    public String getDevicePassword() {
        return devicePassword;
    }

    public void setDevicePassword(String devicePassword) {
        this.devicePassword = devicePassword;
    }

    public String getDeviceIssue() {
        return deviceIssue;
    }

    public void setDeviceIssue(String deviceIssue) {
        this.deviceIssue = deviceIssue;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public String getAmountDue() {
        return amountDue;
    }

    public void setAmountDue(String amountDue) {
        this.amountDue = amountDue;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStore() {
        return store;
    }

    public void setStore(String store) {
        this.store = store;
    }

    public String getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(String isDeleted) {
        this.isDeleted = isDeleted;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    @Override
    public String toString() {
        return "Ticket{" +
                "id=" + id +
                ", customerName='" + customerName + '\'' +
                ", mobile='" + mobile + '\'' +
                ", date='" + date + '\'' +
                ", device='" + device + '\'' +
                ", devicePassword='" + devicePassword + '\'' +
                ", deviceIssue='" + deviceIssue + '\'' +
                ", price='" + price + '\'' +
                ", status='" + status + '\'' +
                '}';
    }

    public Ticket(long id, String customerName, String mobile, String price, String status, String device, String devicePassword, String deviceIssue, String date, String createdBy, String amountDue, String paymentMethod, String store, String isDeleted, String notes) {
        this.id = id;
        this.customerName = customerName;
        this.mobile = mobile;
        this.price = price;
        this.status = status;
        this.device = device;
        this.devicePassword = devicePassword;
        this.deviceIssue = deviceIssue;
        this.date = date;
        this.createdBy = createdBy;
        this.amountDue = amountDue;
        this.paymentMethod = paymentMethod;
        this.store = store;
        this.isDeleted = isDeleted;
        this.notes = notes;
    }

    /*Ticket Constructor*/
    public Ticket(String customerName, String mobile, String price, String amountDue, String device, String devicePassword, String deviceIssue, String createdBy, String status, String isDeleted, String store, String notes) {
        this.customerName = customerName;
        this.mobile = mobile;
        this.price = price;
        this.amountDue = amountDue;
        this.device = device;
        this.devicePassword = devicePassword;
        this.deviceIssue = deviceIssue;
        this.createdBy = createdBy;
        this.status = status;  /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
        this.store = store;
        this.isDeleted = isDeleted; /*1 = deleted   0 = active */
        this.notes = notes;
    }




}
