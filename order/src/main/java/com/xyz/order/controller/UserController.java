package com.xyz.order.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.github.pagehelper.util.StringUtil;
import com.xyz.order.model.Constant;
import com.xyz.order.model.Store;
import com.xyz.order.model.User;
import com.xyz.order.service.IUserService;
import com.xyz.order.service.TicketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UserController {


    @Autowired
    private IUserService UserService;

    @Autowired
    private TicketService ticketService;

    @RequestMapping(value = "/index")
    public String index(HttpServletRequest request) {

        request.getSession().removeAttribute(Constant.BACK_USER_KEY);

        return "index";
    }

    @RequestMapping(value = "/login")
    @ResponseBody
    public Map<String, Object> login(HttpServletRequest request, @RequestParam("username")String username, @RequestParam("password")String password) {
        int result = 0;
        String store = null;
        Map<String, Object> resultMap = new HashMap<String, Object>();
        /*String enPassword = password; //User.encode(password);  //md5 encrpyt!*/
        try {
            result = this.UserService.checkLogin(username, password);
        } catch (Exception e) {

            resultMap.put("result", "error !!!! login check failure");
        }

        if (result == 1) {
            resultMap.put("result", "success");
            resultMap.put("username", username);
            try {
                List<Store> stores = this.UserService.getStore(username);
                List<String> storelist = new ArrayList<String>();
                for (Store s : stores) {
                    storelist.add(s.getStore());
                }
                resultMap.put("stores", storelist);

            } catch (Exception e) {

                resultMap.put("stores", "error !!!!can not get stores");
            }
            HttpSession session = request.getSession();
            session.setAttribute(Constant.BACK_USER_KEY,username);
/*            session.setMaxInactiveInterval(20*60);*/
        } else {
            resultMap.put("result", "fail");
        }
        return resultMap;
    }

    @RequestMapping(value = "/showUsers")
    public String showUsers(HttpServletRequest request, HttpServletResponse response, Model model) {

        HttpSession session = request.getSession();
        String loginname = (String) session.getAttribute(Constant.BACK_USER_KEY);
        if (null==loginname){
            return "index";
        }



        String username = request.getParameter("search_username");
        String name = request.getParameter("name");
        String store = request.getParameter("store");
        String company = request.getParameter("search_company");
        String pno = request.getParameter("pageNum");

        Map<String, Object> map = new HashMap<String, Object>();

        if ("".equals(name) || null == name || "".equals(store) || null == store) {
            return "index";
        }


        if (StringUtil.isNotEmpty(username)) {
            map.put("name", username);
        }
        if (StringUtil.isNotEmpty(company)) {
            map.put("company", company);
        }

        /*处理pagenumber null*/
        int pageNum = 1;   
        int pageSize = 10;  

        try {
            pageNum = Integer.parseInt(pno);
        } catch (Exception e) {

        }
        if (pageNum < 1) {
            pageNum = 1;
        }
        PageHelper.startPage(pageNum, pageSize);
        List<User> users = this.UserService.searchUserList(map);
        PageInfo pageInfo = new PageInfo(users);
        List<User> userlist = pageInfo.getList();
        model.addAttribute("userlist", userlist);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("name", name);
        model.addAttribute("store",store);

        return "user";
    }


    @RequestMapping(value = "/getUser")
    @ResponseBody
    public Map<String, Object> getUser(String id) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            User user = this.UserService.getUser(id);
            resultMap.put("id", user.getId());
            resultMap.put("name", user.getName());
            resultMap.put("password", user.getPassword());
            resultMap.put("role", user.getRole());
            resultMap.put("company", user.getCompany());
        } catch (Exception e) {
            resultMap.put("error", "Get User failed, please contact your technician");
        }

        return resultMap;
    }


    @RequestMapping(value = "/createUser")
    @ResponseBody
    public Map<String, Object> createUser(String username, String password) {

        User user = new User(username, password, "user", "0");
        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {

            System.out.println(user);
            this.UserService.createUser(user);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }


        return resultMap;
    }


    @RequestMapping(value = "/updateUser")
    @ResponseBody
    public Map<String, Object> updateUser(String id, String name, String password) {

        User user = this.UserService.getUser(id);

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            user.setName(name);
            user.setPassword(password);
            this.UserService.updateUser(user);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "Update User failed, please contact your technician");
        }


        return resultMap;
    }

    @RequestMapping(value = "/checkStore")
    @ResponseBody
    public Map<String, Object> checkStore(String name) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        try {
            List<Store> stores = this.UserService.getStore(name);
            List<String> storelist = new ArrayList<String>();
            for (Store s : stores) {
                storelist.add(s.getStore());
            }
            resultMap.put("stores", storelist);
        } catch (Exception e) {
            resultMap.put("error", "Get Store failed, please contact your technician");
        }
        return resultMap;
    }

    @RequestMapping(value = "/deleteUser")
    @ResponseBody
    public Map<String, Object> deleteUser(String id) {

        Map<String, Object> resultMap = new HashMap<String, Object>();
        User user = this.UserService.getUser(id);

        user.setIsDeleted("1");
        try {
            this.UserService.updateUser(user);
            resultMap.put("success", "success");
        } catch (Exception e) {
            resultMap.put("error", "create ticket failed, please contact your technician");
        }


        return resultMap;
    }

}
