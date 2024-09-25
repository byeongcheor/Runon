package com.ict.finalproject.service;

import com.ict.finalproject.dao.testDAO;
import com.ict.finalproject.dao.togetherDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class togetherServiceImpl implements testService {

    @Autowired
    private togetherDAO dao;


    @Override
    public String selectAll() {
        return dao.selectAll();
    }
}
