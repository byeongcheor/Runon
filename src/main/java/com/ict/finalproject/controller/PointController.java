package com.ict.finalproject.controller;

import com.ict.finalproject.service.PointService;
import com.ict.finalproject.vo.PointVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Slf4j
@Controller
public class PointController {

    @Autowired
    private PointService pointService;

    // 사용자의 포인트 조회
    @GetMapping("/points")
    public PointVO getUserPoints(@AuthenticationPrincipal UserDetails userDetails) {
        String username = userDetails.getUsername();
        return pointService.getUserPointsByUsername(username);
    }

    // 포인트 사용 등록
    @PostMapping("/apply")
    public int applyPoints(@AuthenticationPrincipal UserDetails userDetails, @RequestBody int pointsToUse) {
        String username = userDetails.getUsername(); // 로그인한 사용자의 username 가져오기
        pointService.applyPointsByUsername(username, pointsToUse); // username으로 포인트 적용 서비스 호출

        // 포인트 적용 후 남은 포인트 반환
        PointVO userPoints = pointService.getUserPointsByUsername(username);
        return userPoints.getMypoint(); // 남은 포인트 반환
    }
}
