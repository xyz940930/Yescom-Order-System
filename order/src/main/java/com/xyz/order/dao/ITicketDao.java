package com.xyz.order.dao;

import com.xyz.order.model.Sales;
import com.xyz.order.model.Ticket;

import java.util.List;
import java.util.Map;

public interface ITicketDao {


    List<Ticket> showAllTickets(Map<String,Object> map);

    List<Ticket> searchAllTickets(Map<String,Object> map);

    Ticket getTicket(String id);

    void updateTicket(Ticket ticket) ;

    void updateNotes(Map<String,Object> map) ;

    void updateCheckOutTime(String id) ;

    void createTicket(Ticket ticket) ;

/*    void productSale(Ticket ticket) ;

    String totalSales(String start, String end);*/

    List<Sales> getSales (Map<String,Object> map);

/*    void createLogger(Logger logger);

    List<Logger>  showAllLogger(Map<String,Object> map);*/

}
