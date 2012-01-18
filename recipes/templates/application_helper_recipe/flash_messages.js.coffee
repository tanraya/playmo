flash_messages = ->
  $ = document.id

  document.addEvent 'domready', ->
    messages = $('flash-messages')
      if (messages)
        close = messages.getElement('a')
        hideMessages = -> messages.slide('out')

        close.addEvent 'click', -> (e)
          e.stop()
          hideMessages()

        hideMessages.delay(10000)

flash_messages()