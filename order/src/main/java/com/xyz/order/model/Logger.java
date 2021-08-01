package com.xyz.order.model;

public class Logger {
    private long id;
    private String name;
    private String record;
    private String date;
    private String ticketID;


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

    public String getRecord() {
        return record;
    }

    public void setRecord(String record) {
        this.record = record;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTicketID() {
        return ticketID;
    }

    public void setTicketID(String ticketID) {
        this.ticketID = ticketID;
    }

    public Logger(String name, String record, String ticketID) {
        this.name = name;
        this.record = record;
        this.ticketID = ticketID;
    }
}
