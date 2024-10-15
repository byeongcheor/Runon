package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RecordVO {
    private int record_code;
    private int category;
    private int score_change;
    private String changedate;
    private int now_score;
    private String grade;
    private int usercode;
    private int create_crew_code;
}
