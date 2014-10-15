define ["jquery", "views/boardView"], ($, BoardView) ->
  class SudokuBoard extends BoardView

    constructor: (el, row=9, objs) ->
      super

    check: (coordinate) ->
      @checkBlock coordinate
      @checkRow coordinate
      @checkColumn coordinate

    checkBlock: (coordinate) ->
      startX = Math.floor(coordinate[0] / 3) * @rowNum / 3
      startY = Math.floor(coordinate[1] / 3) * @rowNum / 3
      map = {}
      for i in [0..@rowNum / 3 - 1]
        for j in [0..@rowNum / 3 - 1]
          item = @gridViews[startX + i][startY + j]
          if item.number != 0
            if item.number not of map
              map[item.number] = []
            map[item.number].push item
            if map[item.number].length > 1
              map[item.number].forEach (grid) =>
                if not grid.immutable
                  grid.addClass "error-block"
            else
              map[item.number].forEach (grid) =>
                if not grid.immutable
                  grid.removeClass "error-block"

    checkRow: (coordinate) ->
      startX = coordinate[0]
      map = {}
      for j in [0..@rowNum - 1]
        item = @gridViews[startX][j]
        if item.number != 0
          if item.number not of map
            map[item.number] = []
          map[item.number].push item
          if map[item.number].length > 1
            map[item.number].forEach (grid) =>
              if not grid.immutable
                grid.addClass "error-row"
          else
            map[item.number].forEach (grid) =>
              if not grid.immutable
                grid.removeClass "error-row"

    checkColumn: (coordinate) ->
      startY = coordinate[1]
      map = {}
      for i in [0..@rowNum - 1]
        item = @gridViews[i][startY]
        if item.number != 0
          if item.number not of map
            map[item.number] = []
          map[item.number].push item
          if map[item.number].length > 1
            map[item.number].forEach (grid) =>
              if not grid.immutable
                grid.addClass "error-column"
          else
            map[item.number].forEach (grid) =>
              if not grid.immutable
                grid.removeClass "error-column"

    isWin: ->
      res = true
      @gridViews.forEach (row, indexX) ->
        row.forEach (item, indexY) ->
          if item.number == 0 or item.isError()
            res = false
            return false
      res