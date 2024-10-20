package com.ict.finalproject.service;

import com.ict.finalproject.vo.MessageVO;
import com.ict.finalproject.vo.ReportVO;

import java.util.List;

public interface ChatService {
    // 메시지 저장 메서드
    void saveMessage(MessageVO vo);

    // 방 코드로 메시지 조회 메서드
    List<MessageVO> getMessagesByMatchYn(int matchYn);

    // 신고 정보를 저장하는 메서드
    void saveReport(ReportVO reportVO);

    // 유저코드 존재 확인 메소드
    boolean isUserCodeExists(int userCode);
}
