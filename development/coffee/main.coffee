DIR = "../lib/js"

requirejs.config
  paths:
    'jquery': "#{DIR}/jquery-1.11.0.min"
    'jade': "#{DIR}/jade.min"

  shim:
    'jquery': exports: '$'
    'jade': exports: 'jade'

requirejs ["jquery" ,"views/boardView"], ($, Board) ->
  $.ajax
    url: "data/pattern.json"
    dataType: "json"
    success: (data) ->
      board = new Board $(".board"), data?.pattern?[0].length, data?.pattern?[0]
      board.setHandlers()
