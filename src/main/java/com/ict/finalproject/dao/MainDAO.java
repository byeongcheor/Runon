package com.ict.finalproject.dao;

import com.ict.finalproject.vo.MarathonListVO;

import java.util.List;

public interface MainDAO {
    //랜덤으로 마라톤대회 10개 보여주기
    public List<MarathonListVO> randMarathonTen();
    //랜덤으로 마라톤대회 4개 보여주기
    public List<MarathonListVO> randMarathonList();
    //이벤트 마라톤 4개 보여주기
    public List<MarathonListVO> randEventMarathon();
}
