(function(){
    var $ = document.id;

    document.addEvent('domready', function() {
        var messages = $('flash-messages');

        if (messages) {
            var close = messages.getElement('a');
            var hideMessages = function() { messages.slide('out'); };

            close.addEvent('click', function(e) {
                e.stop();
                hideMessages();
            });

            hideMessages.delay(10000);
        }
    })
})();