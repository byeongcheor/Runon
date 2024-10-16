package com.ict.finalproject.vo;

public class PagingVO {
    private int nowPage = 1; //현재페이지 -> 페이지번호가 없을때 무조건 1페이지가 된다.
    private int onePageRecord = 5; //한번에 표시할 레코드 수 : limit의 값
    private int offset; //페이지에 해당하는 레코드 선택할 때 시작위치
    private int totalRecord; //총 레코드수 DB에서 count()함수
    private int totalPage; //총 페이지수 = 총 레코드수와 한페이지 출력할 레코드로 계산
    private int onePageNum = 5; // 한번에 표시할 페이지수
    private int startPageNum = 1; //페이지번호의 시작페이지 번호
    private String searchKey;
    private String searchWord;
    private String addr;

    private String searchKey2;
    private String searchWord2;
    private String sort;
    private String schedule;

    @Override
    public String toString() {
        return "PagingVO{" +
                "nowPage=" + nowPage +
                ", onePageRecord=" + onePageRecord +
                ", offset=" + offset +
                ", totalRecord=" + totalRecord +
                ", totalPage=" + totalPage +
                ", onePageNum=" + onePageNum +
                ", startPageNum=" + startPageNum +
                ", searchKey='" + searchKey + '\'' +
                ", searchWord='" + searchWord + '\'' +
                ", addr='" + addr + '\'' +
                ", searchKey2='" + searchKey2 + '\'' +
                ", searchWord2='" + searchWord2 + '\'' +
                ", sort='" + sort + '\'' +
                ", schedule='" + schedule + '\'' +
                '}';
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }

    public String getSearchKey2() {
        return searchKey2;
    }

    public void setSearchKey2(String searchKey2) {
        this.searchKey2 = searchKey2;
    }

    public String getSearchWord2() {
        return searchWord2;
    }

    public void setSearchWord2(String searchWord2) {
        this.searchWord2 = searchWord2;
    }

    public String getSearchKey() {
        return searchKey;
    }
    public void setSearchKey(String searchKey) {
        this.searchKey = searchKey;
    }
    public String getSearchWord() {
        return searchWord;
    }
    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }
    public int getNowPage() {
        return nowPage;
    }
    public void setNowPage(int nowPage) {
        this.nowPage = nowPage;
        //페이지번호의 시작값을 계산
        // ((현제페이지-1)/한번에 표시할 페이지수)*한번에 표시할 페이지수 + 1
        startPageNum = (nowPage-1)/onePageNum*onePageNum + 1; //1,6,11,16...
    }
    public int getOnePageRecord() {
        return onePageRecord;
    }
    public void setOnePageRecord(int onePageRecord) {
        this.onePageRecord = onePageRecord;
    }
    public int getOffset() {
        //레코드선택 시작위치 계산식
        offset = (nowPage-1)*onePageRecord;
        return offset;
    }
    public void setOffset(int offset) {
        this.offset = offset;
    }
    public int getTotalRecord() {
        return totalRecord;
    }
    public int getOnePageNum() {
        return onePageNum;
    }
    public void setOnePageNum(int onePageNum) {
        this.onePageNum = onePageNum;
    }
    public int getStartPageNum() {
        return startPageNum;
    }
    public void setStartPageNum(int startPageNum) {
        this.startPageNum = startPageNum;
    }
    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;
        //총 페이지수 -> totalPage
        totalPage = totalRecord / onePageRecord;
        if(totalRecord%onePageRecord > 0) {
            //5의 배수가 아니면 1page추가
            totalPage++;
        }
    }
    public int getTotalPage() {
        return totalPage;
    }
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public String getAddr() {
        return addr;
    }

    public void setAddr(String addr) {
        this.addr = addr;
    }
}
