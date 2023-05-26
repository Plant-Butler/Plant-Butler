    $(document).ready(function() {
        $.ajax({
            url: "/home/best-list",
            type: "GET",
            success: function(response) {
                var users = response;
                var tableBody = $("#best-user-table tbody");
                var row = "<tr>";
                                for(var i = 0; i < 3; i++) {
                                    var user = users[i];
                                    if(user.myplantImage != null) {
                                        row += "<td><div class='box' style='background: #BDBDBD;'><img class='plantImg' src='/uploads/" + user.myplantImage + "'></div></td>";
                                    } else {
                                        row += "<td>사진이 없습니다.</td>";
                                    }
                                }
                                row += "</tr><tr>";
                                for(var i = 0; i < 3; i++) {
                                    var user = users[i];
                                    row += "<td>" + user.nickname + "</td>";
                                }
                                row += "</tr><tr>";
                                for(var i = 0; i < 3; i++) {
                                     var user = users[i];
                                     row += "<td>" + user.distbNm + "</td>";
                                 }
                                 row += "</tr><tr>";
                                for(var i = 0; i < 3; i++) {
                                    var user = users[i];
                                    row += "<td>" + user.myplantNick + "</td>";
                                }
                                tableBody.append(row);
                                console.log(row);
            },
            error: function(xhr, status, error) {
                alert('오류가 발생했습니다.');
            }
        });
    });

