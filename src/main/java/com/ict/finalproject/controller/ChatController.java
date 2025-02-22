package com.ict.finalproject.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.*;
import com.ict.finalproject.vo.CrewVO;
import com.ict.finalproject.vo.MessageVO;
import com.ict.finalproject.vo.ReportVO;
import lombok.extern.slf4j.Slf4j;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.Header;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;


@Slf4j
@Controller
public class ChatController {

    @Autowired
    ChatService chatservice;
    @Autowired
    CrewService crewservice;
    @Autowired
    private ReportService reportservice;


    @GetMapping("/message/chatList")
    public String mateChat(){

        return "chat/chatList";
    }

    //클라이언트가 서버에 접속하고 메시지를 보내면 받는곳
    @MessageMapping("/chat/{match_yn}")
    @SendTo("/topic/messages/{match_yn}") // 모든 클라이언트에게 메시지 보내기
    public MessageVO send(@DestinationVariable("match_yn") int match_yn, MessageVO vo){

        // 방 코드가 0일 경우 메시지 전송 차단
        if (match_yn == 0) {
            log.warn("매칭 방 코드가 0입니다. 메시지를 전송할 수 없습니다.");
            return null; // 메시지 전송 중단
        }


        System.out.println(match_yn);
        try {
            log.info("Received message for match_yn {}: {}", match_yn, vo.toString());
            log.info("Received gender: {}", vo.getGender()); // gender 값 확인
            vo.setRecipient(String.valueOf(match_yn));  // 방 코드 설정

            // 방 코드가 0일 경우 메시지 전송 차단
            if (match_yn == 0) {
                log.warn("매칭 방 코드가 0입니다. 메시지를 전송할 수 없습니다.");
                return null; // 메시지 전송 중단
            }

            // 메시지 내용이 비어있지 않은지 확인
            if (vo.getContent() == null || vo.getContent().isEmpty()) {
                throw new IllegalArgumentException("Message content cannot be empty.");
            }

            // 메시지에 서버에서 받은 시간을 추가
            String add_date = new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date());
                vo.setAdd_date(add_date);
                System.out.println("Generated add_date: " + add_date); // 로그 추가



                // 메시지를 DB에 저장
                chatservice.saveMessage(vo); // 메시지 저장
                log.info("Message saved to DB: {}", vo.toString());


            // 메시지를 모든 클라이언트에게 반환
            return vo;
        } catch (Exception e) {
            System.err.println("Error while sending message: " + e.getMessage());
            // 예외 처리 로직 추가 가능
            return null; // 필요에 따라 null 반환 또는 다른 처리를 추가
        }

    }
    // 방 코드에 따른 이전 메시지 조회
    @GetMapping("/message/chat/{match_yn}")
    @ResponseBody
    public List<MessageVO> getMessages(@PathVariable("match_yn") int matchYn) {
        log.info("매칭 방 코드 {}의 메시지를 조회합니다.", matchYn);  // 요청 로그 확인

        // 방 코드가 0일 때 메시지를 불러오지 않음
        if (matchYn == 0) {
            log.warn("매칭 방 코드가 0입니다. 메시지를 조회하지 않습니다.");
            return Collections.emptyList(); // 빈 리스트 반환
        }

        return chatservice.getMessagesByMatchYn(matchYn); // 정상적인 방 코드일 때만 메시지 조회
    }

    @PostMapping("/chat/report")
    @ResponseBody
    public ReportVO report(@RequestBody ReportVO reportVO) {
        try {

            System.out.println("Received report data: " + reportVO.toString());

            // 현재 날짜 및 시간을 문자열 형식으로 설정
            String report_date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            reportVO.setReport_date(report_date); // report_date 필드에 설정

            String reportContentJsonString = reportVO.getReport_content();
            ObjectMapper mapper = new ObjectMapper();
            JsonNode jsonArray = mapper.readTree(reportContentJsonString);
            StringBuilder contentText = new StringBuilder();

            for (JsonNode jsonObject : jsonArray) {
                String nickname = jsonObject.get("nickname").asText();
                String content = jsonObject.get("content").asText();
                contentText.append("닉네임: ").append(nickname)
                        .append(", 메시지 내용: ").append(content)
                        .append("\n");
            }
            // 변환된 텍스트를 reportVO에 설정
            reportVO.setReport_content(contentText.toString());

            System.out.println("Processed report content: " + reportVO.getReport_content());
            // 신고 정보를 데이터베이스에 저장
            chatservice.saveReport(reportVO); // 서비스 호출

            // 신고 정보가 저장된 reportVO 객체 반환
            return reportVO; // ResponseEntity 대신 reportVO 반환
        } catch (Exception e) {
            // 예외 발생 시 null 반환 또는 다른 처리
            reportVO.setReport_content("신고 접수 실패: " + e.getMessage());
            return reportVO; // 실패 시에도 ReportVO 반환
        }
    }
    @GetMapping("/chat/reportHistory")
    @ResponseBody
    public List<ReportVO> getReportHistory(@RequestParam int usercode) {

        List<ReportVO> reportHistory = null;
        try {
            reportHistory = reportservice.getReportsByUserCode(usercode);
            System.out.println("reportHistory: " + reportHistory.toString());
            if (reportHistory.isEmpty()) {
                log.info("No report history found for usercode: {}", usercode);

            }

        } catch (Exception e) {
            // 로그 출력 및 빈 리스트 반환
            log.error("Error retrieving report history for usercode {}: {}", usercode, e.getMessage());

            return Collections.emptyList(); // 예외 발생 시 빈 리스트 반환
        }
        System.out.println("마지막까지 오는것 확인");
        return reportHistory;
    }
    @PostMapping("/report/updateStatus")
    @ResponseBody
    public ReportVO updateReportStatus(@RequestBody ReportVO reportVO) {
        try {
            reportservice.updateReportStatus(reportVO); // 신고 상태 업데이트 서비스 메서드 호출
            return reportVO; // 업데이트된 ReportVO 반환
        } catch (Exception e) {
            log.error("신고 상태 업데이트 오류: {}", e.getMessage());
            reportVO.setReport_status(-1); // 에러가 발생한 경우 상태를 -1로 설정 (원하는 에러 코드로 변경 가능)
            return reportVO; // 에러가 발생했을 때도 ReportVO를 반환
        }
    }


























//    @GetMapping("/mate/mate")
//    public String mateChat(Model model){
//        List<CrewVO> chatList = crewservice.getCrewList();  // 크루 리스트를 가져오는 서비스
//
//        // 로그 추가
//        log.info("mateChat 호출됨");  // 이 로그가 찍히는지 확인하세요
//
//        if (chatList != null && !chatList.isEmpty()) {
//            for (CrewVO crew : chatList) {
//                log.info("Crew Name: " + crew.getCrew_name()); // 로깅 사용
//            }
//        } else {
//            log.warn("크루 목록을 가져오지 못했습니다."); // 로깅 사용
//        }
//        model.addAttribute("chatList", chatList);  // 모델에 데이터를 담아 JSP에 전달
//
//        return "mate/mate";  // JSP 파일 경로로 반환
//    }
//

}





