define ["jquery", "views/base", "templates"], ($, Base, JST) ->
  class Popup extends Base

    template = JST["popup"]
    grid = null

    constructor: (el) ->
      super

    render: ->
      @el = $(template())

    setHandlers: ->
      @el.on "click", "button", ->
        data = $(@).data()
        if grid
          grid.update data.number

    open: (e, gridView) ->
      grid = gridView
      $grid = $(e.target)
      position = $grid.position()
      width = $grid.width() / 2
      height = $grid.height()
      @el.css "left", position.left + width
      @el.css "top", position.top + height
      @el.addClass "open"

    close: ->
      @el.removeClass "open"
