package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class PointChangeVO {
    private int point_change_code; // 포인트 변경 코드
    private int point_change;       // 변경된 포인트 수치
    private String point_change_date; // 포인트 변경 날짜

}
