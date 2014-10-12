define ["jquery", "utils/event"], ($, Event) ->
  class Base extends Event
    
    constructor: (el=null) ->
      @el = el

    setHandlers: ->
