package com.ict.finalproject.service;

import com.ict.finalproject.dao.LoginDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginServiceImpl implements LoginService {
    @Autowired
    LoginDAO dao;

    @Override
    public void addToken(String refreshToken,String username) {
        dao.addToken(refreshToken,username);
    }
}
