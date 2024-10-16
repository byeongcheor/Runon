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
    private String offender_nickname;
    private String report_reason;
    private String report_date;
    private int victim_code;
    private String victim_nickname;
    private String crew_history_code;
    private String matching_room_code;
    private String report_status;

}
