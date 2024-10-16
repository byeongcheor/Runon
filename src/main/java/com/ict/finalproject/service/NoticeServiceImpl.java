package com.ict.finalproject.service;

import com.ict.finalproject.dao.NoticeDAO;
import com.ict.finalproject.vo.NoticeVO;
import com.ict.finalproject.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService{
    @Autowired
    NoticeDAO dao;

    @Override
    public List<NoticeVO> selectNoticeAll() {
        return dao.selectNoticeAll();
    }
}
