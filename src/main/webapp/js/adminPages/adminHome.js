let myChart; // 전역 변수로 차트 객체를 선언
let Memchart;
let Memlist;
let annualSales;
$(document).ready(function () {
    if(Memchart){
        Memchart.destroy();
    }

    fetchData("7days");

    // 버튼 클릭 이벤트 등록
    $("#btn7Days").click(function () {
        fetchData("7days");
    });

    $("#btn30Days").click(function () {
        fetchData("weekly"); // 주별 데이터를 가져오는 경우
    });

    $("#btn1Year").click(function () {
        fetchData("monthly"); // 월별 데이터를 가져오는 경우
    });

    $("#btnYearly").click(function () {
        fetchData("yearly"); // 연도별 데이터를 가져오는 경우
    });

    // Doughnut 차트 설정
    $.ajax({
        url:"/adminPages/adminCharts",
        type:"post",
        success:function(r){
            Memlist=r.MemList[0];
            MemberCount(Memlist);
            yearsamount(annualSales);
            //진행중인 마라톤 차트
            const data = {
                labels: ['진행중인 마라톤', '전체 마라톤'],
                datasets: [{
                    label: '리스트수',
                    data: [r.list[0].event_count, r.list[0].marathon_Count], // 유효한 이벤트 수와 무효한 이벤트 수
                    backgroundColor: ['rgba(255, 128, 0, 0.5)', 'rgba(200, 200, 200, 0.2)'],
                    borderColor: 'rgba(255, 255, 255, 1)',
                    borderWidth: 1,
                }]
            };

            const config = {
                type: 'doughnut',
                data: data,
                options: {
                    cutout: '90%',
                    responsive: true,
                    plugins: {
                        tooltip: {
                            enabled: true
                        },
                        legend: {
                            display: true
                        }
                    }
                },
                plugins: [{
                    id: 'percentageLabel',
                    afterDraw: (chart) => {
                        const ctx = chart.ctx;
                        const data = chart.data.datasets[0].data;
                        const total = data.reduce((sum, value) => sum + value, 0);
                        const value = data[0]; // 유효한 이벤트 수
                        const percentage = total ? ((value / total) * 100).toFixed(0) : 0; // 퍼센트 계산

                        ctx.save();
                        ctx.font = 'bold 24px Arial'; // 텍스트 스타일 설정
                        ctx.fillStyle = 'black'; // 텍스트 색상
                        ctx.textAlign = 'center';
                        ctx.textBaseline = 'middle';

                        const centerX = chart.width / 2; // 차트 중앙 X 좌표
                        const centerY = chart.height / 2; // 차트 중앙 Y 좌표

                        ctx.fillText(percentage + '%', centerX, centerY); // 중앙에 텍스트 그리기
                        ctx.restore();
                    }
                }]
            };
            myChart1 = new Chart(document.getElementById('marathonChart1'), config);


            // 준비중인 마라톤 차트
            const data2 = {
                labels: ['준비중인 마라톤', '전체 마라톤'],
                datasets: [{
                    label: "리스트수",
                    data: [r.list[0].unstart_count, r.list[0].marathon_Count], // 유효한 이벤트 수와 무효한 이벤트 수
                    backgroundColor: ['rgba(255, 128, 0, 0.5)', 'rgba(200, 200, 200, 0.2)'],
                    borderColor: 'rgba(255, 255, 255, 1)',
                    borderWidth: 1,
                }]
            };

            const config2 = {
                type: 'doughnut',
                data: data2,
                options: {
                    cutout: '90%',
                    responsive: true,
                    plugins: {
                        tooltip: {
                            enabled: true
                        },
                        legend: {
                            display: true
                        }
                    }
                },
                plugins: [{
                    id: 'percentageLabel',
                    afterDraw: (chart) => {
                        const ctx = chart.ctx;
                        const data = chart.data.datasets[0].data;
                        const total = data.reduce((sum, value) => sum + value, 0);
                        const value = data[0]; // 유효한 이벤트 수
                        const percentage = total ? ((value / total) * 100).toFixed(0) : 0; // 퍼센트 계산

                        ctx.save();
                        ctx.font = 'bold 24px Arial'; // 텍스트 스타일 설정
                        ctx.fillStyle = 'black'; // 텍스트 색상
                        ctx.textAlign = 'center';
                        ctx.textBaseline = 'middle';

                        const centerX = chart.width / 2; // 차트 중앙 X 좌표
                        const centerY = chart.height / 2; // 차트 중앙 Y 좌표

                        ctx.fillText(percentage + '%', centerX, centerY); // 중앙에 텍스트 그리기
                        ctx.restore();
                    }
                }]
            };
            myChart2 = new Chart(document.getElementById('marathonChart2'), config2);




        }
    });

    $.ajax({
        url:"/adminPages/joinsUser",
        type:"post",
        success:function(r){
            var jclist=r.JClist[0];
            document.getElementById("lodding1").innerHTML= jclist.dailyCount;
            document.getElementById("lodding2").innerHTML= jclist.monthlyCount;
        }
    })

});//여기가 로드할때 시작하는 함수 끝
setTimeout(function(){
    newPayment();
},100);
// 차트 생성 함수
function createLineChart(labels, data) {
    const ctx = document.getElementById('loginChart').getContext('2d');

    // 기존 차트가 존재하는 경우 제거
    if (myChart) {
        myChart.destroy();
    }

    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '방문자 수',
                data: data,
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

// Bar 차트 생성 함수
function createBarChart(labels, data) {
    const ctx = document.getElementById('loginChart').getContext('2d');

    // 기존 차트가 존재하는 경우 제거
    if (myChart) {
        myChart.destroy();
    }

    myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: '방문자 수',
                data: data,
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255, 99, 132, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
}

function fetchData(period) {
    $.ajax({
        url: "/adminPages/getUserHistory",
        type: "post",
        data: { period: period }, // 요청할 기간 정보 전달
        success: function (r) {
            //console.log(r);
            // 방문날짜와 방문자 수 배열 생성
            var labels = [];
            var data = [];
            r.list.forEach(function (visitCount) {
                labels.push(visitCount.visit_date);
                data.push(visitCount.visitor_count);
            });
            if (period==="monthly"||period==="weekly"){
                labels.reverse();
                data.reverse();
            }
            // 차트 유형에 따라 createChart 함수를 호출
            if (period === "yearly") {
                createBarChart(labels, data); // 연도별일 경우 Bar 차트
            } else {
                createLineChart(labels, data); // 나머지는 Line 차트
            }
        },
        error: function (error) {
            console.error("데이터를 가져오는 데 실패했습니다:", error);
        }
    });
}
//남녀별 나이대구하는 함수
function GACount(gender,count){

    $.ajax({
        url: "/adminPages/AgeCount",
        type: "post",
        data: { gender: gender },
        success: function(r) {
            var gaclist = r.GAClist;
            const ageOrder = {
                '미기입자': 0,
                '10대':1,
                '20대': 2,
                '30대': 3,
                '40대': 4,
                '50대': 5,
                '60대 이상': 6
            };
            const allAges = [
                { ageGroup: '미기입자', groupCount: 0 },
                { ageGroup: '10대', groupCount: 0 },
                { ageGroup: '20대', groupCount: 0 },
                { ageGroup: '30대', groupCount: 0 },
                { ageGroup: '40대', groupCount: 0 },
                { ageGroup: '50대', groupCount: 0 },
                { ageGroup: '60대 이상', groupCount: 0 }
            ];

            // gaclist에서 실제 데이터를 업데이트합니다.
            for (let i = 0; i < gaclist.length; i++) {
                const ageGroup = gaclist[i].ageGroup;
                const groupCount = gaclist[i].groupCount;

                // 해당 나이대의 groupCount를 업데이트합니다.
                const ageData = allAges.find(item => item.ageGroup === ageGroup);
                if (ageData) {
                    ageData.groupCount = groupCount;
                }
            }

            // 나이대 순서대로 정렬
            allAges.sort((a, b) => {
                return ageOrder[a.ageGroup] - ageOrder[b.ageGroup];
            });

            // 정렬된 결과로 labels와 data를 생성
            const gaclabels = [];
            const gacData = [];
            for (let i = 0; i < allAges.length; i++) {
                gaclabels.push(allAges[i].ageGroup);
                gacData.push(allAges[i].groupCount);
            }

            // 최종 데이터 구조
            const gacdata = {
                labels: gaclabels,
                datasets: [{
                    label: "인원:",
                    data: gacData,
                    backgroundColor: ['rgba(200, 200, 200, 0.5)', 'rgba(75, 192, 192, 0.5)', 'rgba(54, 162, 235, 0.5)', 'rgba(255, 159, 64, 0.5)', 'rgba(255, 99, 132, 0.5)', 'rgba(153, 102, 255, 0.5)', 'rgba(255, 215, 0, 0.5)'],
                    borderColor: 'rgba(255, 255, 255, 1)',
                    borderWidth: 1,
                }]
            };
            const gacconfig={
                type:"doughnut",
                data:gacdata,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: true,
                            onClick:false
                        },
                        tooltip: {
                            callbacks: {
                                label: function(tooltipItem) {
                                    const label = tooltipItem.label || '';
                                    const value = tooltipItem.raw; // 원래 값 사용
                                    const total = count; // 총 인원 수
                                    const percentage = ((value / total) * 100).toFixed(2);
                                    return  `${label}: ${value}명 (${percentage}%)`; // 툴팁에 "명" 추가

                                }
                            }
                        }
                    },
                    onClick:function(){
                        document.getElementById("changetext").innerHTML="남여비율";
                        MemberCount();
                    }
                },plugins:[{

                        id: 'customCenterText',
                        beforeDraw: function(chart) {
                            const width = chart.width,
                                height = chart.height,
                                ctx = chart.ctx;

                            // 중앙에 텍스트 표시
                            ctx.restore();
                            const fontSize = (height / 100).toFixed(2);
                            ctx.font = `1em sans-serif`;
                            ctx.textBaseline = 'middle';

                            const text =`${count}명`
                            const textX = Math.round((width - ctx.measureText(text).width) / 2);
                            const textY = height*0.7 ;

                            ctx.fillText(text, textX, textY);
                            ctx.save();

                        }

                }]

            };

            // 차트 업데이트 또는 생성하는 로직
            // 예: MemChart.update() 또는 새로운 차트 생성
            //console.log(gacdata); // 최종 데이터 구조를 확인
            if(Memchart){
                Memchart.destroy();
            }
            Memchart= new Chart(document.getElementById("MemChart"),gacconfig);


        }//ajax끝
    });
}
function MemberCount(){
    //남:여:총인원
    //총인원
    var allCount=Memlist.allCount;
    const Memdata={
        labels:[Memlist.mgender,Memlist.wgender],
        datasets:[{
            label:"인원:",
            data:[Memlist.mcount,Memlist.wcount],
            backgroundColor:['rgba(54, 162, 235, 0.5)','rgba(255, 99, 132, 0.5)'],
            borderColor: 'rgba(255, 255, 255, 1)',
            borderWidth: 1,
        }]
    };
    const Memconfig = {
        type: "doughnut",
        data: Memdata,
        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: true,
                    onClick: false
                },
                tooltip: {
                    callbacks: {
                        label: function(tooltipItem) {
                            const label = tooltipItem.label || '';
                            const value = tooltipItem.raw; // 원래 값 사용
                            const total = allCount; // 총 인원 수
                            const percentage = ((value / total) * 100).toFixed(2);
                            return  `${label}: ${value}명 (${percentage}%)`; // 툴팁에 "명" 추가
                        }
                    }
                }
            },
            onClick: function(event, activeElements) {
                if (activeElements.length > 0) {
                    const clickedIndex = activeElements[0].index; // 클릭한 요소의 인덱스
                    const label = this.data.labels[clickedIndex]; // 클릭한 범례의 라벨
                    // 클릭된 섹션에 따라 다른 행동 수행
                    if (label == Memlist.mgender) {
                        document.getElementById("changetext").innerHTML="남자나이대별";
                        GACount(label,Memlist.mcount); // 추가 작업을 위한 함수 호출
                    } else if (label == Memlist.wgender) {
                        document.getElementById("changetext").innerHTML="여자나이대별";
                        GACount(label,Memlist.wcount); // 추가 작업을 위한 함수 호출
                    }
                }
            }
        },plugins:[{
            id: 'customCenterText22',
            afterDraw: function(chart) {
                const width = chart.width,
                    height = chart.height,
                    ctx = chart.ctx;

                // 중앙에 텍스트 표시
                ctx.restore();
                const fontSize = (height / 100).toFixed(2);
                ctx.font = `1em sans-serif`;
                ctx.textBaseline = 'middle';

                const text =`총인원: ${allCount}명`;
                const textX = Math.round((width - ctx.measureText(text).width) / 2);
                const textY = height / 2;

                ctx.fillText(text, textX, textY);
                ctx.save();
            }
        }]
    };
    // 사용자 정의 플러그인

    if(Memchart){
        Memchart.destroy();
    }
    Memchart=new Chart(document.getElementById("MemChart"),Memconfig);
}

function newPayment(){

    //최신 결제내역구하기
    $.ajax({
        url:"/adminPages/newPayment",
        data:{usercode:usercode1},
        type:"post",
        success:function(r){

            var apaylist=r.APaylist;
            var Avo=r.Avo;
            //최신 결제내역
            if (Avo.role<3||Avo.admin_code==0){
                var buttontag="<div id=\"addlist\" > </div><div><button type=\"button\">더보기</button></div>";
                document.getElementById("buttonhidden").innerHTML=buttontag;
                var tag="<ul><li class='oneline paymenttitle'><div class='nickname'>닉네임</div>";
                tag += "<div class='marathon_name'>주문번호</div><div class='real_amount'>총가격</div>";
                tag += "<div class='completed_date'>결제완료일</div></li>";
                apaylist.forEach(function(apay){
                    tag+="<li class='oneline alink'><a href='#'><div class='nickname'>"+apay.nickname+"</div>";
                    tag+="<div class='marathon_name'>"+apay.orderId+"</div>";
                    tag+="<div class='real_amount'>"+apay.real_amount+"</div>";
                    tag+="<div class='completed_date'>"+apay.completed_date+"</div></a></li>";
                });
                tag+="</ul>";

                document.getElementById("newPaymentList").innerHTML=tag;
            }else{
                tag="<h1>권한이 없습니다</h1>";
                document.getElementById("newPaymentList").innerHTML=tag;
            }
            //답변 대기중인 Q&A 리스트
            var qnalist=r.qnalist;
            //console.log(qnalist);
            var qnahiddenbrnTag="<div class='chartHead'><div class='chartTitle'><div id=\"addlist2\" > QnAList &nbsp; (답변대기중) </div></div><div><button type=\"button\">더보기</button></div></div>";
            document.getElementById("qnahiddenbtn").innerHTML=qnahiddenbrnTag;
            var qnaTag="<ul><li class='oneline qnatitle'><div class='qna_code'>고유번호</div>";
            qnaTag += "<div class='qna_subject'>QnA제목</div><div class='nickname'>작성자</div>";
            qnaTag += "<div class='writedate'>작성일</div></li>";
            qnalist.forEach(function(list){
               qnaTag +="<li class='oneline alink'><a href='#'><div class='qna_code'>"+list.qna_code+"</div>";
               qnaTag +="<div = class='qna_subject'>"+list.qna_subject+"</div>";
               qnaTag +="<div class='nickname'>"+list.nickname+"</div>";
               qnaTag +="<div class='writedate'>"+list.writedate+"</div></a></li>";
            });
            qnaTag+="</ul>";

            document.getElementById("qnanewList").innerHTML=qnaTag;
        }
    })//ajax끝
}
function yearsTop5Marathon(year,annualSales){
    if (annualSales) {
        annualSales.destroy();
        // 기존 차트 제거
    }
    $.ajax({
        url:"/adminPages/yearsTop5Marathon",
        type:"post",
        data:{
            year:year
        },
        success:function(r){
            //체크완료 console.log(r);
            if (annualSales) {
                annualSales.destroy();

             // 차트 인스턴스를 null로 설정
            }
            var Ylist=r.YT5Mlist;
            const YT5MData=[];
            const YT5MLabels=[];
            // 5개의 데이터가 항상 필요하므로 초기화
            for (let i = 0; i < 3; i++) {
                if (i < Ylist.length) {
                    // 데이터가 있을 경우
                    YT5MData.push(Ylist[i].total_real_amount);
                    YT5MLabels.push(Ylist[i].marathon_name);
                } else {
                    // 데이터가 없을 경우 기본값 0 및 레이블 "없음"
                    YT5MData.push(0);
                    YT5MLabels.push("없음");
                }
            }
            // console.log(YT5MData);
            // console.log(YT5MLabels);
            // 총액 계산
            const totalSalesAmount = YT5MData.reduce((acc, amount) => acc + amount, 0); // 판매 금액의 총합

            const YT5MChartData = {
                labels: YT5MLabels,
                datasets: [{
                    label: "판매 금액", // 이 라벨은 툴팁에서만 보이게 할 수 있음
                    data: YT5MData,
                    backgroundColor: [
                        'rgba(54, 162, 235, 0.7)', // 파란색
                        'rgba(255, 159, 64, 0.7)', // 주황색
                        'rgba(75, 192, 192, 0.7)', // 녹색
                        'rgba(153, 102, 255, 0.7)', // 보라색
                        'rgba(255, 99, 132, 0.7)'  // 빨간색
                    ],
                    borderColor: 'rgba(255, 255, 255, 1)',
                    borderWidth: 1
                }]
            };


            annualSales = new Chart(document.getElementById("annualSales"), {
                type: "bar",
                data: YT5MChartData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            display: false // 범례 숨김
                        },
                        title: {
                            display: true, // 타이틀 표시
                            text: `${year}년 총액: ${totalSalesAmount.toLocaleString('ko-KR')}원`, // 총액 표시
                        },
                        tooltip: {
                            callbacks: {
                                label: function(tooltipItem) {
                                    const label = tooltipItem.label || '';
                                    const value = tooltipItem.raw;
                                    return label + ": " + value.toLocaleString('ko-KR') + "원"; // 금액 단위 추가
                                }
                            }
                        }
                    },onClick:function(){

                        if(annualSales){
                            annualSales.destroy();
                        }
                        yearsamount(annualSales);
                    }
                }
            });




        }



    });//ajax끝
}
function yearsamount(){
    if (annualSales) {
        annualSales.destroy(); // 기존 차트 제거
    }
    $.ajax({
        url:"/adminPages/amountCharts",
        type:"post",
        success:function(r){
            var APlist=r.APlist;
            let annualSales;
            const currentYear = new Date().getFullYear();
            const backgroundColors = [];
            const borderColors = [];
            const apdatas=[];
            const aplabels=[];
            //연도별 매출액
            for (let i =APlist.length-1;i>=0;i--){
                aplabels.push(APlist[i].completed_date);
                apdatas.push(APlist[i].real_amount);
                // 현재 년도에 따라 색상을 다르게 적용
                if (APlist[i].completed_date == currentYear) {
                    backgroundColors.push('rgba(255, 205, 86, 0.8)'); // 노란색
                    borderColors.push('rgba(255, 205, 86, 1)');
                } else {
                    backgroundColors.push('rgba(54, 162, 235, 0.8)'); // 파란색
                    borderColors.push('rgba(75, 192, 192, 0.8)');
                }
            }


            const apconfig = {
                type: "bar",
                data: {
                    labels: aplabels,
                    datasets: [{
                        label: "연매출액(원)",
                        data: apdatas,
                        backgroundColor: backgroundColors,
                        borderColor: borderColors,
                        borderWidth: 1
                    }]
                },options: {

                    plugins: {
                        legend: {
                            display: false  // 범례를 숨김
                        }
                    }
                    ,onClick:function(event, activeElements){

                        if (activeElements.length > 0) { // 클릭한 요소가 있을 경우
                            const clickedIndex = activeElements[0].index; // 클릭한 요소의 인덱스
                            const label = this.data.labels[clickedIndex]; // 클릭한 범례의 라벨

                            yearsTop5Marathon(label,annualSales); // 클릭 시 함수 호출
                        }


                    }
                }
            };
            // 기존 차트가 있을 경우 제거
            if (annualSales) {
                annualSales.destroy(); // 기존 차트 제거
            }

            annualSales = new Chart(document.getElementById("annualSales"), apconfig);
                }
            });
}