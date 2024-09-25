package com.ict.finalproject.controller;

import com.ict.finalproject.service.togetherService;
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
    togetherService togetherservice;

    @GetMapping("/matching")
    public String matchingList(HttpServletRequest request, Model model){//페이징추가

    return "together/matching";
    }
}
