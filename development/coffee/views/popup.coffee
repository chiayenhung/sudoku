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

      $(document).on "click", (e) =>
        if $(e.target).closest(".board").length == 0
          @close()
          @trigger "closePop"

    open: (e, gridView) ->
      grid = gridView
      $grid = $(e.target)
      position = $grid.position()
      width = $grid.width() / 2
      height = $grid.height()
      positionTop = position.top + height
      if positionTop + @el.height() > $(window).innerHeight()
        positionTop = position.top - @el.height()
      @el.css "left", position.left + width
      @el.css "top", positionTop
      @el.addClass "open"

    close: ->
      @el.removeClass "open"
      setTimeout =>
        @el.css "left", $(window).innerWidth()
        @el.css "top", $(window).innerHeight()
      , 500