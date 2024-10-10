package com.ict.finalproject.service;

import com.ict.finalproject.vo.MessageVO;

import java.util.List;

public interface ChatService {
    void sendMessage(MessageVO message);  // 메시지 전송
    List<MessageVO> getChatHistory(String recipient);  // 채팅 기록 가져오기
}
