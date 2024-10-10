package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CartVO {
    private int cart_code;
    private int quantity;
    private int price;
    private String added_date;
    private int is_updated;
    private String updated_date;
    private int is_deleted;
    private String deleted_date;
    private String cart_expiration_date;
    private int marathon_code;
    private int usercode;


}
