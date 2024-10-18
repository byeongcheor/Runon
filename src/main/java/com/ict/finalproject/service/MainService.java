package com.ict.finalproject.service;

import com.ict.finalproject.vo.MarathonListVO;

import java.util.List;

public interface MainService {
    public List<MarathonListVO> randMarathonTen();
    public List<MarathonListVO> randMarathonList();
    public List<MarathonListVO> randEventMarathon();
}
