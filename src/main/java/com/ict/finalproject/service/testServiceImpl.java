package com.ict.finalproject.service;

import com.ict.finalproject.dao.testDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class testServiceImpl implements testService {

    @Autowired
    private testDAO dao;


    @Override
    public String selectAll() {
        return dao.selectAll();
    }
}
