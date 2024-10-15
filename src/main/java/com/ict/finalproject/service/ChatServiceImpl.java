package com.ict.finalproject.service;

import com.ict.finalproject.dao.ChatDAO;
import com.ict.finalproject.vo.MessageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ChatServiceImpl implements ChatService{
    @Autowired
    private ChatDAO dao;

    @Override
    public void sendMessage(MessageVO message) {
        dao.sendMessage(message);
    }

    @Override
    public List<MessageVO> getChatHistory(String recipient) {
        return dao.getChatHistory(recipient);
    }
}
