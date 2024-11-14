package com.ict.finalproject.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminsVO {
    private int admin_code;
    private int role;
    private int permission_add;
    private int permission_edit;
    private int permission_delete;
    private String is_deleted;
    private String deleted_date;
    private int usercode;
    private String username;
    private String created_date;
    private String name;

}
