define ["models/base"], (Base) ->
  class Game extends Base

    constructor: (rowNum=9, obj) ->
      super
      @attrs.grids = []
      if obj
        @populateGrids rowNum, obj

    populateGrids: (rowNum, obj) ->
      for row in [0..rowNum - 1]
        @attrs.grids.push []
        for column in [0..rowNum - 1]
          @attrs.grids[row][column] = immutable: obj?.grids?[row]?[column] > 0, number: obj?.grids?[row]?[column]
