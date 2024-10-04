package com.ict.finalproject.service;

import com.ict.finalproject.dao.MypageDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MypageServiceImpl implements MypageService{
    @Autowired
    private MypageDAO dao;
}
