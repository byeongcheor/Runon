package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RefundVO {
    private String reason;
    private int point_code;
    private int refund_amount;
    private int return_discount;
    private String paymentKey;
    private int usercode;
    private List<Integer> order_codes;



}
