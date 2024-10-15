package com.ict.finalproject.dao;

import com.ict.finalproject.vo.NoticeVO;
import com.ict.finalproject.vo.PagingVO;

import java.util.List;

public interface NoticeDAO {
    public List<NoticeVO> selectNoticeAll();
}
