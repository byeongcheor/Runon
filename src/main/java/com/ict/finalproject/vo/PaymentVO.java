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
}
