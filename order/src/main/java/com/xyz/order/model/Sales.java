package com.xyz.order.model;

public class Sales {
    private String sales;
    private String store;
    private String GST;
    private String salesExlGst;
    private String ticketNum;
    private String salesNum;
    private String repaired;
    private String sendAway;
    private String paidPartial;

    public String getSales() {
        return sales;
    }

    public void setSales(String sales) {
        this.sales = sales;
    }

    public String getStore() {
        return store;
    }

    public void setStore(String store) {
        this.store = store;
    }

    public String getGST() {
        return GST;
    }

    public void setGST(String GST) {
        this.GST = GST;
    }

    public String getSalesExlGst() {
        return salesExlGst;
    }

    public void setSalesExlGst(String salesExlGst) {
        this.salesExlGst = salesExlGst;
    }

    public String getTicketNum() {
        return ticketNum;
    }

    public void setTicketNum(String ticketNum) {
        this.ticketNum = ticketNum;
    }

    public String getSalesNum() {
        return salesNum;
    }

    public void setSalesNum(String salesNum) {
        this.salesNum = salesNum;
    }

    public String getRepaired() {
        return repaired;
    }

    public void setRepaired(String repaired) {
        this.repaired = repaired;
    }

    public String getSendAway() {
        return sendAway;
    }

    public void setSendAway(String sendAway) {
        this.sendAway = sendAway;
    }

    public String getPaidPartial() {
        return paidPartial;
    }

    public void setPaidPartial(String paidPartial) {
        this.paidPartial = paidPartial;
    }
}
