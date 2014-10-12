define ["jquery", "templates", "views/base", "views/gridView", "views/popup", "models/game"], ($, JST, Base, GridView, Popup, Game) ->

  class BoardView extends Base

    game = null
    rowNum = null
    obj = null

    constructor: (el, row=9, objs) ->
      super
      rowNum = row
      obj = objs
      game = new Game rowNum, obj
      @gridViews = []
      @popup = new Popup()

    generateGrid: (rowNum, obj) ->
      for i in [0..rowNum / 3 - 1]
        row = $(JST['row']())
        @el.append row
        for j in [0..rowNum / 3 - 1]
          column = $(JST['column']())
          row.append column
          for x in [0..rowNum / 3 - 1]
            newRow = $(JST['row']())
            column.append newRow
            for y in [0..rowNum / 3 - 1]
              grid = @setGridView i * rowNum / 3 + x, j * rowNum / 3 + y, obj
              newRow.append grid

    setHandlers: ->
      @setGridListener()

    setGridView: (indexX, indexY, obj) ->
      grid = $(JST['grid']())
      grid.toggleClass "immutable", obj?.grids[indexX][indexY] > 0
      view = new GridView grid, [indexX, indexY], obj?.grids[indexX][indexY]
      view.setHandlers()
      view.render()
      @gridViews.push view
      grid

    setGridListener: ->
      copy = @
      @gridViews.forEach (item, index) =>
        item.off("update").on "update", (coordinate, number) =>
          grids = game.get "grids"
          grids[coordinate[0]][coordinate[1]].number = number
          @closeAllGrid()
          @popup.close()

        item.off("openPopup").on "openPopup", (e) ->
          copy.closeAllGrid()
          copy.popup.open e, @

        item.off("closePopup").on "closePopup", (e) ->
          copy.popup.close()

    closeAllGrid: ->
      @gridViews.forEach (item) ->
        item.close()

    render: ->
      @generateGrid rowNum, obj
      @el.after @popup.render()
      @popup.setHandlers()


