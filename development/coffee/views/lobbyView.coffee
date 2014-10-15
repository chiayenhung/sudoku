define ["jquery", "templates", "views/base", "views/sudokuBoard"], ($, JST, Base, SudokuBoard) ->
  class LobbyView extends Base

    template: JST["lobby"]

    constructor: ->
      $.ajax
        url: "data/pattern.json"
        dataType: "json"
        cache: false
        success: (data) =>
          @allGames = data
          @render()
          @generateNewGame()
      super

    render: ->
      savedGames = @getSaveGame()
      @el.html @template games: savedGames

    setHandlers: ->
      copy = @
      @el.on "click", ".save", ->
        if copy.board
          copy.board.game.save()

      @el.on "click", ".hasMenu", ->
        $(@).toggleClass "pressed"

      @el.on "click", ".next", =>
        @generateNewGame()

      @el.on "click", "li", ->
        id = $(@).data "id"
        copy.board = new SudokuBoard copy.el.find(".board")
        copy.board.game.fetch id, (err) ->
          if not err
            copy.board.render()
            copy.board.setHandlers()

    generateNewGame: ->
      pick = generateRandom @allGames.pattern.length
      @board = new SudokuBoard @el.find(".board"), @allGames?.pattern?[pick].length, @allGames?.pattern?[pick]
      @board.render()
      @board.setHandlers()

    getSaveGame: ->
      data = JSON.parse localStorage.getItem "Game"
      setToList data

    generateRandom = (range) ->
      Math.floor Math.random() * range

    setToList = (set) ->
      res = []
      for id of set
        res.push 
          id: id
          val: set[id]
      res
