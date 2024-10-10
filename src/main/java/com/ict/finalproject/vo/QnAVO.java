package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QnAVO {
    private int qna_code;
    private String qna_subject; //
    private String qna_content; //
    private String writedate;
    private String qna_status;//0:처리중 1:처리완료
    private int type;//
    private int disclosuredtatus;
    private int is_updated;
    private String updated_date;
    private int is_deleted;
    private String deleted_date;
    private int is_active;
    private String activationdate;
    private int usercode;
    private String answer_content;
}
