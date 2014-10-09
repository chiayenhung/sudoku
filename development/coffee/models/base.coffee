define [], ->
  class Base
    Base.idCounter = 0

    constructor: () ->
      @id = Base.idCounter
      Base.idCounter += 1

    create: ->
      