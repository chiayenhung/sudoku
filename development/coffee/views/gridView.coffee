define ["jquery", "views/base"], ($, Base) ->
	class GridView extends Base

		model = null

		constructor: (el) ->
			super el
