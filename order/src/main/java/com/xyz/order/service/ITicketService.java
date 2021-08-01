package com.xyz.order.service;

import com.xyz.order.model.Sales;
import com.xyz.order.model.Ticket;

import java.util.List;
import java.util.Map;

public interface ITicketService {

    List<Ticket> showAllTickets(Map<String,Object> map);

    List<Ticket> searchAllTickets(Map<String,Object> map);

    Ticket getTicket(String id);

    void updateTicket(Ticket ticket);

    void updateCheckOutTime(String id) ;

    void createTicket(Ticket ticket);

    List<Sales> getSales (Map<String,Object> map);

/*    void createLogger(Logger logger);

    List<Logger>  showAllLogger(Map<String,Object> map);*/

    void updateNotes(Map<String,Object> map) ;
}
