package com.ict.finalproject.service;


import com.ict.finalproject.dao.PointDAO;
import com.ict.finalproject.vo.PointChangeVO;
import com.ict.finalproject.vo.PointVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class PointServiceImpl implements PointService{
    @Autowired
    private PointDAO dao;


    @Override
    public PointVO getPointByUsercode(int usercode) {
        return dao.getPointByUsercode(usercode);
    }


}

