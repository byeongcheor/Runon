package com.ict.finalproject.service;

import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.vo.MemberVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MemberServiceImpl implements MemberService{
    @Autowired
    private MemberDAO dao;
    @Override
    public MemberVO disableCheck(String username) {
        return dao.disableCheck(username);
    }

    @Override
    public int enableUser(String username) {
        return dao.enableUser(username);
    }


}
