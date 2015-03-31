var SafeDelete = {

    initialize: function(){


        $(document).on('mousedown', '.safe-delete', function(e){
            MeetMe.stopLoop();
            MeetMe.startLoop(2000);
        });

        $(document).on('click', '.safe-delete', function(e){
            MeetMe.stopLoop();
            e.preventDefault();

            invoker = $(this);

            modal = $('#safe-delete-modal');
            delete_link = modal.find('.real-delete');
            delete_link.show();
            delete_text_info = modal.find('.delete-item-info');

            delete_link.attr('href', invoker.attr('href'));

            if(typeof(invoker.data('confirm-remote')) != 'undefined') {
                delete_link.data('remote', true);
            } else {
                delete_link.removeData('remote');
            }

            delete_text_info.html(invoker.data('delete-text-info'));
            modal.modal('show');

            MeetMe.startLoop();
        });

        $(document).on('click', '.real-delete', function(e) {
            $('#safe-delete-modal').modal('hide');
        });

    }


}

SafeDelete.initialize();