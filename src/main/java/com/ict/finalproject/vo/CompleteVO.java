package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Data
@AllArgsConstructor
@ResponseBody
public class CompleteVO {
    private int payment_detail_id;
    private String orderId;
    private int amount;
    private int total_amount;
    private int discount_amount;
    private int real_amount;
    private String marathon_name;
    private int status;
    private Date create_time;

}
