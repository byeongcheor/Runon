<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="js/home.js" type="text/javascript"></script>
<link rel="stylesheet" href="/css/main.css" type="text/css">
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({
      duration: 1200,
    })
</script>
<script>
   setTimeout(function(){
      //배너섹션
      $.ajax({
         url: "/bannerMarathon",
         success: function (r){
            $('#autoplay').slick('unslick');
            var tag ="";
            var today = new Date();
            $.each(r.list, function(i, vo){
               var eventDate = new Date(vo.event_date);
               var status = (eventDate < today) ? '모집종료':'모집중';
               var recruitStyle = (status === '모집종료') ? 'background-color: grey; color: white;' : '';
               tag += `
                  <div class="slideBox">
                     <div class="posterrecruit" style="`+recruitStyle+`"><span>`+status+`</span></div>
                     <p class="postername">`+vo.marathon_name+`</p><br>
                     <p class="posterdate">📅`+vo.event_date+`</p>
                  </div>
               `;
            })
            $("#slide").html(tag);
            $( document ).ready( function() {
               $('.center').slick({
                  slidesToShow: 1,
                  autoplay: true,
                  autoplaySpeed : 2000,
                  infinite: true,
                  arrows: false,
                  responsive: [
                     {
                        breakpoint: 768,
                        settings: {
                           arrows: false,
                           centerMode: true,
                           centerPadding: '40px',
                           slidesToShow: 3
                        }
                     },
                     {
                        breakpoint:  480,
                        settings: {
                           arrows: false,
                           centerMode: true,
                           centerPadding: '40px',
                           slidesToShow: 1
                        }
                     }
                  ]
               });
            } );

         },error: function (e){
            console.log(e);
         }
      })
      //첫번째 섹션
      $.ajax({
         url: "/randMarathon",
         success: function (r){
            var tag ="";
            var today = new Date();
            $.each(r.list, function(i, vo){
               var eventDate = new Date(vo.event_date);
               var status = (eventDate < today) ? '모집종료':'모집중';
               var recruitStyle = (status === '모집종료') ? 'background-color: grey; color: white;' : '';
               tag += `
                  <div class="hit_poster">
                     <a href="/marathon/marathonDetail/`+vo.marathon_code+`"><div class="poster_img">
                        <img src="./img/marathonPoster/`+vo.poster_img+`">
                        <div class="recruit" style="`+recruitStyle+`"><span>`+status+`</span></div>
                     </div></a>
                     <div>
                        <div class="addrstyle" style="margin: 10px;">📍`+vo.addr+`</div>
                        <div class="addrstyle" style="font-size: 14pt; font-weight: bold; margin-top: 5px;">`+vo.marathon_name+`</div>
                     </div>
                  </div>
               `;
            })
            document.getElementById("marathon1").innerHTML = tag;
         },
         error: function (e){
            console.log(e);
         }
      })
      //두번째섹션
      $.ajax({
         url:"/eventMarathon",
         success: function(r){
            var tag ="";
            var today = new Date();
            $.each(r.list, function(i, vo){
               var eventDate = new Date(vo.event_date);
               var status = (eventDate < today) ? '모집종료':'모집중';
               var recruitStyle = (status === '모집종료') ? 'background-color: grey; color: white;' : '';
               tag += `
                  <div class="hit_poster">
                     <a href="/marathon/marathonDetail/`+vo.marathon_code+`"><div class="poster_img">
                        <img src="./img/marathonPoster/`+vo.poster_img+`">
                        <div class="recruit" style="`+recruitStyle+`"><span>`+status+`</span></div>
                     </div></a>
                     <div>
                        <div class="addrstyle" style="margin: 10px;">📍`+vo.addr+`</div>
                        <div class="addrstyle" style="font-size: 14pt; font-weight: bold; margin-top: 5px;">`+vo.marathon_name+`</div>
                     </div>
                  </div>
               `;
            })
            document.getElementById("event").innerHTML = tag;
         },error: function(e){
            console.log(e);
         }
      })
   },100);
</script>
<body>
<div id="mainBox">
   <div class="section1">
      <img src="./img/banner.png" style="width:100%;">
      <div class="center" id="slide">
         <!--랜덤으로 10개 마라톤뽑기-->
      </div>
   </div>
   <div class="section2">
      <a class="menus" href="/mate/mate"><p>러닝메이트 매칭하기 →</p></a>
   </div>
   <div class="section3">
        <div data-aos="fade-up">
            <h1>Everywhere we run!</h1>
        </div>
        <div data-aos="fade-up">
           <p>러닝을 사랑하는 모든 사람들을 위한 커뮤니티, <span style="font-weight: 700;background-color: #CCFF47;">RUN ON.</span> <br>
                 이곳에서는 다양한 러닝 크루를 모집하고, 마라톤 대회 및 관련 정보를 한눈에 확인하세요. <br>
                 함께 달리며 건강한 삶을 추구하고, 목표를 향해 나아가는 여정을 공유하는 것은 덤입니다. <br>
                 여러분의 러닝을 항상 응원합니다!
              </p>
        </div>
      <div data-aos="fade-up">
      <div class="hitmarathon" id="marathon1">
         <!--랜덤으로 4개 마라톤뽑기-->
      </div>
      </div>
      <div data-aos="fade-up">
        <button id="more1">&nbsp;<a class="menus" href="/marathon/marathonList">더알아보기→</a>&nbsp;</button>
      </div>
   </div>
   <div class="section4">
      <div id="inner1"></div>
      <div id="inner2">
      <div data-aos="fade-up">
         <h1>Run Special!</h1>
      </div>
      <div data-aos="fade-up">
         <p>현재 진행 중인 특별한 러닝이벤트를 살펴보세요.</p>
      </div>
      <div data-aos="fade-up">
         <div class="hitmarathon" id="event">
            <div class="hit_poster">
               <div class="poster_img">
                  <img src="./img/poster4.png">
                  <div class="recruit"><span>모집중</span></div>
               </div>
               <div>
                  <div style="margin: 10px;">📍전국 어디서나</div>
                  <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
               </div>
            </div>
            <div class="hit_poster">
               <div class="poster_img">
                  <img src="./img/poster1.png">
                  <div class="recruit"><span>모집중</span></div>
               </div>
               <div>
                  <div style="margin: 10px;">📍전국 어디서나</div>
                  <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
               </div>
            </div>
            <div class="hit_poster">
               <div class="poster_img">
                  <img src="./img/poster2.png">
                  <div class="recruit"><span>모집중</span></div>
               </div>
               <div>
                  <div style="margin: 10px;">📍전국 어디서나</div>
                  <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
               </div>
            </div>
            <div class="hit_poster">
               <div class="poster_img">
                  <img src="./img/poster3.png">
                  <div class="recruit"><span>모집중</span></div>
               </div>
               <div>
                  <div style="margin: 10px;">📍전국 어디서나</div>
                  <div style="font-size: 14pt; font-weight: bold; margin-top: 5px;">댕댕이레이스</div>
               </div>
            </div>
         </div>
      </div>
      <div data-aos="fade-up">
         <button id="more2">&nbsp;<a class="menus" href="/marathon/marathonList">더알아보기→&nbsp;</a></button>
      </div>
      </div>
   </div>
   <div class="section5">
      <div id="outer1">
         <div id="inner3"></div>
      </div>

      <div id="inner4">
         <div data-aos="fade-up">
         <h1>Run Together!</h1>
         </div>
         <div data-aos="fade-up">
         <p>러닝크루에 가입해서 함께 달려보세요.</p>
         </div>
         <div id="chatImgBox">
            <div data-aos="fade-right">
                  <img src="./img/채팅2.png" id="chatImg" style="width: 600px;height: auto;">
            </div>
            <div id="crewInfo">
               <div data-aos="fade-left">
               <p>시간맞는 크루끼리 모여</br>정기러닝부터 번개러닝까지</p>
               </div>
               <div data-aos="fade-left">
               <p style="font-weight: 300;">러닝크루모집페이지에서 원하는 날짜,<br> 원하는 시간에 함께 뛸 크루들을 모집하세요.<br>
                  런온에서 인증된 크루들과 함께 <br>더욱 폭넓고 즐거운 러닝활동을 만들어 가보세요!</p>
               </div>
               <div data-aos="fade-up" class="btnContainer">
                  <button id="more3">&nbsp;<a class="menus" href="/crew/crewList">더알아보기→</a></button>
               </div>
            </div>
         </div>
      </div>
   </div>
   <div class="section6">
      <div id="outer2">
         <div id="inner5"></div>
      </div>
      <div id="inner6">
      <div data-aos="fade-up">
         <h1>Match your Mate!</h1>
      </div>
      <div data-aos="fade-up">
         <p>
            마라톤 참가 전, 랜덤으로 러닝 메이트를 만나 함께 준비해보세요!<br>
            새로운 메이트와 함께 도전하는 즐거움을 느껴보세요.
         </p>
      </div>
         <div class="matchContainer">
            <div class="mateinfo">
               <div data-aos="fade-up">
               <p>랜덤매칭기능으로</br>마라톤대회 준비를 꼼꼼하게!</p>
               </div>
               <div data-aos="fade-up">
               <p style="font-weight: 300; margin-bottom: 20px;">러닝메이트 매칭 페이지에서<br> 새로운 러너와 마라톤을 준비해보세요.<br>
                  같은 목표를 가지고 함께 응원하며, <br>더 즐겁고 풍성한 러닝 경험을 만들어보세요!</p>
               </div>
                  <div data-aos="fade-up" class="btnContainer" style="justify-content: flex-start">
                     <button id="more4">&nbsp;<a class="menus" href="/mate/mate">더알아보기→</a>&nbsp;</button>
                  </div>
               </div>
            <div class="mateimages">
               <div data-aos="fade-up">
               <div style="width: 300px; height: 300px; border-radius: 10px; margin-right: 30px; margin-top: 180px;">
                  <img style="width: 100%;height: 100%; object-fit: cover;border-radius: 10px;" src="./img/메이트3.jpg">
               </div>
               </div>
               <div data-aos="fade-right">
               <div style="width: 350px; height: 350px; border-radius: 10px;">
                  <img style="width: 100%;height: 100%; object-fit: cover; border-radius: 10px;" src="./img/메이트2.jpg">
               </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>