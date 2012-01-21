flash_messages = ->
  $(document).ready ->
    messages = $('#flash-messages')
    if (messages)
      close = messages.find('a')

      hideMessages = ->
        messages.animate({ top: -messages.height() }, 400, ->
          messages.hide()
        );

      close.click (e) ->
        e.preventDefault()
        hideMessages()

      close.delay(10000).queue ->
        $(this).trigger("click")

flash_messages()