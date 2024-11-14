package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class HospitalVO {
    private int hospital_code;
    private String name;
    private String addr;
    private String addr_detail;
    private Double latitude;
    private Double longitude;
    private Double distance;
}
