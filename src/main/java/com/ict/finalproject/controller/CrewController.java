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
            a=service.crew_name_check(crew_name);
            if(a==1) return 1;
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
            service.crew_insert(crew_name,fileName,addr,addr_gu,gender,content,age,user_code);//크루생성
            int crew_code = service.crew_code_select(user_code);//크루코드 가져오기
            int crew_position=1;
            service.crew_member_insert(user_code,crew_code,crew_position);//크루멤버생성
        } catch (Exception e) {
            a = 0;
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
        service.update14();//14일이 지난 요청 거절로 처리
        List<CrewVO> crew_page = null;
        try {
            crew_page = service.crew_page_select(user_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_page;
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

    @PostMapping("/crew_write_add")
    @ResponseBody
    public int crew_page_write_detail(
            @RequestHeader(value = "Authorization", required = false) String token, // Authorization 헤더 받기
            @RequestParam("third_crew_code") int third_crew_code,
            @RequestParam("teamPhotoInput") MultipartFile[] teamPhotoInput,
            @RequestParam("age[]3") String[] arr_age,
            @RequestParam("gender3") String gender,
            @RequestParam("teamIntro3") String content) {
        int a=0;
        String fileName = "";
        token=token.substring("Bearer ".length());
        try {
            user_name=jwtUtil.setTokengetUsername(token);
            user_code = service.usercodeSelect(user_name);
            UUID uuid = UUID.randomUUID();
            // 파일 업로드가 있는지 확인
            if (teamPhotoInput != null && teamPhotoInput.length > 0 && !teamPhotoInput[0].isEmpty()) {
                for (MultipartFile file : teamPhotoInput) {
                    fileName = StringUtils.cleanPath(file.getOriginalFilename());
                    fileName = uuid.toString() + "_" + fileName;
                    Path path = Paths.get(uploadDir + File.separator + fileName);
                    Files.copy(file.getInputStream(), path);
                }
            }
            String age = String.join(",", arr_age);
            service.crew_write_add(third_crew_code, user_code, fileName, age, gender, content);
        } catch (Exception e) {
            a=0;
            e.printStackTrace();
        }
        return a; // 성공적으로 생성된 경우 1 반환
    }
    ////////////////////////////////////////////////////디테일/////////////////////////////////////////////
    //크루모집디테일
    @GetMapping("/crewDetail")
    public String crewDetail(int create_crew_code,int crew_write_code,  Model model){
        model.addAttribute("create_crew_code", create_crew_code);
        model.addAttribute("crew_write_code", crew_write_code);
        return "crew/crewDetail";
    }

    @PostMapping("/detail")
    @ResponseBody
    public List<CrewVO> crew_write_detail_select(@RequestParam("Authorization")String token,@RequestParam("create_crew_code") int crewCode) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_write_detail = null;
        try {
            service.crew_write_hit_update(crewCode);
            crew_write_detail=service.crew_write_detail_select(user_code,crewCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_write_detail;
    }

    @PostMapping("/join_write")
    @ResponseBody
    public int join_write(@RequestParam("Authorization")String token,@RequestParam("create_crew_code") int crewCode,String join_content) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        //가입신청 중복 확인하기
        int a=0;
        try {
            int b = service.crew_join_select(user_code,crewCode);
            System.out.println(b);
            if (b>0) return 0;
            service.crew_join_write(user_code,crewCode,join_content);
            a=1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;

    }

    @PostMapping("/join_delete")
    @ResponseBody
    public int join_delete(@RequestParam("Authorization")String token,@RequestParam("create_crew_code") int crewCode,String join_content) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        //가입신청 중복 확인하기
        int a=0;
        try {
            service.crew_join_delete(user_code,crewCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    @PostMapping("/user_check")
    @ResponseBody
    public int Joinuser_check(@RequestParam("Authorization")String token,@RequestParam("crew_write_code") int crew_write_code) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        //가입신청 중복 확인하기
        int a=0;
        try {
            a = service.join_before_select(user_code,crew_write_code);

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("가입조건 1or0-->>"+a);
        return a;

    }
    @PostMapping("/crew_write_delete")
    @ResponseBody
    public int crew_write_delete(@RequestParam("Authorization")String token,@RequestParam("crew_write_code") int crew_write_code) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        //가입신청 중복 확인하기
        int a=0;
        try {
            service.crew_write_delete(user_code,crew_write_code);
            a=1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    //수정시 작성된 크루정보띄우기
    @PostMapping("/crew_write_page_update_detail")
    @ResponseBody
    public List<CrewVO> crew_write_page_update_detail(@RequestParam("Authorization")String token,@RequestParam("create_crew_code") int create_crew_code) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_page_write_detail = null;
        try {
            crew_page_write_detail = service.crew_page_write_detail(create_crew_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_page_write_detail;
    }

    //수정시 작성된글 띄우기
    @PostMapping("/crew_write_detail_check")
    @ResponseBody
    public List<CrewVO> crew_write_detail_check(@RequestParam("Authorization")String token,@RequestParam("crew_write_code") int crew_write_code) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_write_detail_check = null;
        try {
            crew_write_detail_check = service.crew_write_detail_check(crew_write_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //System.out.println("crew_write_detail_check-->>"+crew_write_detail_check);
        return crew_write_detail_check;
    }
    //수정글 업데이트
    @PostMapping("/crew_write_update")
    @ResponseBody
    public int crew_write_update(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestParam("crew_write_code") int crew_write_code,
            @RequestParam("teamPhotoInput") MultipartFile[] teamPhotoInput,
            @RequestParam("age[]3") String[] arr_age,
            @RequestParam("gender3") String gender,
            @RequestParam("teamIntro3") String content) {
        int a=0;
        String fileName = "";
        token=token.substring("Bearer ".length());
        try {
            user_name=jwtUtil.setTokengetUsername(token);
            user_code = service.usercodeSelect(user_name);
            UUID uuid = UUID.randomUUID();
            // 파일 업로드가 있는지 확인
            if (teamPhotoInput != null && teamPhotoInput.length > 0 && !teamPhotoInput[0].isEmpty()) {
                for (MultipartFile file : teamPhotoInput) {
                    fileName = StringUtils.cleanPath(file.getOriginalFilename());
                    fileName = uuid.toString() + "_" + fileName;
                    Path path = Paths.get(uploadDir + File.separator + fileName);
                    Files.copy(file.getInputStream(), path);
                }
            }
            String age = String.join(",", arr_age);
            service.crew_write_update(crew_write_code, user_code, fileName, age, gender, content);
        } catch (Exception e) {
            a=0;
            e.printStackTrace();
        }
        return a; // 성공적으로 생성된 경우 1 반환
    }

    /////////////////////////// 크루가입신청 확인 페이지////////////////////////////////////////
    @GetMapping("/crewWait")
    public String crewWait(){
        return "crew/crewWait";
    }

    @PostMapping("/crew_wait_select")
    @ResponseBody
    public List<CrewVO> crew_wait_select(@RequestParam("Authorization")String token) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_wait_select = null;
        try {
            crew_wait_select = service.crew_wait_select(user_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_wait_select;
    }

    @PostMapping("/crew_wait_detail")
    @ResponseBody
    public List<CrewVO> crew_wait_detail(@RequestParam("Authorization")String token, @RequestParam("create_crew_code") int create_crew_code, @RequestParam(value = "usercode", defaultValue = "0") int usercode,  @RequestParam(value = "request_code", defaultValue = "0") int request_code) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_wait_detail = null;
        int user_code2=usercode==0?user_code:usercode;
        try {
            crew_wait_detail = service.crew_wait_detail(user_code2,create_crew_code,request_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_wait_detail;
    }


    /////////////////////////크루관리///////////////////////////////////////////////
    @GetMapping("/crewManage")
    public String crewCreate(){
        return "crew/crewManage";
    }

    @PostMapping("/crew_deatil_select")
    @ResponseBody
    public List<CrewVO> crew_deatil_select(@RequestParam("Authorization")String token,@RequestParam("create_crew_code") int crewCode) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_deatil_select = null;
        try {
            service.crew_write_hit_update(crewCode);
            crew_deatil_select=service.crew_write_detail_select(user_code,crewCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_deatil_select;
    }
    @PostMapping("/crew_manage_select")
    @ResponseBody
    public List<CrewVO> crew_manage_select(@RequestParam("Authorization")String token, @RequestParam("create_crew_code") int crewCode, @RequestParam("id") String id,                            @RequestParam(value = "flag", defaultValue = "") String flag) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_manage_select = null;
        try {
            if (id.equals("member")) {
                crew_manage_select = service.crew_manage_member(crewCode, user_code);
            }
            if ( id.equals("overview")) {
                crew_manage_select = service.crew_manage_overview(crewCode, user_code);
            }
            if ( id.equals("notice")) {
                crew_manage_select = service.crew_manage_notice(crewCode, user_code);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_manage_select;
    }

    /////////////////////////// 크루가입승인 페이지////////////////////////////////////////
    @GetMapping("/crewApp")
    public String crewApp(){
        return "crew/crewApp";
    }

    @PostMapping("/crew_app_select")
    @ResponseBody
    public List<CrewVO> crew_app_select(@RequestParam("Authorization")String token, @RequestParam("create_crew_code") int crewCode) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> crew_app_select = null;
        try {
            crew_app_select = service.crew_app_select(crewCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return crew_app_select;
    }
    @PostMapping("/app")
    @ResponseBody
    public int app(@RequestParam("Authorization")String token,
                   @RequestParam("create_crew_code") int crewCode,
                   @RequestParam("status") int status,
                   @RequestParam("usercode") int usercode,
                   @RequestParam("request_code") int request_code,
                   @RequestParam("reason") String reason) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        int a=0;
        try {
            if(status==1) {
                int check = service.crew_member_check(usercode, crewCode);
                if(check>0) return 9;
                service.crew_manage_app(usercode, crewCode, status, reason, request_code);
                service.crew_member_insert2(usercode, crewCode);
            }
            else service.crew_manage_app(usercode, crewCode, status, reason, request_code);
            a=1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }
    @PostMapping("/member_manage")
    @ResponseBody
    public int member_manage(@RequestParam("Authorization")String token,
                             @RequestParam("create_crew_code") int crewCode,
                             @RequestParam("id") String id,
                             @RequestParam("usercode") int  usercode,
                             @RequestParam("reason") String reason,
                             @RequestParam("reason_text") String reason_text) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        int my_user_code = service.usercodeSelect(user_name);
        int a = 0;
        try {
            if (id.equals("manage2")){
                service.crew_member_upgrade(usercode,crewCode);
                a=1;
            }
            if (id.equals("manage3")){
                service.crew_member_downgrade(usercode,crewCode);
                a=4;
            }
            if (id.equals("report")){
                service.crew_member_report(usercode,my_user_code,reason,reason_text);
                a=2;
            }
            if (id.equals("out")){
                service.crew_member_out(usercode,crewCode);
                int flag=1;
                service.crew_history_insert(usercode,crewCode,flag);
                a=3;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }


    @PostMapping("/vote_select")
    @ResponseBody
    public List<CrewVO> vote_select(@RequestParam("Authorization")String token, @RequestParam("create_crew_code") int crewCode, @RequestParam("vote_num") int vote_num) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> vote_select = null;
        try {
            vote_select = service.vote_select(user_code,vote_num);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return vote_select;
    }

    @PostMapping("/vote_insert")
    @ResponseBody
    public int vote_insert(@RequestParam("Authorization")String token, @RequestParam("selectedOption") String selectedOption, @RequestParam("vote_num") int vote_num) {
        token = token.substring("Bearer ".length());
        user_name = jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        int a = 0;
        try {
            int b = service.vote_chek(user_code, vote_num);
            if (b > 0) return 0;
            service.vote_insert(user_code, vote_num, selectedOption);
            a = 1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }

    ////////// 투표 만들기 ////////
    @PostMapping("/vote_create")
    @ResponseBody
    public int vote_create(
            @RequestParam("Authorization")String token,
            @RequestParam("create_crew_code") int crewCode,
            @RequestParam("title") String title,
            @RequestParam("endDate") String endDate,
            @RequestParam("opt1") String opt1,
            @RequestParam("opt2") String opt2,
            @RequestParam("opt3") String opt3,
            @RequestParam(value = "opt4", defaultValue = "") String opt4,
            @RequestParam(value = "opt5", defaultValue = "") String opt5) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        int a=0;
        try {
            service.vote_create(user_code, crewCode, title, endDate, opt1, opt2,opt3,opt4,opt5);
            a=1;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }


    /////////////////////////// 크루정보수정 페이지////////////////////////////////////////

    @GetMapping("/crewRevise")
    public String crewRevise(){
        return "crew/crewRevise";
    }

    //////////////////////크루 정보 불러오기//////////////////////////////////
    @PostMapping("/getCrewInfo")
    @ResponseBody
    public List<CrewVO> getCrewInfo(@RequestParam("Authorization")String token,@RequestParam("create_crew_code") int create_crew_code) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);
        List<CrewVO> getCrewInfo = null;
        try {
            getCrewInfo = service.getCrewInfo(create_crew_code);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //System.out.println("getCrewInfo-->>"+getCrewInfo);
        return getCrewInfo;
    }

    /////////////////////크루 정보 업데이트/////////////////////
    @PostMapping("/updateCrewInfo")
    @ResponseBody
    public int updateCrewInfo(
            @RequestHeader(value = "Authorization", required = false) String token,
            @RequestParam("create_crew_code") int create_crew_code,
            @RequestParam("city") String city,
            @RequestParam("teamName") String teamName,
            @RequestParam("region") String region,
            @RequestParam("teamEmblem") MultipartFile[] teamPhotoInput,
            @RequestParam("age[]") String[] arr_age,
            @RequestParam("gender") String gender,
            @RequestParam("teamIntro") String content) {

        int result = 0;
        String fileName = "";
        token = token.substring("Bearer ".length());

        try {
            // 크루명 중복 체크 (다른 크루와 이름이 중복되는지 확인)
            result = service.crew_name_double_check(teamName, create_crew_code);
            System.out.println("crew_name_double_check-->>" + result);

            // 중복된 크루명이 있으면 중복 에러 반환
            if (result > 0) {
                return 1; // 중복된 크루명 있음
            }

            // JWT에서 사용자 이름을 가져오고, 사용자 코드를 조회
            user_name = jwtUtil.setTokengetUsername(token);
            user_code = service.usercodeSelect(user_name);

            UUID uuid = UUID.randomUUID();

            // 파일 업로드가 있는 경우 처리 (해당 부분은 수정하지 않음)
            if (teamPhotoInput != null && teamPhotoInput.length > 0 && !teamPhotoInput[0].isEmpty()) {
                MultipartFile file = teamPhotoInput[0];
                fileName = uuid.toString() + "_" + StringUtils.cleanPath(file.getOriginalFilename());
                Path path = Paths.get(uploadDir + File.separator + fileName);
                Files.copy(file.getInputStream(), path);
            }
            // 나이대 배열을 하나의 문자열로 결합 (해당 부분도 수정하지 않음)
            String age = String.join(",", arr_age);

            // 크루 정보 업데이트
            result = service.updateCrewInfo(create_crew_code, user_code, teamName, fileName, age, gender, content, city, region);

            // 성공적으로 업데이트된 경우
            if (result > 0) {
                return 0; // 성공
            } else {
                return -1; // 실패 (업데이트되지 않음)
            }
        } catch (Exception e) {
            e.printStackTrace();
            return -1; // 에러 발생 시 -1 반환
        }
    }
}

