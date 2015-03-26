var MeetMe = {

    initialize: function(){
        var _this = this;

        $(document).ready(function(){
            if($('#meet').length > 0) {
                _this.startLoop();
            }
        });

        $(document).on('click', '.mic-set', function(e){
            e.preventDefault();
            a = $(this);
            $.ajax({
                url: a.attr('href'),
                method: "PATCH",
                success: function(data){
                    _this.startLoop(true);
                }
            })
        })

    },

    updateShow: function(){
        var _this = this;
        div = $('#meet')
        $.ajax({
            url: div.data('href'),
            method: "GET",
            success: function(data){
                div.replaceWith(data);
                _this.startLoop();
            },
            error: function(){
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
            _this.timer = setTimeout(function(){MeetMe.updateShow(); }, 1000);
        }

    },

    stopLoop: function(){
        var _this = this;
        try{clearTimeout(_this.timer)}catch(e){}
    },

    timer: false



}

MeetMe.initialize();