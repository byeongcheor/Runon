package com.ict.finalproject.controller;

import com.ict.finalproject.service.MainService;
import com.ict.finalproject.vo.MarathonListVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {
    @Autowired
    MainService service;

    @GetMapping("/home")
    @ResponseBody
    public String mainP(){

        return "Main Controller";
    }
    //배너에서 랜덤으로 마라톤뽑기
    @GetMapping("/bannerMarathon")
    @ResponseBody
    public Map<String, Object> bannerMarathon(){
        List<MarathonListVO> list = service.randMarathonTen();
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        return result;
    }
    //첫번째에서 랜덤으로 마라톤뽑기
    @GetMapping("/randMarathon")
    @ResponseBody
    public Map<String, Object> randMarathon(){
        List<MarathonListVO> list = service.randMarathonList();
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        return result;
    }
    //이벤트마라톤 4개뽑기
    @GetMapping("/eventMarathon")
    @ResponseBody
    public Map<String, Object> eventMarathon(){
        List<MarathonListVO> list = service.randEventMarathon();
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        return result;
    }

}
