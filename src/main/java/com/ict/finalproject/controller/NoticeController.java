package com.ict.finalproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class NoticeController {
    @PostMapping("/notice/openFnA")
    @ResponseBody
    public String openFnA(
            @RequestParam("usercode") int usercode,
            @RequestParam("username") String username,
            @RequestParam("token") String token
    ) {
        return null;
    }
    @GetMapping("/notice/fnaList")
    public String noticeFnaList() {
        return "notice/fnaList";
    }
}
