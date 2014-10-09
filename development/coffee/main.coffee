DIR = "../public/js"

requirejs.config
  paths:
    'jquery': "#{DIR}/jquery-1.11.0.min"
    'jade': "#{DIR}.jade.min"

  shim:
    'jquery': exports: '$'
    'jade': exports: 'jade'

requirejs ["views/board"], (Board) ->
  board = new Board
