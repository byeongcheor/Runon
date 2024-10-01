package com.ict.finalproject.vo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class MateVO {
    private String profile_img;
    private String email;
    private String addr_details;
    private String nickname;
    private String password ;
    private String username;
    private String is_mate;
    private String is_pacemaker;
    private String is_info_disclosure;
    private String gender;
    private String tel;
    private String addr;
    private String marathon_code;
    private String marathon_name;
    private String crew_name;
    private String tbuf_s;
    private String buff_s;
    private String a_s;
    private String b_s;
    private String c_s;

    private int tbuf_n;
    private int buff_n;
    private int a_n;
    private int b_n;
    private int c_n;
    private int all_km;
    private int is_active;
    private int is_disabled;
    private int is_updated;
    private int is_deleted;
    private int is_google;
    private int point_code;
    private int usercode;
    private int role;
    private int ranking;
    private int more=10;
    private int accept_cnt;
    private int update_cnt;
    private int match_yn;

    private String birthdate;
    private String updated_date;
    private String deleted_date;
    private String creation_date;
    private String disabled_date;
    private String activation_date;


}
