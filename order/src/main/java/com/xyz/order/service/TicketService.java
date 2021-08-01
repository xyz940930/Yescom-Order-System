package com.xyz.order.service;

import com.xyz.order.dao.ITicketDao;
import com.xyz.order.model.Sales;
import com.xyz.order.model.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service(value = "ticketService")
public class TicketService implements ITicketService{

    @Autowired
    private ITicketDao ticketDao;

    public List<Ticket> showAllTickets(Map<String,Object> map){
        return this.ticketDao.showAllTickets(map);
    }

    @Override
    public List<Ticket> searchAllTickets(Map<String, Object> map) {
        return this.ticketDao.searchAllTickets(map);
    }

    @Override
    public Ticket getTicket(String id) {
        return this.ticketDao.getTicket(id);
    }

    @Override
    public void updateTicket(Ticket ticket) {
        this.ticketDao.updateTicket(ticket);
    }

    @Override
    public void updateCheckOutTime(String id) {
        this.ticketDao.updateCheckOutTime(id);
    }

    @Override
    public void createTicket(Ticket ticket) {
        this.ticketDao.createTicket(ticket);
    }

    @Override
    public List<Sales> getSales(Map<String, Object> map) {
        return this.ticketDao.getSales(map);
    }

/*    @Override
    public void createLogger(Logger logger) {
        this.ticketDao.createLogger(logger);
    }

    @Override
    public List<Logger> showAllLogger(Map<String,Object> map) {
        return this.ticketDao.showAllLogger(map);
    }*/

    @Override
    public void updateNotes(Map<String, Object> map) {
        this.ticketDao.updateNotes(map);
    }


}


