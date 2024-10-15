package com.ict.finalproject.controller;

import com.ict.finalproject.service.NoticeService;
import com.ict.finalproject.vo.NoticeVO;
import com.ict.finalproject.vo.PagingVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class NoticeController {
    @Autowired
    private NoticeService service;

    @GetMapping("/notice/fnaList")
    public String noticeFnaList(Model model) {
        List<NoticeVO> list = service.selectNoticeAll();
        model.addAttribute("list", list);
        return "notice/fnaList";
    }
}
