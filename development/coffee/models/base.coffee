define [], ->
  class Base
    @models = {}

    @assignId: (className) ->
      id = null
      if className of @models
        id = @models[className]
        @models[className] += 1
      else
        id = 1
        @models[className] = 2
      id

    constructor: ->
      @attrs = 
        id: Base.assignId @constructor.name

    populate: (obj) ->
      @attrs = obj
    
    getId: ->
      @attrs.id      

    save: ->
      data = null
      if @constructor.name not of localStorage
        data = {}
      else
        data = JSON.parse localStorage.getItem(@constructor.name)
      data[@getId()] = @attrs
      localStorage.setItem @constructor.name, JSON.stringify data

    remove: ->
      if @constructor.name not of localStorage
        console.error @constructor.name, "is not created"
        return
      data = JSON.parse(localStorage.getItem @constructor.name)
      if @getId() not of data
        console.error "id", @getId(), @constructor.name, "not in memory"
      delete data[@getId()]
      localStorage.setItem @constructor.name, JSON.stringify(data)

