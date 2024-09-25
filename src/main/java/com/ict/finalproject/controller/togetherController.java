package com.ict.finalproject.controller;
import java.util.List;

import com.ict.finalproject.service.togetherService;
import com.ict.finalproject.vo.TogetherVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
@Controller
@RequestMapping("/together")
public class togetherController {

    @Autowired
    togetherService service;

    @GetMapping("/matching")
    public String matchingList(HttpServletRequest request, Model model){//
        List<TogetherVO> list = service.selectAll();
        model.addAttribute("list",list);
        System.out.println(list);
    return "together/matching";
    }
}
