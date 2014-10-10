define ["models/base", "models/grid"], (Base, Grid) ->
  class Game extends Base

    constructor: (rowNum=9) ->
      super
      @attrs.grids = []
      @populateGrids rowNum

    populateGrids: (rowNum) ->
      for row in [0..rowNum - 1]
        @attrs.grids.push []
        for column in [0..rowNum - 1]
          grid = new Grid
          grid.save()
          @attrs.grids[row][column] = grid.getId()
