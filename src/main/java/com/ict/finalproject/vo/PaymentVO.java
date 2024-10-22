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
    private String created_date;
    private int payment_status;
    private String payment_method;
    private String orderId;
    private int is_completed;
}
