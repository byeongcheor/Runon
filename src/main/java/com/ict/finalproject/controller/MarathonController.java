package com.ict.finalproject.controller;

import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.CartService;
import com.ict.finalproject.service.CrewService;
import com.ict.finalproject.service.MarathonService;
import com.ict.finalproject.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/marathon")
public class MarathonController {
    @Autowired
    MarathonService service;
    CartService cartservice;
    JWTUtil jwtUtil;
    String user_name ="";
    int user_code = 0;


    @PostMapping("/test")
    @ResponseBody
    public String test(@RequestParam("Authorization")String token) {
        token=token.substring("Bearer ".length());
        user_name=jwtUtil.setTokengetUsername(token);
        user_code = service.usercodeSelect(user_name);

        System.out.println(user_code);
        return user_name;
    }

    @GetMapping("/marathonList")
    public String marathonList(MarathonListVO mvo, PagingVO pvo, Model model, @RequestHeader(value = "Authorization", required = false) String token){
        int user_code = 0; // 기본값 설정

        // Bearer 토큰에서 실제 토큰 추출
        if (token != null && token.startsWith("Bearer ")) {
            token = token.substring("Bearer ".length());

            // 토큰으로부터 사용자 이름 추출
            String user_name = jwtUtil.setTokengetUsername(token);
            user_code = service.usercodeSelect(user_name); // 유저 코드 조회

        } else {
            System.out.println("No valid token provided");
        }

        // 전체 레코드 수를 세고, 페이징 정보를 설정
        int totalRecord = service.totalRecord(pvo);
        pvo.setTotalRecord(totalRecord);

        // 페이징을 적용한 마라톤 목록 조회
        List<MarathonListVO> list = service.marathonSelectPaging(pvo);

        // 로그 추가
        System.out.println("Total Record: " + totalRecord);
        System.out.println("Marathon List Size: " + list.size());

        // 모델에 데이터 추가
        model.addAttribute("list", list);
        model.addAttribute("pvo", pvo);
        model.addAttribute("user_code", user_code); // 유저 코드를 모델에 추가

        return "marathon/marathonList";
    }



    @GetMapping("/marathonDetail")
    public String marathonDetail(@RequestParam("code") int marathonCode, Model model){
        // 마라톤 코드에 따라 마라톤 정보를 가져오는 로직
        MarathonListVO marathon = service.getMarathonByCode(marathonCode);

        // 거리와 가격 매칭을 위한 Map 생성
        Map<String, Integer> distancePriceMap = new HashMap<>();
        String[] totalDistances = marathon.getTotal_distance().split(","); // total_distance 값
        String[] entryFees = marathon.getEntry_fee().split("/"); // entry_fee 값 '/'로 분리

        // 각 거리별 가격 처리
        for (int i = 0; i < totalDistances.length; i++) {
            String distance = totalDistances[i].trim();
            if (i < entryFees.length) {
                String fee = entryFees[i].trim(); // 매칭되는 가격 가져오기

                // 가격에서 "원" 기호 앞의 숫자만 추출
                String priceString = fee; // 원래의 fee 값 사용
                int price = 0;

                // "원" 기호가 있는 경우
                if (priceString.contains("원")) {
                    // "원" 기호를 기준으로 문자열을 분리
                    String[] parts = priceString.split("원");
                    if (parts.length > 0) {
                        String numericPart = parts[0].trim(); // "원" 앞 부분 가져오기

                        // "원" 앞 부분에서 숫자만 남기기
                        String onlyNumbers = numericPart.replaceAll("[^0-9]", ""); // 숫자만 추출

                        // 가격 문자열이 5자리 이상인 경우
                        if (onlyNumbers.length() >= 5) {
                            // "원" 앞의 마지막 5자리 숫자만 추출
                            price = Integer.parseInt(onlyNumbers.substring(onlyNumbers.length() - 5)); // 마지막 5자리 숫자만 추출
                        } else {
                            // 5자리 미만인 경우 가격을 그대로 변환
                            price = Integer.parseInt(onlyNumbers);
                        }
                    }
                } else {
                    // "원" 기호가 없을 경우 기본값 처리 (예: 0)
                    price = Integer.parseInt(priceString.replaceAll("[^0-9]", ""));
                }

                // 거리와 가격을 Map에 추가
                distancePriceMap.put(distance, price);
            }
        }


        // 모델에 데이터 추가
        model.addAttribute("marathon", marathon);
        model.addAttribute("distancePriceMap", distancePriceMap); // 거리와 가격 맵 추가

        return "marathon/marathonDetail";
    }

    @GetMapping("/marathonDetail/{id}")
    public String getMarathonDetail(@PathVariable("id") int marathonId, Model model,MarathonListVO mvo) {
        // 조회수 증가
        service.increaseHit(marathonId);

        // DB에서 마라톤 정보를 가져옴 (마라톤 이름, 위도, 경도)
        MarathonListVO marathon  = service.getMarathonById(marathonId);

        // 모델에 마라톤 정보 추가
        // 모델에 마라톤 정보 추가
        model.addAttribute("marathon", marathon);
        model.addAttribute("marathonName", marathon.getMarathon_name()); // 마라톤 이름
        model.addAttribute("latitude", marathon.getLat()); // 위도
        model.addAttribute("longitude", marathon.getLon()); // 경도
        model.addAttribute("totalDistance", marathon.getTotal_distance()); // 총 거리
        model.addAttribute("entryFee", marathon.getEntry_fee()); // 참가비 추가

        // JSP 또는 Thymeleaf로 데이터를 전달하여 화면에 출력
        return "marathon/marathonDetail";
    }
    @PostMapping("/addToCart")
    @ResponseBody
    public Map<String, Object> addToCart(CartVO cartVO) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 장바구니에 추가
            service.addToCart(cartVO);
            result.put("success", true);
            result.put("message", "장바구니에 담겼습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "장바구니에 추가 실패: " + e.getMessage());
        }
        return result; // JSON 형태로 응답
    }

    // 장바구니 페이지 이동
    @GetMapping("/cart")
    public String viewCart(Model model, @SessionAttribute("usercode") int usercode) {
        // 장바구니 조회
        List<CartVO> cartList = service.getCartByUserCode(usercode);
        model.addAttribute("cartList", cartList);
        return "order/cart"; // 장바구니 JSP 페이지 경로
    }

    //핕터
    @GetMapping("/filter")
    @ResponseBody
    public Map<String, Object> filterMarathons(
            @RequestParam(required = false, defaultValue = "") String year,
            @RequestParam(required = false, defaultValue = "") String month,
            @RequestParam(required = false, defaultValue = "") String addr,
            @RequestParam(required = false, defaultValue = "") String search,
            @RequestParam(required = false, defaultValue = "0") Integer sort, // Integer로 변경
            PagingVO pvo) {


            // PagingVO에 필터링된 값 설정
            pvo.setYear(year);
            pvo.setMonth(month);
            pvo.setRegion(addr);
            pvo.setSearch(search); // search 값 설정
            pvo.setSort(sort);

            // 페이지 번호와 레코드 수 설정
            pvo.setNowPage(1); // 기본적으로 첫 페이지로 설정, 필요 시 변경 가능
            pvo.calculateOffset(); // 오프셋 계산

            // 입력값 로그 출력 (디버깅 용)
            log.info("필터링 파라미터 - year: {}, month: {}, region: {}, search: {}, sort: {}", year, month, addr, search, sort);

            // 총 레코드 수를 구하고 필터링된 목록을 가져옵니다.
            int totalRecord = service.getFilteredTotalRecord(year, month, addr, search);
            pvo.setTotalRecord(totalRecord);

            List<MarathonListVO> filteredMarathons = service.filterMarathons(year, month, addr, search, pvo, sort);
            // 결과를 저장할 Map을 초기화합니다.
            Map<String, Object> result = new HashMap<>();
            result.put("totalRecord", totalRecord);
            result.put("filteredMarathons", filteredMarathons);


        return result; // 필터링된 마라톤 목록과 총 레코드 수 반환
    }






}