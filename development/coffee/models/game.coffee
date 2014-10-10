define ["base", "grid"], (Base, Grid) ->
  class Game extends Base

    constructor: (rowNum=9) ->
      super
      @attrs.grids = []
      @populateGrids rowNum

    populateGrids: (rowNum) ->
      for row in [0..rowNum - 1]
        for column in [0..rowNum - 1]
          @attrs.grids[row][column] = new Grid
