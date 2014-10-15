define ["jquery", "templates", "views/base", "views/sudokuBoard"], ($, JST, Base, SudokuBoard) ->
  class LobbyView extends Base

    template: JST["lobby"]

    constructor: ->
      $.ajax
        url: "data/pattern.json"
        dataType: "json"
        cache: false
        success: (data) =>
          @render()
          pick = generateRandom data.pattern.length
          board = new SudokuBoard @el.find(".board"), data?.pattern?[pick].length, data?.pattern?[pick]
          board.render()
          board.setHandlers()
      super

    render: ->
      @el.html @template()

    setHandlers: ->
      @el.on "click", ".save", ->
        console.log "save"

    generateRandom = (range) ->
      Math.floor Math.random() * range