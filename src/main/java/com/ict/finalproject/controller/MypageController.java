package com.ict.finalproject.controller;


import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.MemberService;
import com.ict.finalproject.service.MypageService;

import com.ict.finalproject.vo.*;
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
import java.util.*;


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
            @RequestParam("usercode") int usercode
    ){
        MarathonFormVO marathonVO = service.selectMarathonForm(usercode);
        System.out.println("qwer"+marathonVO);
        Map<String, Object> result = new HashMap<>();
        if (marathonVO != null) {
            result.put("exists", true); // 신청서가 존재하면 true
            result.put("data", marathonVO); // 신청서 데이터를 함께 전송
        } else {
            result.put("exists", false); // 신청서가 없으면 false
        }

        return result;
    }
    //마라톤신청서작성(DB)
    @PostMapping("/mypage/createMarathonForm")
    @ResponseBody
    public String createMarathonForm(
            MarathonFormVO marathonVO){
        System.out.println("sadf"+marathonVO);
        service.createMarathonForm(marathonVO);
        return "200";
    }
    //나의메이트이동
    @PostMapping("/mypage/openMymate")
    @ResponseBody
    public String openMymate(@RequestParam("username")String username){
        return null;
    }
    @GetMapping("/mypage/myMate")
    public String myMate1(){

        return "mypage/myMate";
    }
    @PostMapping("/mypage/mymateList")
    @ResponseBody
    public Map<String, Object> mymateList(
            @RequestParam("usercode") int usercode
    ){
        System.out.println("메이트유저온다"+usercode);
        List<MemberVO> membervo = service.selectMemberAll(usercode);
        System.out.println(membervo);
        Map<String, Object> result = new HashMap<>();
        result.put("member", membervo);

        return result;
    }
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
    public String certificateList1() {

        return "mypage/certificateList";
    }
    //기록인증하기리스트페이지
    @PostMapping("/mypage/certificateList")
    @ResponseBody
    public Map<String, Object> certificateList(@RequestParam("username")String username,@RequestParam("usercode")int usercode) {
        List<CertificateVO> list = service.selectCertificateAll(username);
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        return result;
    }
    //기록인증하기
    @PostMapping("/mypage/uploadCertificate")
    @ResponseBody
    public CertificateVO uploadCertificate(
            @RequestParam("content") String content,
            @RequestParam("proof_photo") MultipartFile file,
            @RequestParam("username") String username,
            HttpServletRequest request
    ){
        CertificateVO cvo = new CertificateVO();
        try{
            String saveDir = request.getServletContext().getRealPath("/resources/uploadCertificate/");
             File dir = new File(saveDir);
             if(!dir.exists()){
                 dir.mkdirs();
             }
             if(!file.isEmpty()){
                 String originalFilename = file.getOriginalFilename();
                 String miliFilename = System.currentTimeMillis()+originalFilename;
                 String savePath = saveDir+miliFilename;
                 file.transferTo(new File(savePath));
                 System.out.println("확인1");
                 cvo.setContent(content);
                 cvo.setProof_photo(miliFilename);
                 cvo.setUsername(username);
                 cvo.setUpdated_date(String.valueOf(new Date()));
                 System.out.println("확인2");
                 service.updateCertificate(cvo);
                 System.out.println("저장확인1");
             }
            System.out.println("저장확인후1");
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("오면안되는곳1");
        }
        System.out.println("마지막확인1");
        return cvo;
    }
    //인증서삭제
    @PostMapping("/mypage/deleteCertificate")
    @ResponseBody
    public String deleteCertificate(@RequestParam("certificate_code")int certificate_code,
                                    HttpServletRequest request) {
        try {
            CertificateVO cvo = service.selectCertificate(certificate_code);

            String saveDir = request.getServletContext().getRealPath("/resources/uploadCertificate/");
            String filePath = saveDir + "/" + cvo.getProof_photo();
            File file = new File(filePath);
            if (file.exists()) {
                file.delete();
            }
            service.deleteCertificate(certificate_code);

            return "success";

        } catch (Exception e) {
            e.printStackTrace();
            return "fail";
        }
    }
    //내QnA이동
    @PostMapping("/mypage/openmyQnA")
    @ResponseBody
    public String myQnA(@RequestParam("username")String username,
                        @RequestParam("usercode")int usercode){
        return null;
    }
    @GetMapping("/mypage/myQnA")
    public String myQnA1(){

        return "mypage/myQnA";
    }
    //QnA리스트
    @PostMapping("/mypage/myQnAList")
    @ResponseBody
    public Map<String, Object> myQnAList(@RequestParam("username")String username,
                                      @RequestParam("usercode")int usercode){
        List<QnAVO> list = service.selectQnAAll(usercode);
        Map<String, Object> result = new HashMap<>();
        result.put("list", list);
        return result;
    }
    //QnA작성
    @PostMapping("/mypage/submitQnA")
    @ResponseBody
    public QnAVO submitQnA(@RequestParam("usercode")int usercode,
                           @RequestParam("subject")String subject,
                           @RequestParam("content")String content){

        QnAVO qvo = new QnAVO();
        System.out.println("여기까지안오나봐");
        System.out.println("성공"+qvo);
        qvo.setQna_subject(subject);
        qvo.setQna_content(content);
        qvo.setUsercode(usercode);

        service.updateQnA(qvo);

        return qvo;
    }
    //QnA삭제
    @PostMapping("/mypage/deleteQnA")
    @ResponseBody
    public String deleteQnA(@RequestParam("usercode")int usercode,
                            @RequestParam("qna_code")int qna_code){
        QnAVO qvo = service.selectQnA(qna_code);
        service.deleteQnA(qna_code);

        return "success";
    }
    //QnA조회
    @PostMapping("/mypage/viewQnA")
    @ResponseBody
    public QnAVO viewQnA(@RequestParam("usercode") int usercode,
                         @RequestParam("qna_code")int qna_code){
        QnAVO qvo = service.selectQnA(qna_code);
        if(qvo.getAnswer_content()==null){
            qvo.setAnswer_content("답변대기상태 입니다.");
        }else{
            qvo.setAnswer_content(qvo.getAnswer_content());
            service.updateQnAStatus(1, qna_code);
        }
        return qvo;
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
