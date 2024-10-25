package com.ict.finalproject.service;

import com.ict.finalproject.dao.LoginDAO;


import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class LoginServiceImpl implements LoginService {

     @Autowired
     private LoginDAO dao;



    @Override
    public void addToken(String refreshToken,String username) {
        dao.addToken(refreshToken,username);
    }

    @Override
    public Boolean checkToken(String username) {
        return dao.checkToken(username);
    }

    @Override
    public void updateToken(String refreshToken, String username) {
        dao.updateToken(refreshToken,username);
    }

    @Override
    public void loginHistory(String username, String ip) {
        dao.loginHistory(username,ip);
    }

    @Override
    public List<MemberVO> FindIds(String name, String tel) {
        return dao.FindIds(name,tel);
    }

    @Override
    public int updatePassword(String username, String newPassword) {
        return dao.updatePassword(username,newPassword);
    }


}
