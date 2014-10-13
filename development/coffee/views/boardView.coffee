define ["jquery", "templates", "views/base", "views/gridView", "views/popup", "models/game"], ($, JST, Base, GridView, Popup, Game) ->

  class BoardView extends Base

    game = null
    rowNum = null
    obj = null

    constructor: (el, row=9, objs) ->
      rowNum = row
      obj = objs
      game = new Game rowNum, obj
      @gridViews = []
      @popup = new Popup()
      super

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
      @setPopupListener()

    setGridView: (indexX, indexY, obj) ->
      grid = $(JST['grid']())
      grid.toggleClass "immutable", obj?.grids[indexX][indexY] > 0
      view = new GridView grid, [indexX, indexY], obj?.grids[indexX][indexY]
      view.setHandlers()
      view.render()
      @gridViews[indexX][indexY] = view
      grid

    setPopupListener: ->
      @popup.on "closePop", =>
        @closeAllGrid()

    setGridListener: ->
      copy = @
      for i in [0..rowNum - 1]
        for j in [0..rowNum - 1]
          item = @gridViews[i][j]
          item.off("update").on "update", (coordinate, number) ->
            grids = game.get "grids"
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
      for i in [0..rowNum - 1]
        for j in [0..rowNum - 1]
          item = @gridViews[i][j]        
          item.close()

    defineGridViews: ->
      for i in [0..rowNum - 1]
        @gridViews.push new Array(rowNum)

    render: ->
      @defineGridViews()
      @generateGrid rowNum, obj
      @el.after @popup.render()
      @popup.setHandlers()

    check: (coordinate) ->
      @checkBlock coordinate
      @checkRow coordinate
      @checkColumn coordinate

    checkBlock: (coordinate) ->
      startX = Math.floor(coordinate[0] / 3) * rowNum / 3
      startY = Math.floor(coordinate[1] / 3) * rowNum / 3
      map = {}
      for i in [0..rowNum / 3 - 1]
        for j in [0..rowNum / 3 - 1]
          item = @gridViews[startX + i][startY + j]
          if item.number != 0
            if item.number not of map
              map[item.number] = []
            map[item.number].push item#[startX + i, startY + j]
            if map[item.number].length > 1
              map[item.number].forEach (grid) =>
                if not grid.immutable
                  grid.addClass "error"
            else
              map[item.number].forEach (grid) =>
                if not grid.immutable
                  grid.removeClass "error"

    checkRow: (coordinate) ->
      startX = coordinate[0]
      map = {}
      for j in [0..rowNum - 1]
        item = @gridViews[startX][j]
        if item.number != 0
          if item.number not of map
            map[item.number] = []
          map[item.number].push item
          if map[item.number].length > 1
            map[item.number].forEach (grid) =>
              if not grid.immutable
                grid.addClass "error"
          else
            map[item.number].forEach (grid) =>
              if not grid.immutable
                grid.removeClass "error"

    checkColumn: (coordinate) ->
      startY = coordinate[1]
      map = {}
      for i in [0..rowNum - 1]
        item = @gridViews[i][startY]
        if item.number != 0
          if item.number not of map
            map[item.number] = []
          map[item.number].push item
          if map[item.number].length > 1
            map[item.number].forEach (grid) =>
              if not grid.immutable
                grid.addClass "error"
          else
            map[item.number].forEach (grid) =>
              if not grid.immutable
                grid.removeClass "error"

