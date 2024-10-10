package com.ict.finalproject;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

//웹소켓 환경설정
//@EnableWebSocketMessageBroker로 websocket 관련 설정이 작동된다.
//반드시 인터페이스 WebSocketMessageBrokerConfigurer를 상속받아 오버라이딩 하여야 한다.
@Configuration
@EnableWebSocketMessageBroker  //WebSocket메시지 처리를 활성화 시킨다.
public class WebSocketConfigure implements WebSocketMessageBrokerConfigurer {
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry){
        //socket.js가 연결할 주소를 정한다.
        //socket.js를 이용하여 웹소켓 통신을 할 수 있도록 설정한다.
        //접속주소 : ws://92.168.1.154:3306/chat
        registry.addEndpoint("/chat").withSockJS();
    }
    @Override
    public void configureMessageBroker(MessageBrokerRegistry config){
        //해당주소를 구독하고 있는 클라이언트에게 서버가 메시지 전달
        config.enableSimpleBroker("/topic","queue");
        //클라이언트가 서버로 보낸 메시지를 받는 prefix
        config.setApplicationDestinationPrefixes("/message");
    }
}
