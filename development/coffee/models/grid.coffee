define ["models/base"], (Base) ->

  class Grid extends Base

    immutable = true

    constructor: (immutable) ->
      super
      immutable = immutable
