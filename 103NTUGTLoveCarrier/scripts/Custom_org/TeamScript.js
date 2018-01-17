var DateString = ["5/2(一)", "5/3(二)", "5/4(三)", "5/5(四)", "5/6(五)"];
var ClassString = ["二下課(10:00-10:20)", "三下課(11:10-11:20)", "四下課(12:10-12:20)", "五午休(13:10-13:20)", "六下課(14:10-14:20)", "七下課(15:10-15:30)", "八下課(16:20-16:30)", "九下課(17:20-17:30)"];
var CategoryName = ["友情", "愛情", "銃康", "師長", "另類"];
var CategoryStyle = ["primary", "danger", "warning", "success", "info"];
var ReserveString = ["4/25(一)", "4/26(二)", "4/27(三)", "4/28(四)", "4/29(五)"];
var GereralLessonString = ["否", "是", "不知道"];
var PayString = ["否", "是"];

$(document).ready(function () {
    var $songpicker = $('#SongPickerDiv');
    $songpicker.on('click', '[data-toggle="songpicker"]', function (event) {
        event.preventDefault();
        type = ($(this).data('type') ? $(this).data('type') : "add");

        if (type == "add") {
            $nextelement = $songpicker.find('.song-container.selected').next('.song-container').length ?
							$songpicker.find('.song-container.selected').next('.song-container') :
							$songpicker.find('.song-container').first();
            $nextelement.siblings('.song-container').removeClass('selected').hide();
            $nextelement.addClass('selected').show();
        }
        else if (type == "subtract") {
            $nextelement = $songpicker.find('.song-container.selected').prev('.song-container').length ?
							$songpicker.find('.song-container.selected').prev('.song-container') :
							$songpicker.find('.song-container').last();
            $nextelement.siblings('.song-container').removeClass('selected').hide();
            $nextelement.addClass('selected').show();
        }
    });
});

function OpenTeamModal(tid, team, teamDetail, ratio, imageCount) {
    /*toggle loading mask*/
    HoldOn.open({
        theme: "sk-circle",
        message: '<h2>讀取中...</h2>'
    });

    /*get data*/
    $.ajax({
        type: 'POST',
        url: "/api-teamdata",
        data: { TID: tid },
        dataType: "Json",
        timeout: 10000,
        success: function (response) {
            /*fill timetable*/
            $('#TimeTable tbody').empty();
            $.each(response.TimeTable, function (i, Class) {
                var row = $('<tr></tr>').appendTo($('#TimeTable').find('tbody:last'));
                $.each(Class, function (j, Day) {

                    var grid = response.TimeTable[i][j];
                    if (j == 0) {
                        grid = '<a data-toggle="tooltip" data-placement="top" title="' + ClassString[i] + '">' + response.TimeTable[i][j] + '</a>';
                        row.append($('<td></td>').html(grid));
                    }
                    else if (grid == 'V') {
                        grid = '<button class="btn btn-success btn-sm" onclick="submitConfirm(\'' + team + '\',\'' + DateString[j - 1] + '\',\'' + ClassString[i] + '\',\'' + tid + '\',\'' + j + '\',\'' + (i + 2) + '\');"><i class="fa fa-check"></i></button>'
                        //grid = '<button class="btn btn-success btn-sm"><i class="fa fa-check"></i></button>'
                        row.append($('<td></td>').html(grid));
                    }
                    else if (grid == '▲') {
                        grid = '<span class="label label-danger"><i class="fa fa-clock-o"></i></span>';
                        row.append($('<td></td>').html(grid));
                    }
                    else if (grid == 'X') {
                        grid = '<span class="label label-warning"><i class="fa fa-times"></i></span>';
                        row.append($('<td></td>').html(grid));
                    }
                    else
                        row.append($('<td></td>').text(grid));

                });
            });
            $('[data-toggle="tooltip"]').tooltip();

            /*fill songpicker*/
            $('#SongContent').empty();
            $.each(response.SongName, function (i, Song) {
                var SongData = $('<div></div>').addClass('song-container pull-left').hide().appendTo($('#SongContent'));
                SongData.append($('<h4></h4>').addClass('originalSinger').text(response.OriginalPlayer[i]));
                SongData.append($('<h4></h4>').addClass('songCount').text(i + 1 + ' / ' + response.SongName.length));
                SongData.append($('<h2></h2>').addClass('songName').text(Song));
                SongData.append($('<h4></h4>').addClass('category'));
                SongData.append($('<h4></h4>').addClass('songId').text(response.SongID[i]).hide());
                for (var j = 0; j < response.Category[i].length; j++) {
                    $('<span></span>').addClass('label label-' + CategoryStyle[response.Category[i][j] - '1']).text(CategoryName[response.Category[i][j] - '1']).appendTo(SongData.find('.category'));
                };
            });
            $('#SongContent').find('.song-container').first().addClass('selected').show();

            /*fill picture*/
            $('#TeamDetailDiv .carousel-indicators').empty();
            $('#TeamDetailDiv .carousel-inner').empty();
            for (i = 0; i < imageCount; i++) {
                $('<li></li>').addClass('item' + i).appendTo($('#TeamDetailDiv .carousel-indicators'));
                $('<div></div>').addClass('item').append($('<img/>').attr('src', '/images/players/' + tid + '-' + (i + 1) + '.jpg')).appendTo($('#TeamDetailDiv .carousel-inner'));
            }
            $('#TeamDetailDiv .carousel-indicators').find('li').first().addClass('active');
            $('#TeamDetailDiv .carousel-inner').find('div').first().addClass('active');

            /*fill info*/
            $('#TeamDetailDiv legend').text('No.' + tid + ' ' + team);
            $('#TeamDetail h3').text(teamDetail);
            $('#TeamDetail h4').text('可選時段: ' + ratio);
            //$('#TeamDetail p').text('[testing data]原來這是手機遊戲《部落衝突》的廣告，「野豬騎士來喔～～」是其中的一句台詞，就是為了要宣傳遊戲的揪團開戰、支援功能，所以一直出現同一句台詞，但影片中高亢、尖細又無厘頭的男配音，加上這支廣告最近的曝光率超高，所以這句話就莫名地走紅了起來');


            // Activate Carousel
            $("#TeamPhotoCarousel").carousel();

            // Enable Carousel Indicators
            $("#TeamPhotoCarousel .item0").click(function () {
                $("#TeamPhotoCarousel").carousel(0);
            });
            $("#TeamPhotoCarousel .item1").click(function () {
                $("#TeamPhotoCarousel").carousel(1);
            });
            $("#TeamPhotoCarousel .item2").click(function () {
                $("#TeamPhotoCarousel").carousel(2);
            });
            $("#TeamPhotoCarousel .item3").click(function () {
                $("#TeamPhotoCarousel").carousel(3);
            });
            $("#TeamPhotoCarousel .item4").click(function () {
                $("#TeamPhotoCarousel").carousel(4);
            });

            // Enable Carousel Controls
            $("#TeamPhotoCarousel .left").click(function () {
                $("#TeamPhotoCarousel").carousel("prev");
            });
            $("#TeamPhotoCarousel .right").click(function () {
                $("#TeamPhotoCarousel").carousel("next");
            });


            $('#TeamInfo').show();

            HoldOn.close();
            bootbox.dialog({
                title: '<h3 style="margin:0">歌手資訊</h3>',
                message: $('#TeamInfo'),
                size: "large",
                buttons: {
                    success: {
                        label: "返回",
                        className: "btn-default"
                    }
                },
                show: false
            })
            .on('shown.bs.modal', function () {
                $("#TeamPhotoCarousel").carousel('cycle')
            })
            .on('hide.bs.modal', function () {
                $("#TeamPhotoCarousel").carousel('pause')
                $('#TeamInfo').hide().appendTo('body');
            })
            .modal('show');
        },
        error: function () {
            alert('逾時，請再試一次');
            HoldOn.close();
        }
    });
}

/*confirmation*/
function submitConfirm(TeamText, DateText, ClassText, Team, Date, Class) {
    SongText = $('.song-container.selected .songName').text();
    CategoryText = "";
    $('.song-container.selected .category span').each(function () {
        CategoryText += $(this).text() + " ";
    })
    Song = $('.song-container.selected .songId').text();

    var r = confirm("確定選歌?\n歌名：" + SongText + "\n歌手：" + TeamText + "\n日期：" + DateText + "\n時間：" + ClassText + "\n類型：" + CategoryText);
    if (r == true) {
        do_Post({ 'Date': Date, 'Class': Class, 'Team': Team, 'Song': Song });
    }
    return false;
}

function do_Post(params) {
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "/formfill");

    for (var key in params) {
        if (params.hasOwnProperty(key)) {
            var hiddenField = document.createElement("input");
            hiddenField.setAttribute("type", "hidden");
            hiddenField.setAttribute("name", key);
            hiddenField.setAttribute("value", params[key]);
            form.appendChild(hiddenField);
        }
    }
    document.body.appendChild(form);
    form.submit();
}
