package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemCountVO {
    private int allCount;
    private int MCount;
    private String Mgender="남";
    private int WCount;
    private String Wgender="여";
}
