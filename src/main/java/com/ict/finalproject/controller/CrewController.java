package com.ict.finalproject.controller;

import java.util.HashMap;
import java.util.List;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.CrewService;
import com.ict.finalproject.vo.CrewVO;
import com.ict.finalproject.vo.PagingVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.aop.scope.ScopedProxyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;

@Slf4j
@Controller
@RequestMapping("/crew")
public class CrewController {

    @Autowired
    CrewService service;
    JWTUtil jwtUtil;
    String user_name ="";
    int    user_code = 0;
    private static final String UPLOAD_DIR = "./src/main/webapp/crew_upload/";

    @PostMapping("/test")
    @ResponseBody
    public String test(@RequestParam("Authorization")String token) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        System.out.println(user_code);
        return user_name;
    }
    @GetMapping("/crewList")
    public String crewList(CrewVO cvo, PagingVO pvo, Model model){
        List<CrewVO> list = service.crewSelectPaging(pvo);
        pvo.setTotalRecord(service.totalRecord(pvo));
        model.addAttribute("list", list);
        model.addAttribute("pvo", pvo);
        return "crew/crewList";
    }

    //크루관리
    @GetMapping("/crewManage")
    public String crewCreate(){
        return "crew/crewManage";
    }

    @PostMapping("/search_crewList")
    @ResponseBody
    public List<CrewVO> search_crewList(
            @RequestParam("Authorization")String token,
            int page, String orderby, String gender , String age, String addr, String addr_gu, String searchWord, Model model) {
        token=token.substring("Bearer ".length());
        List<CrewVO> list = service.search_crewList(page, orderby, gender, age, addr, addr_gu, searchWord);
        return list;
    }
    @Value("${file.upload-dir_crew}")
    private String uploadDir;

    @PostMapping("/crew_add")
    @ResponseBody
    public int create(
            @RequestHeader(value = "Authorization", required = false) String token, // Authorization 헤더 받기
            @RequestParam("teamName") String crew_name,
            @RequestParam("teamEmblem") MultipartFile[] teamEmblem,
            @RequestParam("city") String addr,
            @RequestParam("region") String addr_gu,
            @RequestParam("age[]") String[] arr_age,
            @RequestParam("gender") String gender,
            @RequestParam("teamIntro") String content) {
        int a=0;
        String fileName = "man1.png";
        token=token.substring("Bearer ".length());
        try {
            user_name=jwtUtil.setTokengetUsername(token);
            user_code = service.usercodeSelect(user_name);
            UUID uuid = UUID.randomUUID();
            // 파일 업로드가 있는지 확인
            if (teamEmblem != null && teamEmblem.length > 0 && !teamEmblem[0].isEmpty()) {
                for (MultipartFile file : teamEmblem) {
                    fileName = StringUtils.cleanPath(file.getOriginalFilename());
                    fileName = uuid.toString() + "_" + fileName;
                    Path path = Paths.get(uploadDir + File.separator + fileName);
                    Files.copy(file.getInputStream(), path);
                }
            }
            String age = String.join(",", arr_age);
            service.crew_insert(crew_name,fileName,addr,addr_gu,gender,content,age,user_code);
        } catch (Exception e) {
            a=0;
            e.printStackTrace();
        }
        return a; // 성공적으로 생성된 경우 1 반환
    }
    @PostMapping("/crew_page")
    @ResponseBody
    public List<CrewVO> crew_page(@RequestHeader(value = "Authorization", required = false) String token) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_page = null;
        try {
            crew_page = service.crew_page_select(user_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_page;
    }
    //크루모집디테일
    @GetMapping("/crewDetail")
    public String crewDetail(int create_crew_code, Model model){
        model.addAttribute("create_crew_code", create_crew_code);
        return "crew/crewDetail";
    }

    @PostMapping("/crew_page_write_detail")
    @ResponseBody
    public List<CrewVO> crew_page_write_detail(@RequestHeader(value = "Authorization", required = false) String token, @RequestParam(value = "create_crew_code", defaultValue = "0") int createCrewCode) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_page_write_detail = null;
        try {
             crew_page_write_detail = service.crew_page_write_detail(createCrewCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_page_write_detail;
    }


}
