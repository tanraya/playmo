flash_messages = ->
  $(document).ready ->
    messages = $('flash-messages')
    if (messages)
      close = messages.find('a')
      hideMessages = -> messages.slideDown(250)

      close.click (e) ->
        e.preventDefault()
        hideMessages()

      $(hideMessages).delay(10000)

flash_messages()