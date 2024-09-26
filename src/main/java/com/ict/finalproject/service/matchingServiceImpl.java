package com.ict.finalproject.service;

import com.ict.finalproject.dao.togetherDAO;
import com.ict.finalproject.vo.MatchingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class matchingServiceImpl implements matchingService {

    @Autowired
    private togetherDAO dao;


    @Override
    public List<MatchingVO> selectAll() {
        return dao.selectAll();
    }
}
