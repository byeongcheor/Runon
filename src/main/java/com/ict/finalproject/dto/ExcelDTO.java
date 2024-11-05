package com.ict.finalproject.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ExcelDTO {
    private String marathon_name;
    private String marathon_type;
    private String total_distance;
    private String entry_fee;
    private String addr;
    private String marathon_content;
    private String event_date;
    private String registration_start_date;
    private String registration_end_date;
    private String lat;
    private String lon;
    private String poster_img;

}
