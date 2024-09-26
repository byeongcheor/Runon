package com.ict.finalproject.service;

import com.ict.finalproject.dao.CrewDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CrewServiceImpl implements CrewService{
    @Autowired
    private CrewDAO dao;
}
