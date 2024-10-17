package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminPaymentVO {
    private int order_code; //check
    private String marathon_name;
    private int price;
    private int quantity;
    private int real_amount;
    private String completed_date;//check
    private String nickname;


}
