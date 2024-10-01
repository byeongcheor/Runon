package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CrewOption {
    private int option_code;
    private String option_key;
    private String option_value;
    private int is_updated;
    private String updated_date;
    private int is_active;
    private String activationdate;
    private int is_deleted;
    private String deleted_date;
    private String type;
}
