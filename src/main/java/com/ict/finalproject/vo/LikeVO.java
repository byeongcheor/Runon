package com.ict.finalproject.vo;

import lombok.Data;

@Data
public class LikeVO {
    private int like_id;          // 좋아요 ID
    private int usercode;        // 사용자 코드
    private int marathon_code;    // 마라톤 코드
    private String created_at;  // 생성 시간
}
