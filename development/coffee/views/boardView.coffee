define ["jquery", "templates", "views/base", "views/gridView", "models/game"], ($, JST, Base, GridView, Game) ->

  class BoardView extends Base

    game = null

    constructor: (el, rowNum=9, obj) ->
      super
      game = new Game rowNum, obj
      @gridViews = []
      @generateGrid rowNum, obj

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
      @gridViews.forEach (item, index) ->
        item.off("update").on "update", (coordinate, number) ->
          console.log coordinate, number


