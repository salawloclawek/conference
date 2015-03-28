var MapKey = {
    initialize: function(){

        if($('#phone-form')) {

            $(document).on('click', '.clear-map-key-name', function(e){
                e.preventDefault();
                $(this).parents('.well:first').find('.map-key-name-input').val('');
            });

            $(document).on('blur', '#phone-name', function(e) {
                phone_name_input = $(this);
                map_key_first_name_input = $('.map-key-name-input:first');
                if(map_key_first_name_input.val() == '') {
                    map_key_first_name_input.val(phone_name_input.val());
                }
            });

            $(document).on('click', '.copy-phone-name', function(e) {
                e.preventDefault();
                phone_name_input = $('#phone-name');
                map_key_first_name_input = $('.map-key-name-input:first');
                map_key_first_name_input.val(phone_name_input.val());
            });

        }



    }
}
MapKey.initialize();