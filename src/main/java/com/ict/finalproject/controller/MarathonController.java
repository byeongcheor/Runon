package com.ict.finalproject.controller;

import com.ict.finalproject.dao.MemberDAO;
import com.ict.finalproject.jwt.JWTUtil;
import com.ict.finalproject.service.CartService;
import com.ict.finalproject.service.CrewService;
import com.ict.finalproject.service.MarathonService;
import com.ict.finalproject.service.ReportService;
import com.ict.finalproject.vo.*;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Collections;
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
    ReportService reportservice;

    @PostMapping("/test")
    @ResponseBody
    public String test(@RequestParam("Authorization") String token) {
        System.out.println("테스트111"+token);
        if (token!=null&&!token.isEmpty()){
            token=token.substring("Bearer ".length());
            System.out.println("1111111");
            try {
                user_name = jwtUtil.setTokengetUsername(token);
                System.out.println("Username from Token: " + user_name);
            } catch (Exception e) {
                System.out.println("Error parsing token: " + e.getMessage());
                e.printStackTrace(); // 전체 스택 트레이스 확인
            }
            return user_name;}
        return null;
    }

    @GetMapping("/marathonList")
    public String marathonList(Model model, MarathonListVO mvo, PagingVO pvo, HttpServletRequest request){




        // 전체 레코드 수를 세고, 페이징 정보를 설정
        int totalRecord = service.totalRecord(pvo);
        pvo.setTotalRecord(totalRecord);
       //받은것 표시 에러면 주석
        pvo.calculateTotalPage(); // TotalPage 계산
        pvo.calculateOffset(); // 오프셋 계산
        // 페이징을 적용한 마라톤 목록 조회
        List<MarathonListVO> list = service.marathonSelectPaging(pvo);

        // 로그 추가
        System.out.println("Total Record: " + totalRecord);
        System.out.println("Marathon List Size: " + list.size());

        // 전체 페이지 수 계산
        //여기도 에러면 주석
        int totalPages = (int) Math.ceil((double) totalRecord / pvo.getOnePageRecord());
        pvo.setTotalPage(totalPages); // 전체 페이지 수 설정

        // 모델에 데이터 추가
        model.addAttribute("list", list);
        model.addAttribute("pvo", pvo);

        return "marathon/marathonList";
    }



    @GetMapping("/marathonDetail/{marathonCode}")
    public String marathonDetail(@PathVariable("marathonCode") int marathonCode, Model model, HttpServletRequest request){
        System.out.println("test");
   /*     user_code = service.usercodeSelect(user_name);
        List<MarathonListVO> userselect = service.userselect(user_code);
        System.out.println(userselect);*/

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

        /* model.addAttribute("userselect",userselect);*/
        // 모델에 데이터 추가
        model.addAttribute("marathon", marathon);
        model.addAttribute("distancePriceMap", distancePriceMap); // 거리와 가격 맵 추가
        model.addAttribute("marathonName", marathon.getMarathon_name()); // 마라톤 이름
        model.addAttribute("latitude", marathon.getLat()); // 위도
        model.addAttribute("longitude", marathon.getLon()); // 경도
        model.addAttribute("totalDistance", marathon.getTotal_distance()); // 총 거리
        model.addAttribute("entryFee", marathon.getEntry_fee()); // 참가비 추가

        return "marathon/marathonDetail";
    }

    @PostMapping("/addToCart")
    @ResponseBody
    public Map<String, Object> addToCart(@RequestBody CartVO cartVO) {
        Map<String, Object> result = new HashMap<>();
        try {
            System.out.println("cartVO확인"+cartVO);
             // CartVO에 usercode 설정
            // 장바구니에 추가
            int b=service.addToCart(cartVO);
            System.out.println(b);
            result.put("success", true);
            result.put("message", "장바구니에 담겼습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "장바구니에 추가 실패: " + e.getMessage());
        }
        return result; // JSON 형태로 응답
    }


    @GetMapping("/cart")
    public String viewCart(Model model, @RequestParam("usercode") int usercode) {
        // 장바구니 조회
        List<CartVO> cartList = service.getCartByUserCode(usercode);
        model.addAttribute("cartList", cartList);
        return "cart/cart"; // 장바구니 JSP 페이지 경로
    }


    //핕터
    @GetMapping("/filter")
    @ResponseBody
    public Map<String, Object> filterMarathons(
            @RequestParam(required = false, defaultValue = "") String year,
            @RequestParam(required = false, defaultValue = "") String month,
            @RequestParam(required = false, defaultValue = "") String addr,
            @RequestParam(required = false, defaultValue = "") String search,
            @RequestParam(required = false, defaultValue = "0") Integer sort1, // Integer로 변경
            PagingVO pvo) {


        System.out.println(addr);
        // PagingVO에 필터링된 값 설정
        pvo.setYear(year);
        pvo.setMonth(month);
        pvo.setRegion(addr);
        pvo.setSearch(search); // search 값 설정
        pvo.setSort1(sort1);

        // 페이지 번호와 레코드 수 설정
        pvo.setNowPage(1); // 기본적으로 첫 페이지로 설정, 필요 시 변경 가능
        pvo.calculateOffset(); // 오프셋 계산

        // 입력값 로그 출력 (디버깅 용)
        log.info("필터링 파라미터 - year: {}, month: {}, region: {}, search: {}, sort: {}", year, month, addr, search, sort1);

        // 총 레코드 수를 구하고 필터링된 목록을 가져옵니다.
        int totalRecord = service.getFilteredTotalRecord(year, month, addr, search);
        pvo.setTotalRecord(totalRecord);

        List<MarathonListVO> filteredMarathons = service.filterMarathons(year, month, addr, search, pvo, sort1);
        // 결과를 저장할 Map을 초기화합니다.
        Map<String, Object> result = new HashMap<>();
        result.put("totalRecord", totalRecord);
        result.put("filteredMarathons", filteredMarathons);


        return result; // 필터링된 마라톤 목록과 총 레코드 수 반환
    }
    @PostMapping("/addLike")
    @ResponseBody
    public Map<String, Object> addLike(@RequestBody LikeVO likeVO) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 좋아요 여부 확인
            boolean alreadyLiked = service.checkLike(likeVO.getUsercode(), likeVO.getMarathon_code());

            if (!alreadyLiked) {
                // 좋아요 추가
                service.addLike(likeVO);
                service.incrementLikeCount(likeVO.getMarathon_code()); // 총합 업데이트
                result.put("success", true);
                result.put("message", "좋아요가 추가되었습니다.");
            } else {
                // 좋아요 해제
                service.removeLike(likeVO.getUsercode(), likeVO.getMarathon_code()); // 좋아요 삭제
                service.decrementLikeCount(likeVO.getMarathon_code()); // 총합 감소
                result.put("success", true);
                result.put("message", "좋아요가 해제되었습니다.");
            }
        } catch (Exception e) {
            // 예외 처리
            result.put("success", false);
            result.put("message", "좋아요 추가 실패: " + e.getMessage());
            e.printStackTrace(); // 전체 스택 트레이스를 로그에 출력
        }
        return result; // JSON 형태로 응답
    }

    @GetMapping("/checkLike")
    @ResponseBody
    public Map<String, Object> checkLike(@RequestParam int usercode, @RequestParam int marathon_code) {
        Map<String, Object> result = new HashMap<>();
        boolean liked = service.checkLike(usercode, marathon_code); // 좋아요 여부 확인
        result.put("liked", liked);
        return result; // JSON 형태로 응답
    }
    @PostMapping("/incrementViewCount")
    @ResponseBody
    public Map<String, Object> incrementViewCount(@RequestBody Map<String, Integer> params) {
        Map<String, Object> result = new HashMap<>();
        try {
            int marathonCode = params.get("marathon_code"); // 요청 본문에서 marathon_code 가져오기
            service.incrementViewCount(marathonCode); // 서비스에서 조회수 증가 메서드 호출
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "조회수 증가 실패: " + e.getMessage());
            e.printStackTrace();
        }
        return result; // JSON 형태로 응답
    }
    @PostMapping("/addMarathonToCart")
    public Map<String, Object> addMarathonToCart(@RequestBody CartVO cartVO) {
        Map<String, Object> result = new HashMap<>();
        try {
            System.out.println("cartVO 확인: " + cartVO);
            // CartVO에 usercode 설정
            // 장바구니에 추가
            int addedCount = service.addToCart(cartVO);
            System.out.println("장바구니에 추가된 항목 수: " + addedCount);

            result.put("success", true);
            result.put("message", "마라톤 상품이 장바구니에 담겼습니다.");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "장바구니에 추가 실패: " + e.getMessage());
        }
        return result; // JSON 형태로 응답
    }

    @PostMapping("/hospitalList")
    @ResponseBody
    public Map<String, Object> hospitalList(HospitalVO hvo) {
        Map<String, Object> map = new HashMap<>();
        /* 확인완료System.out.println(hvo);*/
        List<HospitalVO> hvoList=service.getHospitalList(hvo);
        /* 확인완료 System.out.println(hvoList);*/

        map.put("hvoList", hvoList);
        return map;
    }






}