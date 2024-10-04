package com.ict.finalproject.controller;

import com.ict.finalproject.service.CrewService;
import com.ict.finalproject.vo.CreateCrew;
import com.ict.finalproject.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Slf4j
@Controller
public class CrewController {
    @Autowired
    CrewService service;
    //크루모집페이지폼이동
    @GetMapping("crew/crewList")
    public String crewList(CreateCrew cvo, PagingVO pvo, Model model){
        List<CreateCrew> list = service.crewSelectPaging(pvo);
        pvo.setTotalRecord(service.totalRecord(pvo));
        model.addAttribute("list", list);
        model.addAttribute("pvo", pvo);
        return "crew/crewList";
    }
    //크루생성페이지폼
    @GetMapping("crew/crewCreate")
    public ModelAndView crewCreate(){
        ModelAndView mav = new ModelAndView();
        mav.setViewName("crew/crewCreate");
        return mav;
    }
    //크루관리페이지폼 (크루생성시 매핑코드 끌고와서 매핑 다시하기)
    @GetMapping("crew/crewManage")
    public String crewManage(){
        return "crew/crewManage";
    }
}
