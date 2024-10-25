package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportVO {
    private int report_code;
    private int offender_code;
    private String offender_nickname;
    private String report_reason;
    private String report_date;
    private int victim_code;
    private String victim_nickname;
    private String crew_history_code;
    private int matching_room_code;
    private int report_status;
    private String report_content;
    private String proof_img;
    private int report_count;
    private String content;
    private String report_result;
    private int admin_code;
    private int is_disabled;
}
