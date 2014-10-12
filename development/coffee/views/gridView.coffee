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
          @el.toggleClass "pressed"
          @trigger "update", @coordinate, @number

    render: ->
      if @immutable
        @el.text @number
      