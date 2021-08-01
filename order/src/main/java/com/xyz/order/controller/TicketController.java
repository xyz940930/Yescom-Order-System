package com.xyz.order.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.util.StringUtil;
import com.xyz.order.model.Constant;
import com.xyz.order.model.Sales;
import com.xyz.order.model.Ticket;
import com.xyz.order.service.IUserService;
import com.xyz.order.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class TicketController {
    @Autowired
    private TicketService ticketService;

    @Autowired
    private IUserService UserService;


    @RequestMapping(value = "/showTickets")
    public String showTickets(HttpServletRequest request, HttpServletResponse response, Model model) {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute(Constant.BACK_USER_KEY);
        if (null==username){
            return "index";
        }


        String name = request.getParameter("name");
        String store = request.getParameter("store");
        String order = request.getParameter("order");

        String ifInvo = request.getParameter("ifInvo");
        String pno = request.getParameter("pageNum");


/*        Object session = request.getSession().getAttribute("session"+name);
        if(null == session){
            return "forward:index";
        }*/

        /*Check if user is still valid*/
        if ("".equals(name) || null == name || "".equals(store) || null == store) {
            //return to login page
            return "index";
        }


        Map<String, Object> map = new HashMap<String, Object>();
        map.put("store", store);

        if (StringUtil.isNotEmpty(order)) {
            if(!"ASC".equals(order) && !"DESC".equals(order)){
                return "param expection";
            }

            map.put("order",order);
        }
        if (StringUtil.isNotEmpty(ifInvo)) {
           map.put("ifInvo",ifInvo);
        }
        /*process pagenumber null*/
        int pageNum = 1;    //default page number is 1
        int pageSize = 10;   //number of records show per page

        try{
            pageNum = Integer.parseInt(pno);
        }
        catch (Exception e){

        }
        if (pageNum <1){
            pageNum = 1;
        }

        String role = this.UserService.checkRole(name);
        if (role != null && !"".equals(role)) {
            model.addAttribute("role", role);
            model.addAttribute("name", name);
            model.addAttribute("store", store);
            PageHelper.startPage(pageNum, pageSize);
            List<Ticket> tickets = this.ticketService.showAllTickets(map);
            PageInfo pageInfo = new PageInfo(tickets);
            List<Ticket> ticketList = pageInfo.getList();
            model.addAttribute("tickets", ticketList);
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("displayMethod","showTickets");
        }

        return "homepage";
    }


    @RequestMapping(value = "/searchTickets")
    public String searchTickets(HttpServletRequest request, HttpServletResponse response, Model model) {


        HttpSession session = request.getSession();
        String username = (String) session.getAttribute(Constant.BACK_USER_KEY);
        if (null==username){
            return "index";
        }
        String name = request.getParameter("name");
        String store = request.getParameter("store");
        String order = request.getParameter("order");
        String id = request.getParameter("searchTicketID");
        String customerName = request.getParameter("searchCustomerName");
        String mobile = request.getParameter("searchMobile");
        String device = request.getParameter("searchDevice");
        String date = request.getParameter("dates");
        String status = request.getParameter("status");
        Map<String, Object> map = new HashMap<String, Object>();
        /*Split Date and get StartDate EndDate*/
        String pno = request.getParameter("pageNum");


        if (date!= null && !"".equals(date)  ){
            String[] dataSpliter = date.split("\\s");
            String startDate = dataSpliter[0];
            String endDate = dataSpliter[2];
            if (StringUtil.isNotEmpty(startDate)) {
                map.put("startDate", startDate);
            }
            if (StringUtil.isNotEmpty(endDate)) {
                map.put("endDate", endDate);
            }
            System.out.println(startDate);
            System.out.println(endDate);
        }

        System.out.println(id);
        System.out.println(customerName);

/*        String ifInvo = request.getParameter("ifInvo");*/


/*        Object session = request.getSession().getAttribute("session"+name);
        if(null == session){
            return "forward:index";
        }*/

        /*Check if user is still valid*/
        if ("".equals(name) || null == name || "".equals(store) || null == store) {
        //return to login page
            return "index";
        }
        /*Check Search Bar info*/
        map.put("store", store);

        if (StringUtil.isNotEmpty(id)) {
            map.put("id", id);
        }
        if (StringUtil.isNotEmpty(customerName)) {
            map.put("customerName", customerName);
        }
        if (StringUtil.isNotEmpty(mobile)) {
            map.put("mobile", mobile);
        }
        if (StringUtil.isNotEmpty(device)) {
            map.put("device", "%"+device+"%");
        }
        if (StringUtil.isNotEmpty(status)) {
            switch (status) {
                case "In Progress":
                    status="0";
                    break;
                case "Finished":
                    status="1";
                    break;
                case "Paid Partial":
                    status="2";
                    break;
                case "Repaired":
                    status="3";
                    break;
                case "Send Away":
                    status="4";
                    break;
                case "All":
                    status=null;
            }
            map.put("status", status);
        }

        if (StringUtil.isNotEmpty(order)) {
            if(!"ASC".equals(order) && !"DESC".equals(order)){
                return "param expection";
            }

            map.put("order",order);
        }

        /*process pagenumber null*/
        int pageNum = 1;    //default page number is 1
        int pageSize = 10;   //number of records show per page

        try{
            pageNum = Integer.parseInt(pno);
        }
        catch (Exception e){

        }
        if (pageNum <1){
            pageNum = 1;
        }

        String role = this.UserService.checkRole(name);
        if (role != null && !"".equals(role)) {
            model.addAttribute("role", role);
            model.addAttribute("name", name);
            model.addAttribute("store", store);
            PageHelper.startPage(pageNum, pageSize);
            List<Ticket> tickets = this.ticketService.searchAllTickets(map);
            PageInfo pageInfo = new PageInfo(tickets);
            List<Ticket> ticketList = pageInfo.getList();

            model.addAttribute("tickets", ticketList);
            model.addAttribute("pageInfo", pageInfo);
            model.addAttribute("displayMethod","searchTickets");
        }

        return "homepage";
    }



    @RequestMapping(value = "/getTicket")
    @ResponseBody
    public Map<String, Object> getTicket(String id) {
        Ticket ticket = this.ticketService.getTicket(id);
        DecimalFormat df2 = new DecimalFormat("#.##");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("id", ticket.getId());
        resultMap.put("customerName", ticket.getCustomerName());
        resultMap.put("mobile", ticket.getMobile());
        resultMap.put("device", ticket.getDevice());
        resultMap.put("deviceIssue", ticket.getDeviceIssue());
        resultMap.put("devicePtassword", ticket.getDevicePassword());
        resultMap.put("price",  df2.format(Double.parseDouble(ticket.getPrice())));
        resultMap.put("amountDue", ticket.getAmountDue());
        resultMap.put("priceExludeGST", df2.format(Double.parseDouble(ticket.getPrice()) - Double.parseDouble(ticket.getPrice())*3 / 23 ));
        resultMap.put("GST", df2.format(Double.parseDouble(ticket.getPrice())*3 / 23 )) ;
        resultMap.put("createdBy", ticket.getCreatedBy());
        resultMap.put("paymentMethod",ticket.getPaymentMethod());
        resultMap.put("notes",ticket.getNotes());
        resultMap.put("status", ticket.getStatus());
        resultMap.put("isDeleted", ticket.getIsDeleted());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        try {
            Date date = df.parse(ticket.getDate());
            resultMap.put("date",new SimpleDateFormat("dd/MM/yyyy").format(date));
        } catch (ParseException e) {
            e.printStackTrace();
        }
/*        resultMap.put("date",new SimpleDateFormat("yyyy-MMM-dd").format(ticket.getDate()));*/
/*        resultMap.put("store",ticket.getStore());*/

        return resultMap;
    }


    @RequestMapping(value = "/updateTicket")
    @ResponseBody
    public Map<String, Object> updateTicket(String username,String id, String customerName, String mobile, String device, String deviceIssue, String devicePassword, String price) {
        Ticket ticket = this.ticketService.getTicket(id);
        String logger = "";
        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> map = new HashMap<String, Object>();
        if (!ticket.getCustomerName().equals(customerName)) {
            logger = logger +" update customerName from "+ticket.getCustomerName()+" to "+customerName;
        }
        if (!ticket.getMobile().equals(mobile)) {
            logger = logger +" update mobile from "+ticket.getMobile()+" to "+mobile;
        }
        if (!ticket.getDevice().equals(device)) {
            logger = logger +" update device from "+ticket.getDevice()+" to "+device;
        }
        if (!ticket.getDeviceIssue().equals(deviceIssue)) {
            logger = logger +" update deviceIssue from "+ticket.getDeviceIssue()+" to "+deviceIssue;
        }
        if (!ticket.getDevicePassword().equals(devicePassword)) {
            logger = logger +" update devicePassword from "+ticket.getDevicePassword()+" to "+devicePassword;
        }
        if (!ticket.getPrice().equals(price)) {
            logger = logger + " update price from " + ticket.getPrice() + " to " + price;
        }
        LocalDateTime time = LocalDateTime.now();
        DateTimeFormatter tf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String new_notes = ticket.getNotes() + "<br/>" +logger +  "<span style='float:right'> by " + username + " on " +  tf.format(time) + "</span>";
        map.put("id",id);
        map.put("notes",new_notes);
        /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
        try {
            ticket.setCustomerName(customerName);
            ticket.setMobile(mobile);
            ticket.setDevice(device);
            ticket.setDeviceIssue(deviceIssue);
            ticket.setDevicePassword(devicePassword);
            ticket.setPrice(price);
            this.ticketService.updateTicket(ticket);
            this.ticketService.updateNotes(map);
            System.out.println(ticket.getNotes());
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }

        return resultMap;
    }


    @RequestMapping(value = "/updateNotes")
    @ResponseBody
    public Map<String, Object> updateNotes(String id, String notes, String user) {
        Ticket ticket = this.ticketService.getTicket(id);
        LocalDateTime time = LocalDateTime.now();
        DateTimeFormatter tf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        String new_notes = ticket.getNotes() + "<br/>" + notes + "<span style='float:right'> Created by " + user + " on " +  tf.format(time) + "</span>";
        Map<String, Object> resultMap = new HashMap<String, Object>();

        try {
            resultMap.put("id",id);
            resultMap.put("notes",new_notes);
            /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
            this.ticketService.updateNotes(resultMap);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }
        return resultMap;
    }

    @RequestMapping(value = "/updateStatus")
    @ResponseBody
    public Map<String, Object> updateStatus(String id, String status) {
        Ticket ticket = this.ticketService.getTicket(id);
        Map<String, Object> resultMap = new HashMap<String, Object>();

        try {
            ticket.setStatus(status);
            /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
            this.ticketService.updateTicket(ticket);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }
        return resultMap;
    }

    @RequestMapping(value = "/createTicket")
    @ResponseBody
    public Map<String, Object> createTicket(String customerName, String mobile, String device, String deviceIssue, String devicePassword, String price, String creator,String store, String notes) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        String status = "0"; /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
        String isDeleted = "0";  /*1 = deleted   0 = active */
        try {
            LocalDateTime time = LocalDateTime.now();
            DateTimeFormatter tf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
            String new_notes = notes +  "<span style='float:right'> Created by " + creator + " on " +  tf.format(time) + "</span>";
            Ticket ticket = new Ticket(customerName, mobile, price, price, device, devicePassword, deviceIssue, creator, status, isDeleted,store,new_notes);
            this.ticketService.createTicket(ticket);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }
        return resultMap;
    }
    @RequestMapping(value = "/warrantyTicket")
    @ResponseBody
    public Map<String, Object> warrantyTicket(String id, String username,String store) {
        LocalDateTime time = LocalDateTime.now();
        DateTimeFormatter tf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String status = "0"; /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
        String isDeleted = "0";  /*1 = deleted   0 = active */
        try{
            Ticket ticket = this.ticketService.getTicket(id);
            String new_notes = "Warranty Repair! Previous Ticket ID: " + id +" Prvious Price: " + ticket.getPrice()  +  "<span style='float:right'> Created by " + username + " on " +  tf.format(time) + "</span>";
            Ticket warrantyTicket = new Ticket(ticket.getCustomerName(), ticket.getMobile(), "0","0",ticket.getDevice(), ticket.getDevicePassword(), ticket.getDeviceIssue() + " (Warranty)", username, status, isDeleted,store,new_notes);
            this.ticketService.createTicket(warrantyTicket);
            resultMap.put("success", "success");

        }catch(Exception e){
            System.out.println(e);
            resultMap.put("error", "create ticket failed, please contact your technician");
        }

        return resultMap;
    }

    @RequestMapping(value = "/productSale")
    @ResponseBody
    public Map<String, Object> productSale(String product, String price, String creator, String store) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            /*1 = paid/sold   0 = unpaid   2 = paid partial 3 = fixed and ready to pick up 4 = send away */
            /* isDeleted  : 1 = deleted   0 = active */
            Ticket ticket = new Ticket("Walkin Customer",null,price,null,product,null,null,creator,"1","0",store,null);
            this.ticketService.createTicket(ticket);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }


        return resultMap;
    }


    @RequestMapping(value = "/checkOut")
    @ResponseBody
    public Map<String, Object> checkOut(String id,String username, String checkoutPrice, String paymentMethod) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> map = new HashMap<String, Object>();
        Ticket ticket = this.ticketService.getTicket(id);
        if (ticket.getAmountDue().equals(checkoutPrice)) {
            ticket.setStatus("1"); /*1 = paid/sold   0 = unpaid   2 = paid partial*/
            ticket.setAmountDue(null);

        } else if (Integer.parseInt(checkoutPrice)> Integer.parseInt(ticket.getAmountDue())){
            ticket.setStatus("1");

            if(ticket.getAmountDue().equals(ticket.getPrice())) {
                ticket.setPrice(checkoutPrice);
            }

            else{
                int new_price = Integer.parseInt(ticket.getAmountDue()) + Integer.parseInt(checkoutPrice);
                ticket.setPrice(Integer.toString(new_price));
            }
            ticket.setAmountDue(null);
        }
        else{
            ticket.setStatus("2");
            int amountDue = Integer.parseInt(ticket.getAmountDue()) - Integer.parseInt(checkoutPrice);

            ticket.setAmountDue(Integer.toString(amountDue));
        }
        try {
            ticket.setPaymentMethod(paymentMethod);
            this.ticketService.updateTicket(ticket);
            LocalDateTime time = LocalDateTime.now();
            DateTimeFormatter tf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
            String new_notes = ticket.getNotes() + "<br/>" + "Check out" + "<span style='float:right'>  by " + username + " on " +  tf.format(time) + "</span>";
            map.put("id",id);
            map.put("notes",new_notes);
            this.ticketService.updateNotes(map);
            this.ticketService.updateCheckOutTime(id);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }


        return resultMap;
    }

    @RequestMapping(value = "/deleteTicket")
    @ResponseBody
    public Map<String, Object> deleteTicket(String username, String id) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        Map<String, Object> map = new HashMap<String, Object>();

        Ticket ticket = this.ticketService.getTicket(id);
        String logger = "delete ticket";


        ticket.setIsDeleted("1");
        try {
            this.ticketService.updateTicket(ticket);
            LocalDateTime time = LocalDateTime.now();
            DateTimeFormatter tf = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
            String new_notes = ticket.getNotes() + "<br/>" +  "<span style='float:right'> Created by " + username + " on " +  tf.format(time) + "</span>";
            map.put("id",id);
            map.put("notes",new_notes);
            this.ticketService.updateNotes(map);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }
        
        return resultMap;
    }


    @RequestMapping(value = "/showSales")
    public String showSales(HttpServletRequest request, HttpServletResponse response, Model model) {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute(Constant.BACK_USER_KEY);
        if (null==username){
            return "index";
        }


        String name = request.getParameter("name");
        String store = request.getParameter("store");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        if ("".equals(name) || null == name || "".equals(store) || null == store) {
            //return to login page
            return "index";
        }
        if("".equals(startDate) || null == startDate|| "".equals(endDate) || null == endDate){
            model.addAttribute("date",new SimpleDateFormat("dd-MM-yyyy").format(new Date()));
        }
        else{
            model.addAttribute( "startDate",startDate);
            model.addAttribute( "endDate",endDate);
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", name);

        if (StringUtil.isNotEmpty(startDate) & StringUtil.isNotEmpty(endDate)) {
            map.put("startDate", startDate);
            map.put("endDate", endDate);
        }
        else{
            map.put("Date", "Date is not empty");
        }

        List<Sales> sales = this.ticketService.getSales(map);


        model.addAttribute("sales", sales);
        model.addAttribute("name", name);
        model.addAttribute("store",store);
        
        return  "totalSales";
    }

    @RequestMapping(value = "/showInvoice")
    public String showInvoice(HttpServletRequest request, HttpServletResponse response, Model model) {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute(Constant.BACK_USER_KEY);
        if (null==username){
            return "index";
        }
        String id = request.getParameter("id");
        if ("".equals(id) || null == id || "".equals(id) || null == id) {
            //return to login page
            return "index";
        }
        model.addAttribute("ticketID",id);
        return  "gst";
    }


    @RequestMapping(value = "/showCheckInForm")
    public String showCheckInForm(HttpServletRequest request, HttpServletResponse response, Model model) {

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute(Constant.BACK_USER_KEY);
        if (null==username){
            return "index";
        }


        String id = request.getParameter("id");
        if ("".equals(id) || null == id || "".equals(id) || null == id) {
            //return to login page
            return "index";
        }
        model.addAttribute("ticketID",id);
        return  "checkInForm";
    }

}




/*    @RequestMapping(value = "/deleteTicket")
    @ResponseBody
    public Map<String, Object> deleteTicket(String id) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        Ticket ticket = this.ticketService.getTicket(id);

        ticket.setIsDeleted("1");
        try {
            this.ticketService.updateTicket(ticket);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }


        return resultMap;
    }*/


