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
    
    get: (key) ->
      if not key of @attrs
        console.error key, " not in attrs"
        return null
      @attrs[key]

    set: (key, value) ->
      if not key of @attrs
        console.error key, " not in attrs"
        return @
      @attrs[key] = value
      @ 

    fetch: (id) ->
      if @constructor.name of localStorage
        data = JSON.parse localStorage.getItem(@constructor.name)
        if id of data
          @attrs = data[id]
        else
          console.error id, "not exists"
      else
        console.error @constructor.name, "not exists"

    save: ->
      data = null
      if @constructor.name not of localStorage
        data = {}
      else
        data = JSON.parse localStorage.getItem(@constructor.name)
      data[@get("id")] = @attrs
      localStorage.setItem @constructor.name, JSON.stringify data

    remove: ->
      if @constructor.name not of localStorage
        console.error @constructor.name, "is not created"
        return
      data = JSON.parse(localStorage.getItem @constructor.name)
      if @get("id") not of data
        console.error "id", @get("id"), @constructor.name, "not in memory"
      delete data[@get("id")]
      localStorage.setItem @constructor.name, JSON.stringify(data)

