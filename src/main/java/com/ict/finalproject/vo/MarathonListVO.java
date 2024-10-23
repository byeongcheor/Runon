package com.ict.finalproject.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

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
    private int hit;
    private int like_count;


    // 접수 상태를 저장할 필드 추가
    private String registration_status;

    public String getRegistration_status() {
        if (registration_start_date == null || registration_end_date == null) {
            return "날짜 없음";  // 필요한 경우 더 적절한 기본 메시지로 변경 가능
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        try {
            LocalDateTime startDate = LocalDateTime.parse(registration_start_date, formatter);
            LocalDateTime endDate = LocalDateTime.parse(registration_end_date, formatter);
            LocalDateTime now = LocalDateTime.now();

            if (now.isAfter(startDate) && now.isBefore(endDate)) {
                return "접수중";
            } else {
                return "접수마감";
            }
        } catch (DateTimeParseException e) {
            e.printStackTrace();  // 로그에 에러 출력
            return "날짜 오류";
        }
    }

    // 대표 지역 추출 메서드
    public String getMainLocation() {
        if (addr == null || addr.isEmpty()) {
            return "지역 미상";
        }

        // 대표적인 지역명 목록
        String[] locations = {"서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", "경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"};

        // 주소에서 대표 지역명을 찾음
        for (String location : locations) {
            if (addr.contains(location)) {
                return location;
            }
        }

        return "기타"; // 해당하는 지역명이 없을 경우 "기타"로 표시
    }





}
