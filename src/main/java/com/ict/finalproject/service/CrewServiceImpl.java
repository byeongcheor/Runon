package com.ict.finalproject.service;

import com.ict.finalproject.dao.CrewDAO;
import com.ict.finalproject.vo.CreateCrew;
import com.ict.finalproject.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CrewServiceImpl implements CrewService{
    @Autowired
    private CrewDAO dao;


    @Override
    public List<CreateCrew> crewSelectPaging(PagingVO pvo) {
        return dao.crewSelectPaging(pvo);
    }

    @Override
    public int totalRecord(PagingVO pvo) {
        return dao.totalRecord(pvo);
    }
}
