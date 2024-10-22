package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CertificateVO {
    private int certificate_code;
    private String proof_photo;
    private String content;
    private String application_date;
    private int is_updated;
    private String updated_date;
    private String result_status;
    private String result_date;
    private String username;
    private int order_code;
    private String nickname;
    private int crew_member_code;

}
