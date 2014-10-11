define ["jquery", "views/base"], ($, Base) ->
	class GridView extends Base

		model = null

		constructor: (el, coordinate, immutable) ->
      @counter = 1
      @coordinate = coordinate
      @immutable = immutable
      super

    setHandlers: ->
      @el.off(".click").on "click.click", (e) =>
        console.log @coordinate
        @el.toggleClass "pressed"
        if not @immutable
          @el.text @counter
          @counter++
