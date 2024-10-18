package com.ict.finalproject.service;

import com.ict.finalproject.vo.PointChangeVO;
import com.ict.finalproject.vo.PointVO;

public interface PointService {
    PointVO getPointByUsercode(int usercode); // usercode로 포인트 정보 조회

}

