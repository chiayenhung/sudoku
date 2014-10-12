define ["jquery"], ($) ->
  class Event

    events = {}

    on: (action, callback) ->
      events[action] = callback
      @

    off: (action) ->
      delete events?[action]
      @

    trigger: (action) ->
      args = Array.prototype.slice.call(arguments, 1)
      if action of events
        events[action].apply @, args
      else
        console.log action, "is not listened"
