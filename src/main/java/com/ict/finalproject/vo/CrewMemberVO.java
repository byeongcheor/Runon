package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CrewMemberVO {
    private int crew_member_code;
    private int usercode;
    private int create_crew_code;
    private String crew_name;
}
