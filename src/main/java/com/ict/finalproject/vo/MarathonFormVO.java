package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MarathonFormVO {
    private int marathon_form_code; // 마라톤 신청서 코드 (Primary Key)
    private String name; // 이름
    private String tel; // 전화번호
    private String addr; // 주소
    private String addr_details; // 상세 주소
    private String gender; // 성별
    private String birth_date; // 생년월일
    private int is_recorded; // 기록 여부
    private String size; // 사이즈
    private int terms_agreement; // 이용약관 동의
    private int privacy_consent; // 개인정보 수집 동의
    private int media_consent; // 미디어 사용 동의
    private String created_date; // 생성일
    private int is_updated; // 수정 여부
    private String updated_date; // 수정일
    private int is_deleted; // 삭제 여부
    private int deleted_date; // 삭제일
    private int usercode; // 사용자 코드
    private int run_option;
    private List<Integer> crew_member_code;

}
