package com.ict.finalproject.controller;


import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.service.MypageService;

import com.ict.finalproject.vo.CertificateVO;
import com.ict.finalproject.vo.MarathonFormVO;
import com.ict.finalproject.vo.MemberVO;
import com.ict.finalproject.vo.PagingVO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.Value;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


@Slf4j
@Controller
public class MypageController {
    @Autowired
    MypageService service;
    @Autowired
    MemberService memberservice;
    @Autowired
    JWTUtil jwtUtil;
    @Autowired
    private MemberDAO memberDAO;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    //유저정보보여주기(마이페이지홈, 회원정보수정)
    @PostMapping("mypage/myHome")
    @ResponseBody
    public MemberVO myHomegetToken(@RequestParam("Authorization")String token, Model model) {
        token=token.substring("Bearer ".length());
        String username=jwtUtil.setTokengetUsername(token);
        MemberVO member = service.selectMember(username);
        String imgname = service.getProfileImg(username);
        String defaultImg = "/basicsimg.png";
        if(username != null){
            model.addAttribute("userimg", imgname != null ? imgname : defaultImg);
        }
        log.info("member:"+member);
        return member;
    }

    //프로필업데이트
    @PostMapping("/mypage/updateProfile")
    @ResponseBody
    public ResponseEntity<Map<String, String>> updateProfile(
            @RequestParam("profile_img") MultipartFile file,
            @RequestHeader("Authorization") String token,
            Model model, HttpSession session, HttpServletRequest request) {

        log.info("파일 업로드 요청수신");
        String UPLOAD_DIR = session.getServletContext().getRealPath("/resources/uploadfile/");
        log.info(UPLOAD_DIR);
        String webPath = request.getContextPath()+ "/resources/uploadfile/";
        log.info("webPath:"+webPath);
        if (file.isEmpty()) {
            log.warn("업로드된 파일이 비어있음");
            Map<String, String> response = new HashMap<String, String>();
            response.put("error", "파일이 비어있습니다.");
            return ResponseEntity.badRequest().body(response);
        }
        try{
            String fileName = file.getOriginalFilename();
            File targetFile = new File(UPLOAD_DIR+fileName);
            log.info("파일저장경로: {}", targetFile.getAbsolutePath());
            file.transferTo(targetFile);
            log.info("파일저장성공: {}", fileName);

            token=token.substring("Bearer ".length());
            String username=jwtUtil.setTokengetUsername(token);
            log.info("username:"+username);

            if(username != null){
                log.info("업뎃시작");
                service.updateProfile(username, fileName);
                log.info("업뎃완료");

                String fileUrl = webPath+fileName;
                session.setAttribute("imgname", fileUrl);
                log.info("세션이미지업뎃완:{}", fileUrl);

                Map<String, String> response = new HashMap<String, String>();
                response.put("imgUrl", fileUrl);
                log.info("test"+response);
                return ResponseEntity.ok().body(response);
            }else{
                log.warn("username is null");
                Map<String, String> response = new HashMap<>();
                response.put("error", "username is null");
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
            }
        }catch(IOException e){
            log.error("파일 업로드 중 오류 발생", e);
            Map<String, String> response = new HashMap<String, String>();
            response.put("error", "파일 업로드 실패");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }

    }
    //마이페이지로 이동
    @GetMapping ("mypage/myHome")
    public String myHome(){
        String url="mypage/myHome";
        System.out.println(url);
        return url;
       // return "mypage/myHome";
    }
    //구매내역으로 이동
    @GetMapping("mypage/purchaseList")
    public String purchaseList(){

        return "mypage/purchaseList";
    }

    //마라톤신청서조회
    @GetMapping("mypage/marathonFormCheck")
    @ResponseBody
    public Map<String, Object> marathonFormCheck(
            @RequestParam("username") String username
    ){
        MarathonFormVO marathonVO = service.selectMarathonForm(username);
        Map<String, Object> result = new HashMap<>();
        if (marathonVO != null) {
            result.put("exists", true); // 신청서가 존재하면 true
            result.put("data", marathonVO); // 신청서 데이터를 함께 전송
        } else {
            result.put("exists", false); // 신청서가 없으면 false
        }

        return result;
    }
    /*//마라톤신청서작성(DB)
    @PostMapping("/mypage/createMarathonForm")
    @ResponseBody
    public String createMarathonForm(
            @RequestHeader("Authorization") String token,
            @RequestBody MarathonFormVO marathonVO){
        token=token.substring("Bearer ".length());
        service.createMarathonForm(marathonVO);
        return "200";
    }*/
    /*@PostMapping("/mypage/createMarathonForm")
    @ResponseBody
    public Map<String, String> createMarathonForm(
            @RequestHeader("Authorization") String token,
            @ModelAttribute MarathonFormVO marathonVO) {
        Map<String, String> response = new HashMap<>();

        try {
            // JWT에서 토큰을 추출
            token = token.substring("Bearer ".length());
            String username = jwtUtil.setTokengetUsername(token);

            // username으로 usercode 조회
            int usercode = service.selectUsercode(username);
            marathonVO.setUsercode(usercode);

            // 마라톤 신청서 저장
            service.createMarathonForm(marathonVO);
            response.put("message", "신청서 작성이 완료되었습니다.");
        } catch (IllegalArgumentException e) {
            // JWT 토큰에서 사용자 이름 추출 실패 또는 유효하지 않은 경우
            e.printStackTrace();
            response.put("message", "유효하지 않은 토큰입니다.");
        } catch (Exception e) {
            // 기타 예외 처리
            e.printStackTrace();
            response.put("message", "신청서 작성 중 오류가 발생했습니다.");
        }

        return response;
    }*/
    //내기록인증하기 이동
    @PostMapping("/mypage/certificate")
    @ResponseBody
    public String certificate(@RequestParam("username")String username) {
        System.out.println("ㅁㄴㅇㄹ");
        log.info("username1:"+username);
        System.out.println(username);
        return null;
    }
    @GetMapping("/mypage/certificateList")
    public ModelAndView certificateList(@RequestParam("username")String username) {
        log.info("username:"+username);
        ModelAndView mav = new ModelAndView();
        mav.addObject("list", service.selectCertificateAll(username));
        mav.setViewName("mypage/certificateList");
        return mav;
    }
    //회원정보수정(DB)
    @PostMapping("/mypage/editProfile")
    @ResponseBody
    public ResponseEntity<Map<String,String>> editProfile(
            @RequestParam("Authorization")String token,
            @RequestParam("currentPassword") String currentPassword,
            @RequestParam("newPassword") String newPassword,
            @RequestParam("nickname") String nickname,
            @RequestParam("tel1") String tel1,
            @RequestParam("tel2") String tel2,
            @RequestParam("tel3") String tel3){

        log.info("currentPassword:"+currentPassword);

        token=token.substring("Bearer ".length());
        String username=jwtUtil.setTokengetUsername(token);
        MemberVO member = service.selectMember(username);
        log.info("passchk : " + passwordEncoder.matches(currentPassword, member.getPassword()));
        // 기존 비밀번호 확인
        if (member == null || !passwordEncoder.matches(currentPassword, member.getPassword())) {
            Map<String, String> response = new HashMap<>();
            response.put("error", "현재 비밀번호가 일치하지 않습니다.");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        // 새 비밀번호가 비어 있지 않을 경우 비밀번호 업데이트
        if (newPassword != null && !newPassword.isEmpty()) {
            member.setPassword(passwordEncoder.encode(newPassword));
        }

        member.setNickname(nickname);
        member.setTel(tel1);
        member.setTel2(tel2);
        member.setTel3(tel3);

        service.editProfile(member);

        Map<String, String> response = new HashMap<>();
        return ResponseEntity.ok().body(response);
    }
    //회원탈퇴 (DB)]
    @PostMapping("/mypage/deleteProfile")
    @ResponseBody
    public ResponseEntity<Map<String,String>> deleteProfile(
            @RequestHeader("Authorization") String token,
            @RequestParam("currentPassword") String currentPassword
    ){
        log.info("currentPassword:"+currentPassword);
       // 토큰에서 사용자명 추출
       token = token.substring("Bearer ".length());
       String username = jwtUtil.setTokengetUsername(token);
       MemberVO member = service.selectMember(username);
       System.out.println(member.getPassword());

       // 비밀번호 확인
       if (member == null || !passwordEncoder.matches(currentPassword, member.getPassword())) {
           System.out.println("비밀번호일치하는지 확인");
           Map<String, String> response = new HashMap<>();
           response.put("error", "비밀번호가 일치하지 않습니다.");
           return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
       }
       System.out.println("비밀번호일치하는지 확인22");
       service.deactiveProfile(username, 1);
       Map<String, String> response = new HashMap<>();
       response.put("message", "회원탈퇴가 완료되었습니다.");

       return ResponseEntity.ok().body(response);
    }

    /*@PostMapping("/mypage/passwordChk")
    @ResponseBody
    public int passwordChk(@RequestParam("currentPassword") String currentPassword,
                           @RequestParam("username") String username) {


    }*/



}
