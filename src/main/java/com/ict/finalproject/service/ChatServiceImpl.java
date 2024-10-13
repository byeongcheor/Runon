package com.ict.finalproject.service;

import com.ict.finalproject.dao.ChatDAO;
import com.ict.finalproject.vo.MessageVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.beans.Transient;
import java.util.List;

@Slf4j
@Service
@Transactional
public class ChatServiceImpl implements ChatService{
    @Autowired
    private ChatDAO dao;

    // 메시지 저장 구현
    @Transactional
    public void saveMessage(MessageVO vo) {

        dao.insertMessage(vo); // 메시지 저장 Mapper 호출
    }

    // 매칭 방 코드에 따른 메시지 불러오기
    @Override
    public List<MessageVO> getMessagesByMatchYn(int matchYn) {
        // 매퍼에서 DB로부터 메시지를 가져옴
        return dao.selectMessagesByRoomCode(matchYn);
    }
}
