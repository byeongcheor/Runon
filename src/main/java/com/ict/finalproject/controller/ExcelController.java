package com.ict.finalproject.controller;

import com.ict.finalproject.dto.ExcelDTO;
import com.ict.finalproject.service.ExcelService;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.concurrent.atomic.AtomicInteger;

@Controller
@RequestMapping("/test")
public class ExcelController {
    @Autowired
    ExcelService service;


    @GetMapping("/test")
    public String test(){

        return "test";
    }
    @GetMapping("/success")
    public String sucess() {
        return "/test/success"; //성공화면
    }
    private AtomicInteger progress = new AtomicInteger(0);  // 진행 상태를 저장

    @PostMapping("/addExcel")
    public ResponseEntity<String> addExcel(@RequestParam("file") MultipartFile file) throws IOException {
        XSSFWorkbook workbook = new XSSFWorkbook(file.getInputStream());
        XSSFSheet worksheet = workbook.getSheetAt(0);

        // 날짜 변환 메서드 정의
        SimpleDateFormat dateTimeOriginalFormat = new SimpleDateFormat("yyyy년MM월dd일 출발시간:HH:mm");
        SimpleDateFormat originalFormat = new SimpleDateFormat("yyyy년MM월dd일");
        SimpleDateFormat mysqlFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");

        int totalRows = worksheet.getPhysicalNumberOfRows(); // 전체 행 수
        progress.set(0);  // 진행률 초기화

        for (int i = 1; i < totalRows; i++) {
            ExcelDTO excel = new ExcelDTO();
            DataFormatter formatter = new DataFormatter();
            XSSFRow row = worksheet.getRow(i);

            String marathon_name = formatter.formatCellValue(row.getCell(0));
            String marathon_type = formatter.formatCellValue(row.getCell(1));
            String total_distance = formatter.formatCellValue(row.getCell(2));
            String entry_fee = formatter.formatCellValue(row.getCell(3));
            String addr = formatter.formatCellValue(row.getCell(4));
            String marathon_content = formatter.formatCellValue(row.getCell(5));
            String event_date = formatter.formatCellValue(row.getCell(6)).trim();
            String registration_start_date = formatter.formatCellValue(row.getCell(7));
            String registration_end_date = formatter.formatCellValue(row.getCell(8));

            String formattedEventDate = "";
            String formattedRegStartDate = "";
            String formattedRegEndDate = "";

            try {
                // 날짜 형식을 MySQL 형식으로 변환
                formattedEventDate = mysqlFormat.format(dateTimeOriginalFormat.parse(event_date));
                formattedRegStartDate = mysqlFormat.format(originalFormat.parse(registration_start_date));
                formattedRegEndDate = mysqlFormat.format(originalFormat.parse(registration_end_date));
            } catch (ParseException e) {
                e.printStackTrace();
            }

            String lat = formatter.formatCellValue(row.getCell(9));
            String lon = formatter.formatCellValue(row.getCell(10));
            String poster_img = formatter.formatCellValue(row.getCell(11));

            excel.setMarathon_name(marathon_name);
            excel.setMarathon_type(marathon_type);
            excel.setTotal_distance(total_distance);
            excel.setEntry_fee(entry_fee);
            excel.setAddr(addr);
            excel.setMarathon_content(marathon_content);
            excel.setEvent_date(formattedEventDate);
            excel.setRegistration_start_date(formattedRegStartDate);
            excel.setRegistration_end_date(formattedRegEndDate);
            excel.setLat(lat);
            excel.setLon(lon);
            excel.setPoster_img(poster_img);

            // DB에 저장
            service.insertExcel(excel);

            // 진행 상태 업데이트 (예: 전체 행의 비율로 계산)
            progress.set((i * 100) / (totalRows - 1));
        }

        return ResponseEntity.ok("success");
    }

    @GetMapping("/progress")
    public ResponseEntity<Integer> getProgress() {
        return ResponseEntity.ok(progress.get());  // 현재 진행 상태 반환
    }
}
