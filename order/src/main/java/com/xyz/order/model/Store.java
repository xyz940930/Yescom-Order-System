package com.xyz.order.model;

public class Store {
    private long id;
    private String company;
    private String store;
    private String isDeleted;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }



    public String getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(String isDeleted) {
        this.isDeleted = isDeleted;
    }

    public String getStore() {
        return store;
    }

    public void setStore(String store) {
        this.store = store;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", company='" + company + '\'' +
                ", store='" + store +
                ", isDeleted='" + isDeleted +
                '}';
    }

    public Store(long id, String company, String store, String isDeleted) {
        this.id = id;
        this.company = company;
        this.store = store;
        this.isDeleted = isDeleted;
    }


}
