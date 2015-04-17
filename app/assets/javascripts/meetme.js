var MeetMe = {

    initialize: function(){
        var _this = this;

        $(document).ready(function(){
            if($('#meet').length > 0) {
                _this.startLoop();
                _this.startGeneralLoop();
            }
        });

        $(document).on('mousedown', '.mic-set', function(e){
           _this.stopLoop();
           _this.startLoop(2000);
        });

        $(document).on('click', '.mic-set', function(e){
            _this.stopLoop();
            e.preventDefault();
            a = $(this);
            $.ajax({
                url: a.attr('href'),
                method: "PATCH",
                complete: function(data){
                    _this.startLoop(1);
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
            success: function(data, status, xhr){
                div.replaceWith(data);
            },
            complete: function(){
                _this.startLoop();
            }
        })
    },

    startLoop: function(now){
        var _this = this;
        _this.stopLoop();
        if(typeof(now) != 'undefined') {
            _this.timer = setTimeout(function(){MeetMe.updateShow();}, now);
        }
        else {
            _this.timer = setTimeout(function(){MeetMe.updateShow();}, parseInt($('#meet').data('refresh-rate')));
        }

    },

    startGeneralLoop: function() {
        var _this = this;
        _this.generalTimer = setTimeout(function(){ MeetMe.reloadPage(); }, 5000);
    },

    reloadPage: function() {
        window.location.reload(true);
    },

    stopLoop: function(){
        var _this = this;
        try{clearTimeout(_this.timer)}catch(e){}
    },

    timer: false,
    generalTimer: false



}

MeetMe.initialize();