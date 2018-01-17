var DateString = ["5/2(一)", "5/3(二)", "5/4(三)", "5/5(四)", "5/6(五)"];
var ClassString = ["二下課(10:00-10:20)", "三下課(11:10-11:20)", "四下課(12:10-12:20)", "五午休(13:10-13:20)", "六下課(14:10-14:20)", "七下課(15:10-15:30)", "八下課(16:20-16:30)", "九下課(17:20-17:30)"];

$(document).ready(function () {
    /*judge whether mobile device or not*/
    if ($(window).width() >= 768) {
        $('.songlist div.clickable').addClass('panel-drop');
        $('.songlist div.clickable').find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
    }
    else {
        $('.found .panel-body').hide();
    }

    /*toggle all*/
    $('.toggle .btn-toggle').on('click', function () {
        var $target = $(this).data('target');
        var $panel = $('.songlist div.clickable');
        if ($target == 'on') {
            $panel.parents('.panel').find('.panel-body').slideDown();
            $panel.addClass('panel-drop');
            $panel.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
        }
        else {
            $panel.parents('.panel').find('.panel-body').slideUp();
            $panel.removeClass('panel-drop');
            $panel.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
        }
    });

    /*category filter*/
    $('.category-filter .btn-filter').on('click', function () {
        $(this).addClass("active").siblings().removeClass("active");

        var $target = $(this).data('target');
        if ($target != '_all') {
            $('.songlist').css('display', 'none');
            if ($('.songlist.' + $target).length) {
                $('.songlist.' + $target).fadeIn('slow');
                $('.notfound').css('display', 'none');
            }
            else {
                $('.notfound').fadeIn('slow');
            }
        }
        else if ($target == '_all') {
            $('.songlist').css('display', 'none');
            if ($('.songlist').length > 1) {
                $('.songlist').fadeIn('slow');
                $('.notfound').css('display', 'none');
            }
            else {
                $('.notfound').fadeIn('slow');
            }
        }

        var categoryLabel = $('.timebar span.category');
        categoryLabel.removeClass();

        if ($target == '_all') {
            categoryLabel.addClass('label category label-default');
            categoryLabel.text('全部');
        }
        else if ($target == '_c1') {
            categoryLabel.addClass('label category label-primary');
            categoryLabel.text('友情');
        }
        else if ($target == '_c2') {
            categoryLabel.addClass('label category label-danger');
            categoryLabel.text('愛情');
        }
        else if ($target == '_c3') {
            categoryLabel.addClass('label category label-warning');
            categoryLabel.text('銃康');
        }
        else if ($target == '_c4') {
            categoryLabel.addClass('label category label-success');
            categoryLabel.text('師長');
        }
        else if ($target == '_c5') {
            categoryLabel.addClass('label category label-info');
            categoryLabel.text('另類');
        }
    });

    /*Toggle Panel*/
    $('.songlist div.clickable').on('click', function (e) {
        var $this = $(this);
        if (e.target.nodeName == 'BUTTON') {
            return;
        }
        else if (!$this.hasClass('panel-drop')) {
            $this.parents('.panel').find('.panel-body').slideDown();
            $this.addClass('panel-drop');
            $this.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
        } else {
            $this.parents('.panel').find('.panel-body').slideUp();
            $this.removeClass('panel-drop');
            $this.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
        }
    });
});

/*confirmation*/
function submitConfirm(SongText, TeamText, DateText, ClassText, CategoryText, Song, Team, Date, Class) {
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

function OpenTimeModel(SongText, TeamText, CategoryText, Song, Team) {
    /*toggle loading mask*/
    HoldOn.open({
        theme: "sk-cube-grid",
        message: '<h2>讀取中...</h2>'
    });
    /*get data*/
    $.ajax({
        type: 'POST',
        url: "/api-timetable",
        data: { TID: Team },
        dataType: "Json",
        timeout: 10000,
        success: function (response) {
            //var response = $.parseJSON(data);
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
                        //grid = '<button class="btn yo" onclick="return submitConfirm(' + SongText + ', ' + TeamText + ', ' + DateText + ', ' + ClassText + ', ' + CategoryText + ', ' + Song + ', ' + Team + ', ' + j + ', ' + (i + 2) + ');">V</button>'
                        grid = '<button class="btn btn-success btn-sm" onclick="submitConfirm(\'' + SongText + '\',\'' + TeamText + '\',\'' + DateString[j - 1] + '\',\'' + ClassString[i] + '\',\'' + CategoryText + '\',\'' + Song + '\',\'' + Team + '\',\'' + j + '\',\'' + (i + 2) + '\');"><i class="fa fa-check"></i></button>'
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

            HoldOn.close();

            bootbox.dialog({
                title: '<h3>' + SongText + '</h3> <p>' + TeamText + '</p>',
                message: $('#TimeTableModel'),
                buttons: {
                    success: {
                        label: "返回",
                        className: "btn-default"
                    }
                },
                show: false
            })
            .on('shown.bs.modal', function () {
                $('#TimeTableModel').show();
            })
            .on('hide.bs.modal', function () {
                $('#TimeTableModel').hide().appendTo('body');
            })
            .modal('show');
        },
        error: function() {
            alert('逾時，請重新輸入');
            HoldOn.close();
            window.location = '/songlist';
        }
    });

    return false;
}

/*Rearrange Window toggle panel*/
/*
$(window).resize(function () {
    var $panel = $('#container div.clickable');
    if ($(this).width() >= 768) {
        $panel.parents('.panel').find('.panel-body').slideDown();
        $panel.removeClass('panel-collapsed');
        $panel.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
    }
    else {
        $panel.parents('.panel').find('.panel-body').slideUp();
        $panel.addClass('panel-collapsed');
        $panel.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
    }
});*/

/*ajax rebinding*/
function rebinding() {
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(BeginRequestHandler);
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
}

function BeginRequestHandler(sender, args) {
    HoldOn.open({
        theme: "sk-rect",
        message: '<h2>讀取中...</h2>'
    });
}
function EndRequestHandler(sender, args) {
    HoldOn.close();
    ReadyFunction();
}

function ReadyFunction() {
    /*judge whether mobile device or not*/
    if ($(window).width() >= 768) {
        $('.songlist div.clickable').addClass('panel-drop');
        $('.songlist div.clickable').find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
    }
    else {
        $('.found .panel-body').hide();
    }

    /*Toggle Panel*/
    $('.songlist div.clickable').on('click', function (e) {
        var $this = $(this);
        if (e.target.nodeName == 'BUTTON') {
            return;
        }
        else if (!$this.hasClass('panel-drop')) {
            $this.parents('.panel').find('.panel-body').slideDown();
            $this.addClass('panel-drop');
            $this.find('i').removeClass('glyphicon-plus').addClass('glyphicon-minus');
        } else {
            $this.parents('.panel').find('.panel-body').slideUp();
            $this.removeClass('panel-drop');
            $this.find('i').removeClass('glyphicon-minus').addClass('glyphicon-plus');
        }
    });

    setPanelButton('all');
}

function setPanelButton(type) {
    var element = $('.category-filter .btn-filter.' + type);
    element.addClass("active").siblings().removeClass("active");

    var $target = element.data('target');

    if ($target != '_all') {
        $('.songlist').css('display', 'none');
        if ($('.songlist.' + $target).length) {
            $('.songlist.' + $target).fadeIn('slow');
            $('.notfound').css('display', 'none');
        }
        else {
            $('.notfound').fadeIn('slow');
        }
    }
    else if ($target == '_all') {
        //$('.songlist').css('display', 'none');
        if ($('.songlist').length > 1) {
            $('.songlist').fadeIn('slow');
            $('.notfound').css('display', 'none');
        }
        else {
            $('.notfound').fadeIn('slow');
        }
    }

    var categoryLabel = $('.timebar span.category');
    categoryLabel.removeClass();

    if ($target == '_all') {
        categoryLabel.addClass('label category label-default');
        categoryLabel.text('全部');
    }
    else if ($target == '_c1') {
        categoryLabel.addClass('label category label-primary');
        categoryLabel.text('友情');
    }
    else if ($target == '_c2') {
        categoryLabel.addClass('label category label-danger');
        categoryLabel.text('愛情');
    }
    else if ($target == '_c3') {
        categoryLabel.addClass('label category label-warning');
        categoryLabel.text('銃康');
    }
    else if ($target == '_c4') {
        categoryLabel.addClass('label category label-success');
        categoryLabel.text('師長');
    }
    else if ($target == '_c5') {
        categoryLabel.addClass('label category label-info');
        categoryLabel.text('另類');
    }
}