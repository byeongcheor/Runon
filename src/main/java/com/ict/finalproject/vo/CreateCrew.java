package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateCrew {
    private int create_crew_code;
    private String crew_name;
    private int max_num;
    private String logo;
    private String content;
    private String writedate;
    private int is_updated;
    private String updated_date;
    private int is_active;
    private String activationdate;
    private int is_deleted;
    private String deleted_date;
    private String addr;
    private String addr_gu;
}
