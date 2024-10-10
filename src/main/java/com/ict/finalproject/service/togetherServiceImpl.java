package com.ict.finalproject.service;

import com.ict.finalproject.dao.togetherDAO;
import com.ict.finalproject.vo.TogetherVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class togetherServiceImpl implements togetherService {

    @Autowired
    private togetherDAO dao;


//    @Override
//    public List<TogetherVO> selectAll() {
//        return dao.selectAll();
//    }
}
