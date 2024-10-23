package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportReplyVO {

    private String content;
    private String report_result;
    private Date process_date;
    private int admin_code;
    private String admin_nickname;
}
