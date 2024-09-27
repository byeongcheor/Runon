package com.ict.finalproject.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Service;

import java.security.PrivateKey;


public class MemberVO {
    private int usercode;
    private String username;
    private String password;
    private String role;
    private String email;
    private String name;
    private String addr;
    private String addr_details;
    private String zip_code;
    private String birthdate;
    private String gender;
    private String tel;
    private String tel1;
    private String tel2;
    private String tel3;
    private String is_pacemaker;
    private String is_mate;
    private String profile_img;
    private String is_info_disclosure;
    private String is_google;
    private String creation_date;
    private String is_updated;
    private String updated_date;
    private String is_deleted;
    private String deleted_date;
    private String is_disabled;
    private String disabled_date;
    private String is_active;
    private String activation_date;
    private int point_code;
    private String nickname;

    @Override
    public String toString() {
        return "MemberVO{" +
                "usercode=" + usercode +
                ", username='" + username + '\'' +
                ", password='" + password + '\'' +
                ", role='" + role + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", addr='" + addr + '\'' +
                ", addr_details='" + addr_details + '\'' +
                ", zip_code='" + zip_code + '\'' +
                ", birthdate='" + birthdate + '\'' +
                ", gender='" + gender + '\'' +
                ", tel='" + tel + '\'' +
                ", is_pacemaker='" + is_pacemaker + '\'' +
                ", is_mate='" + is_mate + '\'' +
                ", profile_img='" + profile_img + '\'' +
                ", is_info_disclosure='" + is_info_disclosure + '\'' +
                ", is_google='" + is_google + '\'' +
                ", creation_date='" + creation_date + '\'' +
                ", is_updated='" + is_updated + '\'' +
                ", updated_date='" + updated_date + '\'' +
                ", is_deleted='" + is_deleted + '\'' +
                ", deleted_date='" + deleted_date + '\'' +
                ", is_disabled='" + is_disabled + '\'' +
                ", disabled_date='" + disabled_date + '\'' +
                ", is_active='" + is_active + '\'' +
                ", activation_date='" + activation_date + '\'' +
                ", point_code=" + point_code +
                ", nickname='" + nickname + '\'' +
                '}';
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getUsercode() {
        return usercode;
    }

    public void setUsercode(int usercode) {
        this.usercode = usercode;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }

    public String getAddr_details() {
        return addr_details;
    }

    public void setAddr_details(String addr_details) {
        this.addr_details = addr_details;
    }

    public String getZip_code() {
        return zip_code;
    }

    public void setZip_code(String zip_code) {
        this.zip_code = zip_code;
    }

    public String getBirthdate() {
        return birthdate;
    }

    public void setBirthdate(String birthdate) {
        this.birthdate = birthdate;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getTel() {
        if (tel1!=null && tel2!=null && tel3!=null) {
        tel = tel1+"-"+tel2+"-"+tel3;
        return tel;
        }
        else{tel=null;
            return tel;
        }
    }

    public void setTel(String tel) {
        this.tel = tel;
        String arr[] = this.tel.split("-");
        if (arr.length == 3) {
            tel1 = arr[0];
            tel2 = arr[1];
            tel3 = arr[2];
        }
    }

    public String getTel1() {
        return tel1;
    }

    public void setTel1(String tel1) {
        this.tel1 = tel1;
    }

    public String getTel2() {
        return tel2;
    }

    public void setTel2(String tel2) {
        this.tel2 = tel2;
    }

    public String getTel3() {
        return tel3;
    }

    public void setTel3(String tel3) {
        this.tel3 = tel3;
    }

    public String getIs_pacemaker() {
        return is_pacemaker;
    }

    public void setIs_pacemaker(String is_pacemaker) {
        this.is_pacemaker = is_pacemaker;
    }

    public String getIs_mate() {
        return is_mate;
    }

    public void setIs_mate(String is_mate) {
        this.is_mate = is_mate;
    }

    public String getProfile_img() {
        return profile_img;
    }

    public void setProfile_img(String profile_img) {
        this.profile_img = profile_img;
    }

    public String getIs_info_disclosure() {
        return is_info_disclosure;
    }

    public void setIs_info_disclosure(String is_info_disclosure) {
        this.is_info_disclosure = is_info_disclosure;
    }

    public String getIs_google() {
        return is_google;
    }

    public void setIs_google(String is_google) {
        this.is_google = is_google;
    }

    public String getCreation_date() {
        return creation_date;
    }

    public void setCreation_date(String creation_date) {
        this.creation_date = creation_date;
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

    public String getIs_disabled() {
        return is_disabled;
    }

    public void setIs_disabled(String is_disabled) {
        this.is_disabled = is_disabled;
    }

    public String getDisabled_date() {
        return disabled_date;
    }

    public void setDisabled_date(String disabled_date) {
        this.disabled_date = disabled_date;
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

    public int getPoint_code() {
        return point_code;
    }

    public void setPoint_code(int point_code) {
        this.point_code = point_code;
    }
}
