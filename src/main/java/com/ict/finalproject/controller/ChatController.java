package com.ict.finalproject.controller;

import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.ChatService;
import com.ict.finalproject.service.MateService;
import com.ict.finalproject.vo.MessageVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;


@Slf4j
@Controller
public class ChatController {

    @Autowired
    ChatService chatservice;
    private int messageCodeCounter = 1; // 메시지 코드를 관리하는 카운터

    @GetMapping("/message/mate")
    public String mateChat(){

        return "mate/mate";
    }

    //클라이언트가 서버에 접속하고 메시지를 보내면 받는곳
    @MessageMapping("/chat")
    @SendTo("/topic/messages") // 모든 클라이언트에게 메시지 보내기
    public MessageVO send(MessageVO vo){
        try {
        System.out.println(vo.toString());

        // 메시지 내용이 비어있지 않은지 확인
        if (vo.getContent() == null || vo.getContent().isEmpty()) {
            throw new IllegalArgumentException("Message content cannot be empty.");
        }

        // 메시지에 서버에서 받은 시간을 추가
        String add_date = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());

        vo.setMessage_code(messageCodeCounter++); // 현재 값을 설정하고 증가시킴
        // 메시지를 모든 클라이언트에게 반환
        return new MessageVO(vo.getUsercode(), vo.getRecipient(), vo.getContent(), add_date);
    } catch (Exception e) {
        System.err.println("Error while sending message: " + e.getMessage());
        // 예외 처리 로직 추가 가능
        return null; // 필요에 따라 null 반환 또는 다른 처리를 추가
    }

    }



//
//    // 메시지 전송
//    @MessageMapping("/message/chat")
//    @SendTo("/topic/messages")
//    public MessageVO handleMessage(MessageVO message) {
//        chatService.sendMessage(message);  // DB에 메시지 저장
//        return message;  // 메시지를 다시 클라이언트로 전송
//    }
//
//    // 이전 채팅 기록 가져오기
//    @GetMapping("/history")
//    public List<MessageVO> getChatHistory(@RequestParam String recipient) {
//        return chatService.getChatHistory(recipient);  // DB에서 채팅 기록 조회
//    }



}
