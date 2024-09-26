package com.ict.finalproject.controller;
import java.util.List;

import com.ict.finalproject.service.matchingService;
import com.ict.finalproject.vo.MatchingVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/matching")
public class matchingController {

    @Autowired
    matchingService service;

    @GetMapping("/matching")
    public String matchingList(HttpServletRequest request, Model model){//
        List<MatchingVO> list = service.selectAll();
        model.addAttribute("list",list);
        System.out.println(list);
    return "matching/matching";
    }
}
