package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentVO {

    private int usercode;
    private int total_amount;
    private int discount_amount;
    private int real_amount;
    private String orderId;
    private String nickname;
    private String payment_method;
    private String completed_date;
    private String latest_marathon_name;
    private int marathon_count;
    private String created_date;
    private int payment_status;
    private int is_completed;
}
