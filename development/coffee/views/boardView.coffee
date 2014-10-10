define ["jquery", "templates", "views/base", "models/game"], ($, JST, Base, Game) ->

  class BoardView extends Base

    game = null

    constructor: (el, rowNum=9) ->
      super el
      game = new Game rowNum
      @generateGrid rowNum
      game.save()

    generateGrid: (rowNum) ->
      for i in [0..rowNum / 3 - 1]
        row = $(JST['row'] id: i)
        @el.append row
        for j in [0..rowNum / 3 - 1]
          column = $(JST['column'] id: j)
          row.append column
          for x in [0..rowNum / 3 - 1]
            newRow = $(JST['row'] id: i + 5)
            column.append newRow
            for y in [0..rowNum / 3 - 1]
              grid = $(JST['grid']())
              newRow.append grid

    setHandlers: ->

