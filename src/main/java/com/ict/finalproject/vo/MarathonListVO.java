package com.ict.finalproject.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MarathonListVO {
    private int marathon_code;            // 마라톤 코드 (Primary Key)
    private String marathon_name;         // 마라톤 이름
    private String marathon_type;         // 마라톤 유형
    private String total_distance;        // 총 거리
    private String entry_fee;             // 참가비
    private String addr;                 // 주소
    private String marathon_content;      // 마라톤 설명
    private String event_date;            // 이벤트 날짜
    private String registration_start_date;// 등록 시작 날짜
    private String registration_end_date;  // 등록 종료 날짜
    private String tags;                 // 태그
    private String created_date;          // 생성 날짜
    private String lat;                  // 위도
    private String lon;                  // 경도
    private String is_updated;            // 업데이트 여부
    private String updated_date;          // 업데이트 날짜
    private String is_active;             // 활성화 여부
    private String activation_date;       // 활성화 날짜
    private String is_deleted;            // 삭제 여부
    private String deleted_date;          // 삭제 날짜
    private int admin_code;               // 관리자 코드 (외래 키)
    private String poster_img;            // 포스터 이미지

}
