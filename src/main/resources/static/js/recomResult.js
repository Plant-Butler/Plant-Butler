
    /* 쿼리스트링 제외 */
    history.replaceState({}, null, location.pathname);

    /* 팝업창 열기 + 식물 상세 + 구매 */
    function show(plant_id, distbNm, soilInfo) {

      document.querySelector(".background").className = "background show";

      let plant_detail = document.getElementsByClassName("plant-detail")[0];
      let plant_shop = document.getElementsByClassName("plant-shop")[0];
      let soil_shop = document.getElementsByClassName("soil-shop")[0];
      let pot_shop = document.getElementsByClassName("pot-shop")[0];

        $.ajax({
             url:  "/suggestions/result/detail",
             type: "GET",
             data: {
                plant_id : plant_id,
                distbNm : distbNm,
                soilInfo : soilInfo
             },
             success: function(response) {

                // 식물 상세정보
                let html0 = '<h1 class="modal-txt">' + distbNm + '</h1><table class="table"><tr><th class="table-success" colspan="4" >' + response.plantVo.sentence + '</th></tr>'
                          + '<tr><th class="table-success">성장 높이</th><td>' + response.plantVo.growthHgInfo + '</td><th class="table-success">성장 넓이</th><td>' + response.plantVo.growthAraInfo + '</td></tr>'
                          + '<tr><th class="table-success">비료</th><td>' + response.plantVo.frtlzrInfo + '</td><th class="table-success">토양</th><td>' + soilInfo + '</td></tr>'
                          + '<tr><th class="table-success">생육온도</th><td>' + response.plantVo.grwhTpCodeNm + '</td><th class="table-success">배치 장소</th><td>' +  response.plantVo.postngplaceCodeNm + '</td></tr></table>'
                          + '<table class="table"><tr><th class="table-success" colspan="4">물 주기</th></tr>'
                          + '<tr><th class="table-success">물주기 봄</th><td>' + response.plantVo.watercycleSprngCodeNm
                          + '</td><th class="table-success">물주기 여름</th><td>' + response.plantVo.watercycleSummerCodeNm + '</td></tr>'
                          + '<tr><th class="table-success">물주기 가을</th><td>' + response.plantVo.watercycleAutumnCodeNm + '</td>'
                          + '<th class="table-success">물주기 겨울</th><td>' + response.plantVo.watercycleWinterCodeNm + '</td></tr></table>';
                plant_detail.innerHTML = html0;


                // 식물 구매정보
                let data1 = JSON.parse(response.responseBody1);
                if (data1 && data1.items && data1.items.length > 0) {
                    let html1 = '';
                    for(let i=0; i<3; i++) {
                        html1 += '<div class="card" style="width: 33%;"><div class="card-body">';
                        html1 += '<table class="item-table"><tr><td><img class="item-img card-img-top" src="' + data1.items[i].image + '"></td></tr>';
                        html1 += '<tr><td><ul class="list-group list-group-flush"><li class="list-group-item">' + data1.items[i].title + '</li>';
                        html1 += '<li class="list-group-item">' + data1.items[i].lprice + '원</li></ul></td></tr></table>';
                        html1 += '<a class="btn btn-primary" href="' + data1.items[i].link + '">구매처로 이동</a>';
                        html1 += '</div></div>';
                    }
                    plant_shop.innerHTML = html1;
                } else {
                    console.log("상품이 존재하지 않습니다.");
                }

                // 토양 구매정보
                let data2 = JSON.parse(response.responseBody2);
                if (data2 && data2.items && data2.items.length > 0) {
                    let html2 = '';
                    for(let i=0; i<3; i++) {
                        html2 += '<div class="card" style="width: 33%;"><div class="card-body">';
                        html2 += '<table class="item-table"><tr><td><img class="item-img" src="' + data2.items[i].image + '"></td></tr>';
                        html2 += '<tr><td><ul class="list-group list-group-flush"><li class="list-group-item">' + data2.items[i].title + '</li>';
                        html2 += '<li class="list-group-item">' + data2.items[i].lprice + '원</li></ul></td></tr></table>';
                        html2 += '<a class="btn btn-primary" href="' + data2.items[i].link + '">구매처로 이동</a>';
                        html2 += '</div></div>';
                    }
                    soil_shop.innerHTML = html2;
                } else {
                    console.log("상품이 존재하지 않습니다.");
                }

                // 화분 구매정보
                let data3 = JSON.parse(response.responseBody3);
                if (data3 && data3.items && data3.items.length > 0) {
                    let html3 = '';
                    for(let i=0; i<3; i++) {
                        html3 += '<div class="card" style="width: 33%;"><div class="card-body">';
                        html3 += '<table class="item-table"><tr><td><a href="' + data3.items[i].link + '"><img class="item-img" src="' + data3.items[i].image + '"></a></td></tr>';
                        html3 += '<tr><td><ul class="list-group list-group-flush"><li class="list-group-item">' + data3.items[i].title + '</li>';
                        html3 += '<li class="list-group-item">' + data3.items[i].lprice + '원</li></ul></td></tr></table>';
                        html3 += '<a class="btn btn-primary" href="' + data3.items[i].link + '">구매처로 이동</a>';
                        html3 += '</div></div>';
                    }
                    pot_shop.innerHTML = html3;
                } else {
                    console.log("상품이 존재하지 않습니다.");
                }

             },
             error: function(request, status, error) {
                   alert('오류가 발생했습니다.');
                   console.log("code: " + request.status)
                   console.log("message: " + request.responseText)
                   console.log("error: " + error);
             }
        });
    }

    /* 팝업창 닫기 */
    function closePop() {
      document.querySelector(".background").className = "background";
    }


    /* 마이페이지에 저장 */
    function savePlants() {
        var csrfHeader = $("meta[name='_csrf_header']").attr("content");
        var csrfToken = $("meta[name='_csrf']").attr("content");

        let idxList = "";

        $( "input[name='plant_id']" ).each (function (){
             idxList = idxList + $(this).val() + "," ;
        });

        idxList = idxList.substring(0, idxList.lastIndexOf(","));
        console.log(idxList);

        $.ajaxSetup({
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            }
        })

        $.ajax({
             url:  "/suggestions/result",
             type: "POST",
             data: { idxList: idxList },
             success: function(response) {
                   if(response) {
                        alert('저장되었습니다.');
                   } else {
                        alert('저장에 실패하였습니다.');
                   }
             },
             error: function(request, status, error) {
                   alert('오류가 발생했습니다.');
                   console.log("code: " + request.status)
                   console.log("message: " + request.responseText)
                   console.log("error: " + error);
             }
        });
    }