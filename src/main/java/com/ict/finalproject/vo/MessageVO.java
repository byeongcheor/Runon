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
    private String nickname;    //채팅 닉네임
    private int usercode;       //데이터베이스 고유식별자
    private String recipient;      //받는 사람



    // 기존 생성자
    public MessageVO(int usercode,String nickname, String recipient, String content, String add_date) {
        this.usercode = usercode;
        this.nickname = nickname;
        this.recipient = recipient;
        this.content = content;
        this.add_date = add_date;
    }
    // Getters and Setters
    public int getMessage_code() {
        return message_code;
    }

    public void setMessage_code(int message_code) {
        this.message_code = message_code;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getAdd_date() {
        return add_date; // add_date getter
    }

    public void setAdd_date(String add_date) {
        this.add_date = add_date; // add_date setter
    }

    public int getUsercode() {
        return usercode;
    }

    public void setUsercode(int usercode) {
        this.usercode = usercode;
    }

    public String getRecipient() {
        return recipient;
    }

    public void setRecipient(String recipient) {
        this.recipient = recipient;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }


}
