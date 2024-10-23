package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AnswerVO {
    private int answer_code;
    private String answer_content;
    private String writedate;
    private int admin_code;
    private int qna_code;

}
