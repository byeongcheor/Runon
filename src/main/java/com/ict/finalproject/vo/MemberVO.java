package com.ict.finalproject.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Service;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
    private int id;

    private String username;
    private String password;
    private String role;
}
