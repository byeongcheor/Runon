package com.ict.finalproject.service;

import com.ict.finalproject.vo.NoticeVO;
import com.ict.finalproject.vo.PagingVO;

import java.util.List;

public interface NoticeService {
    public List<NoticeVO> selectNoticeAll();
}
