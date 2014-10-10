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
      if @constructor.name not of localStorage
        localStorage[@constructor.name] = {}
      localStorage[@constructor.name][@getId()] = JSON.stringify @attrs

    remove: ->
      if @constructor.name not of localStorage
        console.error @constructor.name, "is not created"
        return
      if @getId() not of localStorage[@constructor.name]
        console.error "id", @getId(), @constructor.name, "not in memory"
      localStorage[@constructor.name].removeItem @getId()

