package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NoticeVO {
    private int bbs_code;
    private String subject;
    private String content;
    private String writedate;
    private int priority;
    private int is_updated;
    private String updated_date;
    private int is_deleted;
    private String deleted_date;
    private int is_active;
    private String activationdate;
    private int admin_code;
}
