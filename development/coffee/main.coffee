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
    success: (data) ->
      board = new BoardView $(".board"), data?.pattern?[0].length, data?.pattern?[0]
      board.render()
      board.setHandlers()
