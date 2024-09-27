$(window).on('scroll',function(){
    if($(window).scrollTop()){
        $('#header').addClass('active');
    }else{
        $('#header').removeClass('active');
    }
});