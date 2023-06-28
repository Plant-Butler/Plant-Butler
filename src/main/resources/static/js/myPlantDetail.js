var csrfHeader = $("meta[name='_csrf_header']").attr("content");
var csrfToken = $("meta[name='_csrf']").attr("content");

function registRepresent() {
    fetch(`/myplants/${myPlantId}/${userId}/represent`, {
        method: 'POST',
        headers: {
            [csrfHeader]: csrfToken
        },
    })
        .then((response) => {
            if (response.ok) {
                window.location.replace("/myplants");
            } else {
                console.error('Error:', response.statusText);
            }
        })
        .catch((error) => {
            console.error('Error:', error);
        });
}



    $(document).ready(function(){
    $(".content").hide(); // hide all contents
    $("#content1").fadeIn(); // fade in the first content

    $("#button1").click(function(){
    $(".content").hide(); // hide all contents
    $("#content1").fadeIn(); // fade in the first content
});
    $("#button2").click(function(){
    $(".content").hide(); // hide all contents
    $("#content2").fadeIn(); // fade in the second content
});
    $("#button3").click(function(){
    $(".content").hide(); // hide all contents
    $("#content3").fadeIn(); // fade in the third content
});
});

$(document).ready(function() {
const swiper = new Swiper('.swiper', {
    // Optional parameters
    direction: 'vertical',
    loop: true,

    // If we need pagination
    pagination: {
        el: '.swiper-pagination',
    },

    // Navigation arrows
    navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
    },

    // And if we need scrollbar
    scrollbar: {
        el: '.swiper-scrollbar',
    },
});
});


$(document).ready(function () {

    if ($("input[name='myplantPot']:checked").val() === "1") {
        $("#radius1Label").text("화분 밑 지름 : ");
        $("#radius2Label").text("화분 윗 지름 : ");
    } else {
        $("#radius1Label").text("화분 가로 : ");
        $("#radius2Label").text("화분 세로 : ");
    }
});

// 라디오 버튼 변경 시 radius1Label과 radius2Label의 내용을 변경

$(document).ready(function () {
    $("input[name='myplantPot']").on("change", function () {
        if ($(this).val() === "1") {
            $("#radius1Label").text("내 화분 밑 지름 : ");
            $("#radius2Label").text("내 화분 윗 지름 : ");
            $(".test1").text("화분 윗 지름 : ")
            $(".test2").text("화분 밑 지름 : ")
        } else {
            $("#radius1Label").text("내 화분 가로 : ");
            $("#radius2Label").text("내 화분 세로 : ");
            $(".test1").text("화분 가로 : ")
            $(".test2").text("화분 세로 : " +
                "")
        }
    });
});