package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReportVO {
    private int report_code;
    private int offender_code;
    private String report_reason;
    private String report_date;
    private int victim_code;
    private int crew_history_code;
    private int matching_room_code;
    private int report_status;
    private String report_content;
}
