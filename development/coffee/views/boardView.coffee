define ["jquery", "templates", "views/base", "views/gridView", "models/game"], ($, JST, Base, GridView, Game) ->

  class BoardView extends Base

    game = null

    constructor: (el, rowNum=9, obj) ->
      super el
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
              grid = $(JST['grid']())
              newRow.append grid
              view = new GridView grid, [i * rowNum / 3 + x, j * rowNum / 3 + y]
              view.setHandlers()
              @gridViews.push view

    setHandlers: ->
      @setGridHandlers()

    setGridHandlers: ->
      
