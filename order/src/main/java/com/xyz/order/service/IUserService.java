package com.xyz.order.service;

import com.xyz.order.model.Store;
import com.xyz.order.model.User;

import java.util.List;
import java.util.Map;

public interface IUserService {
    List<User> searchUserList(Map<String,Object> map);

    int checkLogin(String username , String password);

    String checkRole(String username);

    User getUser(String id);

    void updateUser (User user);

    void createUser (User user);

    List<Store> getStore (String username);
}
