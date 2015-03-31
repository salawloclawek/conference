var MeetMe = {

    initialize: function(){
        var _this = this;

        $(document).ready(function(){
            if($('#meet').length > 0) {
                _this.startLoop();
            }
        });

        $(document).on('mousedown', '.mic-set', function(e){
           _this.stopLoop();
           _this.startLoop();
        });

        $(document).on('click', '.mic-set', function(e){
            _this.stopLoop();
            e.preventDefault();
            a = $(this);
            $.ajax({
                url: a.attr('href'),
                method: "PATCH",
                complete: function(data){
                    _this.startLoop(true);
                }
            })
        })

    },

    updateShow: function(){
        var _this = this;
        div = $('#meet');
        $.ajax({
            url: div.data('href'),
            method: "GET",
            ifModified: true,
            success: function(data, status, xhr){
                if(xhr.status == 200) {
                    div.replaceWith(data);
                }
            },
            complete: function(){
                _this.startLoop();
            }
        })
    },

    startLoop: function(now){
        var _this = this;
        if(typeof(now) != 'undefined') {
            _this.stopLoop();
            MeetMe.updateShow();
        }
        else {
            _this.timer = setTimeout(function(){MeetMe.updateShow(); }, parseInt($('#meet').data('refresh-rate')));
        }

    },

    stopLoop: function(){
        var _this = this;
        try{clearTimeout(_this.timer)}catch(e){}
    },

    timer: false



}

MeetMe.initialize();