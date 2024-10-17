package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderVO {
    private int order_code;
    private int total_amount;
    private int real_amount;
    private String order_status;
    private String created_date;
    private String payment_method;
    private int payment_status;
    private int quantity;
    private int price;
    private int cart_code;
    private int reservation_code;
    private int discount_amount;
    private String marathon_name;

    private String marathon_name;

}
