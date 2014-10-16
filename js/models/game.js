(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["models/base"], function(Base) {
    var Game;
    return Game = (function(_super) {
      __extends(Game, _super);

      function Game(rowNum, obj) {
        if (rowNum == null) {
          rowNum = 9;
        }
        Game.__super__.constructor.apply(this, arguments);
        this.attrs.grids = [];
        if (obj) {
          this.populateGrids(rowNum, obj);
        }
      }

      Game.prototype.populateGrids = function(rowNum, obj) {
        var column, row, _i, _ref, _results;
        _results = [];
        for (row = _i = 0, _ref = rowNum - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; row = 0 <= _ref ? ++_i : --_i) {
          this.attrs.grids.push([]);
          _results.push((function() {
            var _j, _ref1, _ref2, _ref3, _ref4, _ref5, _results1;
            _results1 = [];
            for (column = _j = 0, _ref1 = rowNum - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; column = 0 <= _ref1 ? ++_j : --_j) {
              _results1.push(this.attrs.grids[row][column] = {
                immutable: (obj != null ? (_ref2 = obj.grids) != null ? (_ref3 = _ref2[row]) != null ? _ref3[column] : void 0 : void 0 : void 0) > 0,
                number: obj != null ? (_ref4 = obj.grids) != null ? (_ref5 = _ref4[row]) != null ? _ref5[column] : void 0 : void 0 : void 0
              });
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      return Game;

    })(Base);
  });

}).call(this);
