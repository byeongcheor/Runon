package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessageVO {
    private int message_code;
    private String content;     // 메시지의 실제 내용
    private String add_date;     // 메시지가 추가된 날짜
    private int usercode;       //데이터베이스 고유식별자
    private String recipient;      //받는 사람

    // 생성자
    public MessageVO(int usercode, String recipient, String content, String add_date) {
        this.usercode = usercode;
        this.recipient = recipient;
        this.content = content;
        this.add_date = add_date;
    }
}
