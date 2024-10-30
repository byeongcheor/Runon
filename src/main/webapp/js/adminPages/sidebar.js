
if (typeof clickCount==='undefined'){
    let clickCount=0;
}
clickCount=0;
function report(){
    const submenus = document.querySelectorAll('.submenu');
    clickCount++;
    submenus.forEach(submenu => {
        if (clickCount % 2 === 1) {
            submenu.classList.remove("hidden");
            submenu.classList.add("visible");
            document.getElementById("report").style.background="#2B3244";
            document.getElementById("report").style.border="none";
            document.getElementById("reportfont").style.color="#fff";
        } else {
            submenu.classList.remove("visible");
            submenu.classList.add("hidden");
            document.getElementById("reportfont").style.color="#7A90A9";
            document.getElementById("report").style.background="#1E232E";
            document.getElementById("report").style.borderBottom="1px solid #7A90A9";
        }
    });
}
function alink(url){
    window.location.href=url;
}
function gohome(){
    window.location.href="/";
}