define ["jquery", "views/base"], ($, Base) ->
	class GridView extends Base

		model = null

		constructor: (el, coordinate, number) ->
      @coordinate = coordinate
      @immutable = number > 0
      @number = number
      super

    setHandlers: ->
      @el.off(".click").on "click.click", (e) =>
        if not @immutable
          if @el.hasClass "pressed"
            @trigger "closePopup"
            @close()
          else 
            @trigger "openPopup", e
            @open()

    render: ->
      if @number > 0
        @el.text @number
      else
        @el.text ""

    update: (number) ->
      @number = number
      @render()
      @trigger "update", @coordinate, @number

    open: ->
      @el.addClass "pressed"

    close: ->
      @el.removeClass "pressed"

    addClass: (cls) ->
      @el.addClass cls

    removeClass: (cls) ->
      @el.removeClass cls

    isError: ->
      @el.find(".error-column, .error-row, .error-block").length > 0
      