package com.ict.finalproject.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;


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

            if (now.isBefore(startDate)) {
                return "접수준비중"; // 접수 시작 전 상태
            } else if (now.isAfter(endDate)) {
                return "접수마감"; // 접수 마감 상태
            } else {
                return "접수중"; // 접수 중 상태
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

    public int getMarathon_code() {
        return marathon_code;
    }

    public void setMarathon_code(int marathon_code) {
        this.marathon_code = marathon_code;
    }

    public String getMarathon_name() {
        return marathon_name;
    }

    public void setMarathon_name(String marathon_name) {
        this.marathon_name = marathon_name;
    }

    public String getMarathon_type() {
        return marathon_type;
    }

    public void setMarathon_type(String marathon_type) {
        this.marathon_type = marathon_type;
    }

    public String getTotal_distance() {
        return total_distance;
    }

    public void setTotal_distance(String total_distance) {
        this.total_distance = total_distance;
    }

    public String getEntry_fee() {
        return entry_fee;
    }

    public void setEntry_fee(String entry_fee) {
        this.entry_fee = entry_fee;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getMarathon_content() {
        return marathon_content;
    }

    public void setMarathon_content(String marathon_content) {
        this.marathon_content = marathon_content;
    }

    public String getEvent_date() {
        return event_date;
    }

    public void setEvent_date(String event_date) {
        this.event_date = event_date;
    }

    public String getRegistration_start_date() {
        return registration_start_date;
    }

    public void setRegistration_start_date(String registration_start_date) {
        this.registration_start_date = registration_start_date;
    }

    public String getRegistration_end_date() {
        return registration_end_date;
    }

    public void setRegistration_end_date(String registration_end_date) {
        this.registration_end_date = registration_end_date;
    }

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getCreated_date() {
        return created_date;
    }

    public void setCreated_date(String created_date) {
        this.created_date = created_date;
    }

    public String getLon() {
        return lon;
    }

    public void setLon(String lon) {
        this.lon = lon;
    }

    public String getIs_updated() {
        return is_updated;
    }

    public void setIs_updated(String is_updated) {
        this.is_updated = is_updated;
    }

    public String getUpdated_date() {
        return updated_date;
    }

    public void setUpdated_date(String updated_date) {
        this.updated_date = updated_date;
    }

    public String getIs_active() {
        return is_active;
    }

    public void setIs_active(String is_active) {
        this.is_active = is_active;
    }

    public String getActivation_date() {
        return activation_date;
    }

    public void setActivation_date(String activation_date) {
        this.activation_date = activation_date;
    }

    public String getIs_deleted() {
        return is_deleted;
    }

    public void setIs_deleted(String is_deleted) {
        this.is_deleted = is_deleted;
    }

    public String getDeleted_date() {
        return deleted_date;
    }

    public void setDeleted_date(String deleted_date) {
        this.deleted_date = deleted_date;
    }

    public int getAdmin_code() {
        return admin_code;
    }

    public void setAdmin_code(int admin_code) {
        this.admin_code = admin_code;
    }

    public String getPoster_img() {
        return poster_img;
    }

    public void setPoster_img(String poster_img) {
        this.poster_img = poster_img;
    }

    public int getHit() {
        return hit;
    }

    public void setHit(int hit) {
        this.hit = hit;
    }

    public int getLike_count() {
        return like_count;
    }

    public void setLike_count(int like_count) {
        this.like_count = like_count;
    }

    public void setRegistration_status(String registration_status) {
        this.registration_status = registration_status;
    }
}
