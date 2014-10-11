DIR = "../lib/js"

requirejs.config
  paths:
    'jquery': "#{DIR}/jquery-1.11.0.min"
    'jade': "#{DIR}/jade.min"

  shim:
    'jquery': exports: '$'
    'jade': exports: 'jade'

requirejs ["jquery" ,"views/boardView"], ($, Board) ->
  board = new Board $(".board")
  board.setHandlers()
