package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MarathonCountVO {
    private int marathon_Count;
    private int event_count;
    private int unstart_count;
    private int end_count;

}
