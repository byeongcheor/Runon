package com.ict.finalproject.dao;

import com.ict.finalproject.vo.PointChangeVO;
import com.ict.finalproject.vo.PointVO;

public interface PointDAO {
    PointVO getUserPointsByUsername(String username); // 사용자의 포인트 조회 메서드 정의
    void applyPointsByUsername(String username, int pointsToUse); // 포인트 적용 메서드 정의
    void insertPointChangeHistory(PointChangeVO pointChange); // 포인트 변화 기록 추가 메서드 정의
}
