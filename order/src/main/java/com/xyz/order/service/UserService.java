package com.xyz.order.service;

import com.xyz.order.dao.IUserDao;
import com.xyz.order.model.Store;
import com.xyz.order.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service(value = "userService")
public class UserService implements IUserService {

    @Autowired
    private IUserDao userDao;
    public List<User> searchUserList(Map<String,Object> map){
        List<User> users = this.userDao.searchUserList(map);
        return users;
    }

    public int checkLogin(String username , String password) {
        int result = this.userDao.checkLogin(username,password);
        return result;
    }


    public String checkRole(String username) {
        String role = this.userDao.checkRole(username);
        return role;
    }

    @Override
    public User getUser(String id) {

        return this.userDao.getUser(id);
    }

    @Override
    public void updateUser(User user) {
        this.userDao.updateUser(user);
    }

    @Override
    public void createUser(User user) {
        this.userDao.createUser(user);
    }

    @Override
    public List<Store> getStore(String username) {
        return this.userDao.getStore(username);
    }


}
