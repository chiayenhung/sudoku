define ["jquery", "templates", "views/base", "views/gridView", "views/popup", "models/game"], ($, JST, Base, GridView, Popup, Game) ->

  class BoardView extends Base

    constructor: (el, row=9, objs) ->
      @rowNum = row
      @game = new Game row, objs
      @gridViews = []
      @popup = new Popup()
      super

    generateGrid: (rowNum) ->
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
              grid = @setGridView i * rowNum / 3 + x, j * rowNum / 3 + y
              newRow.append grid

    setHandlers: ->
      @setGridListener()
      @setPopupListener()

    setGridView: (indexX, indexY) ->
      grid = $(JST['grid']())
      grid.toggleClass "immutable", @game.attrs.grids[indexX][indexY].immutable #obj?.grids[indexX][indexY] > 0
      view = new GridView grid, [indexX, indexY], @game.attrs.grids[indexX][indexY].number#obj?.grids[indexX][indexY]
      view.setHandlers()
      view.render()
      @gridViews[indexX][indexY] = view
      grid

    setPopupListener: ->
      @popup.on "closePop", =>
        @closeAllGrid()

    setGridListener: ->
      copy = @
      for i in [0..@rowNum - 1]
        for j in [0..@rowNum - 1]
          item = @gridViews[i][j]
          item.off("update").on "update", (coordinate, number) ->
            grids = copy.game.get "grids"
            grids[coordinate[0]][coordinate[1]].number = number
            copy.closeAllGrid()
            copy.popup.close()
            copy.check coordinate

          item.off("openPopup").on "openPopup", (e) ->
            copy.closeAllGrid()
            copy.popup.open e, @

          item.off("closePopup").on "closePopup", (e) ->
            copy.popup.close()

    closeAllGrid: ->
      for i in [0..@rowNum - 1]
        for j in [0..@rowNum - 1]
          item = @gridViews[i][j]        
          item.close()

    defineGridViews: ->
      for i in [0..@rowNum - 1]
        @gridViews.push new Array(@rowNum)

    render: ->
      @el.empty()
      @defineGridViews()
      @generateGrid @rowNum
      $(".popup").remove()
      @el.after @popup.render()
      @popup.setHandlers()

    check: (coordinate) ->
