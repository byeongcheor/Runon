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
    public List<MemberVO> getUserInfo(int usercode) {
        return dao.getUserInfo(usercode);
    }
}
