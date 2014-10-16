(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["jquery", "views/boardView"], function($, BoardView) {
    var SudokuBoard;
    return SudokuBoard = (function(_super) {
      __extends(SudokuBoard, _super);

      function SudokuBoard(el, row, objs) {
        if (row == null) {
          row = 9;
        }
        SudokuBoard.__super__.constructor.apply(this, arguments);
      }

      SudokuBoard.prototype.check = function(coordinate) {
        this.checkBlock(coordinate);
        this.checkRow(coordinate);
        return this.checkColumn(coordinate);
      };

      SudokuBoard.prototype.checkBlock = function(coordinate) {
        var i, item, j, map, startX, startY, _i, _ref, _results;
        startX = Math.floor(coordinate[0] / 3) * this.rowNum / 3;
        startY = Math.floor(coordinate[1] / 3) * this.rowNum / 3;
        map = {};
        _results = [];
        for (i = _i = 0, _ref = this.rowNum / 3 - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          _results.push((function() {
            var _j, _ref1, _results1,
              _this = this;
            _results1 = [];
            for (j = _j = 0, _ref1 = this.rowNum / 3 - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
              item = this.gridViews[startX + i][startY + j];
              if (item.number !== 0) {
                if (!(item.number in map)) {
                  map[item.number] = [];
                }
                map[item.number].push(item);
                if (map[item.number].length > 1) {
                  _results1.push(map[item.number].forEach(function(grid) {
                    if (!grid.immutable) {
                      return grid.addClass("error-block");
                    }
                  }));
                } else {
                  _results1.push(map[item.number].forEach(function(grid) {
                    if (!grid.immutable) {
                      return grid.removeClass("error-block");
                    }
                  }));
                }
              } else {
                _results1.push(void 0);
              }
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      SudokuBoard.prototype.checkRow = function(coordinate) {
        var item, j, map, startX, _i, _ref, _results,
          _this = this;
        startX = coordinate[0];
        map = {};
        _results = [];
        for (j = _i = 0, _ref = this.rowNum - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; j = 0 <= _ref ? ++_i : --_i) {
          item = this.gridViews[startX][j];
          if (item.number !== 0) {
            if (!(item.number in map)) {
              map[item.number] = [];
            }
            map[item.number].push(item);
            if (map[item.number].length > 1) {
              _results.push(map[item.number].forEach(function(grid) {
                if (!grid.immutable) {
                  return grid.addClass("error-row");
                }
              }));
            } else {
              _results.push(map[item.number].forEach(function(grid) {
                if (!grid.immutable) {
                  return grid.removeClass("error-row");
                }
              }));
            }
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };

      SudokuBoard.prototype.checkColumn = function(coordinate) {
        var i, item, map, startY, _i, _ref, _results,
          _this = this;
        startY = coordinate[1];
        map = {};
        _results = [];
        for (i = _i = 0, _ref = this.rowNum - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          item = this.gridViews[i][startY];
          if (item.number !== 0) {
            if (!(item.number in map)) {
              map[item.number] = [];
            }
            map[item.number].push(item);
            if (map[item.number].length > 1) {
              _results.push(map[item.number].forEach(function(grid) {
                if (!grid.immutable) {
                  return grid.addClass("error-column");
                }
              }));
            } else {
              _results.push(map[item.number].forEach(function(grid) {
                if (!grid.immutable) {
                  return grid.removeClass("error-column");
                }
              }));
            }
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      };

      SudokuBoard.prototype.isWin = function() {
        var res;
        res = true;
        this.gridViews.forEach(function(row, indexX) {
          return row.forEach(function(item, indexY) {
            if (item.number === 0 || item.isError()) {
              res = false;
              return false;
            }
          });
        });
        return res;
      };

      return SudokuBoard;

    })(BoardView);
  });

}).call(this);
