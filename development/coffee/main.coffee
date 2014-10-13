DIR = "../lib/js"

requirejs.config
  paths:
    'jquery': "#{DIR}/jquery-1.11.0.min"
    'jade': "#{DIR}/jade.min"

  shim:
    'jquery': exports: '$'
    'jade': exports: 'jade'

requirejs ["jquery" ,"views/boardView"], ($, BoardView) ->
  $.ajax
    url: "data/pattern.json"
    dataType: "json"
    cache: false
    success: (data) ->
      pick = Math.floor Math.random() * data.pattern.length
      board = new BoardView $(".board"), data?.pattern?[pick].length, data?.pattern?[pick]
      board.render()
      board.setHandlers()
