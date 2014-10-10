define ["jquery", "views/base", "models/grid"], ($, Base, Grid) ->

  class Board extends Base

    game = null

    constructor: ->
      @grid1 = new Grid
      @grid2 = new Grid
