define ["jquery", "templates", "utils/utils", "views/base", "views/sudokuBoard", "models/game"], ($, JST,  utils, Base, SudokuBoard, Game) ->
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
      @el.html @template 
        games: savedGames
        timeFormat: utils.timeFormat

    renderList: ->
      $ul = @el.find("ul")
      $ul.html JST["list"]
        games: @getSaveGame()
        timeFormat: utils.timeFormat

    setHandlers: ->
      copy = @
      @el.on "click", ".save", ->
        if copy.board
          copy.board.game.save (err) ->
            if not err
              copy.renderList()

      @el.on "click", ".hasMenu", ->
        $(@).toggleClass "pressed"

      $(document).on "click", (e) ->
        if $(e.target).closest(".hasMenu").length == 0
          $(".hasMenu").removeClass "pressed"

      @el.on "click", ".next", =>
        @generateNewGame()

      @el.on "click", "li", ->
        id = $(@).data "id"
        copy.board = new SudokuBoard copy.el.find(".board")
        copy.board.game.fetch id, (err) ->
          if not err
            copy.board.render()
            copy.board.setHandlers()

      @el.on "click", ".remove", (e) ->
        e.stopPropagation()
        id = $(@).closest("li").data "id"
        copy.removeGame id

    removeGame: (id) ->
      copy = @
      if not id
        return
      game = new Game 
      game.fetch id, ->
        game.remove ->
          copy.renderList()

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
