package com.ict.finalproject.service;

import com.ict.finalproject.vo.MessageVO;

import java.util.List;

public interface ChatService {
    // 메시지 저장 메서드
    void saveMessage(MessageVO vo);

    // 방 코드로 메시지 조회 메서드
    List<MessageVO> getMessagesByMatchYn(int matchYn);
}
