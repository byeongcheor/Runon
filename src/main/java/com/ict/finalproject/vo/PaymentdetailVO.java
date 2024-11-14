package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentdetailVO {
    private String orderId;
    private int total_amount;
    private int payment_code;
    private int order_code;
    private Date created_date;
    private int is_deleted;
    private Date deleted_date;
    private List<Integer> cart_codes;
}
