package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MatchingMessageVO {
    private int matching_chat_message_relation_code;  // 매칭 방과 메시지 간의 관계를 정의
    private int chat_code;                         // 채팅의 식별자
    private int message_code;
    private int matching_room_code;
}
