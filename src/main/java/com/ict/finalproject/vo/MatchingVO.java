package com.ict.finalproject.vo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class MatchingVO {
    private String profile_img;
    private String email;
    private String addr_details;
    private String nickname;
    private String userpwd;
    private String userid;
    private String is_mate;
    private String is_pacemaker;
    private String is_info_disclosure;
    private String gender;
    private String tel;
    private String addr;

    private int is_active;
    private int is_disabled;
    private int is_updated;
    private int is_deleted;
    private int is_google;
    private int age;
    private int point_code;
    private int usercode;
    private int u_category;

    private String updated_date;
    private String deleted_date;
    private String creation_date;
    private String disabled_date;
    private String activation_date;

}
