define [], ->
  class Base

    @assignId: (className, callback) ->
      data = JSON.parse localStorage.getItem("autoIncrement")
      if not data
        data = {}
      if className not of data
        data[className] = 2
        id = 1
      else
        id = data[className]
        data[className]++
      localStorage.setItem "autoIncrement", JSON.stringify data
      callback id

    constructor: ->
      @attrs = 
        id: null
        createTime: null
        updateTime: null
    
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

    fetch: (id, callback) ->
      if not callback
        callback = ->
      if @constructor.name of localStorage
        data = JSON.parse localStorage.getItem(@constructor.name)
        if id of data
          @attrs = data[id]
          callback()
        else
          console.error id, "not exists"
          callback(true)
      else
        console.error @constructor.name, "not exists"
        callback(true)

    save: (callback) ->
      data = null
      if not callback
        callback = ->
      firstCreate = false
      if @constructor.name not of localStorage
        data = {}
      else
        data = JSON.parse localStorage.getItem(@constructor.name)
      if not @get "id"
        firstCreate = true
        Base.assignId @constructor.name, (id) =>
          @set "id", id
          @attrs.createTime = new Date
          @attrs.updateTime = new Date
          data[@get("id")] = @attrs
          localStorage.setItem @constructor.name, JSON.stringify data
          callback()
      else
        data[@get("id")] = @attrs
        data[@get("id")].updateTime = new Date
        localStorage.setItem @constructor.name, JSON.stringify data
        callback(true)


    remove: (callback) ->
      if @constructor.name not of localStorage
        console.error @constructor.name, "is not created"
        return
      if not callback
        callback = ->
      data = JSON.parse(localStorage.getItem @constructor.name)
      if @get("id") not of data
        console.error "id", @get("id"), @constructor.name, "not in memory"
        return
      delete data[@get("id")]
      localStorage.setItem @constructor.name, JSON.stringify(data)
      callback()

