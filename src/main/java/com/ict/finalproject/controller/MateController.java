package com.ict.finalproject.controller;
import java.util.List;

import com.ict.finalproject.service.MateService;
import com.ict.finalproject.vo.MateVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mate")
public class MateController {

    @Autowired
    MateService service;

    @GetMapping("/mate")
    public String matchingList(HttpServletRequest request, Model model){//
        int user_code = 2;//유저코드
        List<MateVO> marathon_code_list = service.marathon_code_list(user_code);
        List<MateVO> ranking = service.ranking();
        model.addAttribute("marathon_code_list",marathon_code_list);
        model.addAttribute("ranking",ranking);
    return "mate/mate";
    }
}
