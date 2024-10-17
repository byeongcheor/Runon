package com.ict.finalproject.service;

import com.ict.finalproject.dao.MainDAO;
import com.ict.finalproject.vo.MarathonListVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MainServiceImpl implements MainService {
    @Autowired
    private MainDAO dao;

    @Override
    public List<MarathonListVO> randMarathonTen() {
        return dao.randMarathonTen();
    }

    @Override
    public List<MarathonListVO> randMarathonList() {
        return dao.randMarathonList();
    }

    @Override
    public List<MarathonListVO> randEventMarathon() {
        return dao.randEventMarathon();
    }
}
