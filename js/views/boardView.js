(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["jquery", "templates", "views/base", "views/gridView", "views/popup", "models/game"], function($, JST, Base, GridView, Popup, Game) {
    var BoardView;
    return BoardView = (function(_super) {
      __extends(BoardView, _super);

      function BoardView(el, row, objs) {
        if (row == null) {
          row = 9;
        }
        this.rowNum = row;
        this.game = new Game(row, objs);
        this.gridViews = [];
        this.popup = new Popup();
        BoardView.__super__.constructor.apply(this, arguments);
      }

      BoardView.prototype.generateGrid = function(rowNum) {
        var column, grid, i, j, newRow, row, x, y, _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = rowNum / 3 - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          row = $(JST['row']());
          this.el.append(row);
          _results.push((function() {
            var _j, _ref1, _results1;
            _results1 = [];
            for (j = _j = 0, _ref1 = rowNum / 3 - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
              column = $(JST['column']());
              row.append(column);
              _results1.push((function() {
                var _k, _ref2, _results2;
                _results2 = [];
                for (x = _k = 0, _ref2 = rowNum / 3 - 1; 0 <= _ref2 ? _k <= _ref2 : _k >= _ref2; x = 0 <= _ref2 ? ++_k : --_k) {
                  newRow = $(JST['row']());
                  column.append(newRow);
                  _results2.push((function() {
                    var _l, _ref3, _results3;
                    _results3 = [];
                    for (y = _l = 0, _ref3 = rowNum / 3 - 1; 0 <= _ref3 ? _l <= _ref3 : _l >= _ref3; y = 0 <= _ref3 ? ++_l : --_l) {
                      grid = this.setGridView(i * rowNum / 3 + x, j * rowNum / 3 + y);
                      _results3.push(newRow.append(grid));
                    }
                    return _results3;
                  }).call(this));
                }
                return _results2;
              }).call(this));
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      BoardView.prototype.setHandlers = function() {
        this.setGridListener();
        return this.setPopupListener();
      };

      BoardView.prototype.setGridView = function(indexX, indexY) {
        var grid, view;
        grid = $(JST['grid']());
        grid.toggleClass("immutable", this.game.attrs.grids[indexX][indexY].immutable);
        view = new GridView(grid, [indexX, indexY], this.game.attrs.grids[indexX][indexY].number, this.game.attrs.grids[indexX][indexY].immutable);
        view.setHandlers();
        view.render();
        this.gridViews[indexX][indexY] = view;
        return grid;
      };

      BoardView.prototype.setPopupListener = function() {
        var _this = this;
        return this.popup.on("closePop", function() {
          return _this.closeAllGrid();
        });
      };

      BoardView.prototype.setGridListener = function() {
        var copy, i, item, j, _i, _ref, _results;
        copy = this;
        _results = [];
        for (i = _i = 0, _ref = this.rowNum - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          _results.push((function() {
            var _j, _ref1, _results1;
            _results1 = [];
            for (j = _j = 0, _ref1 = this.rowNum - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
              item = this.gridViews[i][j];
              item.off("update").on("update", function(coordinate, number) {
                var grids;
                grids = copy.game.get("grids");
                grids[coordinate[0]][coordinate[1]].number = number;
                copy.closeAllGrid();
                copy.popup.close();
                copy.check(coordinate);
                return copy.trigger("isWin", copy.isWin());
              });
              item.off("openPopup").on("openPopup", function(e) {
                copy.closeAllGrid();
                return copy.popup.open(e, this);
              });
              _results1.push(item.off("closePopup").on("closePopup", function(e) {
                return copy.popup.close();
              }));
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      BoardView.prototype.closeAllGrid = function() {
        var i, item, j, _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = this.rowNum - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          _results.push((function() {
            var _j, _ref1, _results1;
            _results1 = [];
            for (j = _j = 0, _ref1 = this.rowNum - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; j = 0 <= _ref1 ? ++_j : --_j) {
              item = this.gridViews[i][j];
              _results1.push(item.close());
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      BoardView.prototype.defineGridViews = function() {
        var i, _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = this.rowNum - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          _results.push(this.gridViews.push(new Array(this.rowNum)));
        }
        return _results;
      };

      BoardView.prototype.render = function() {
        this.el.empty();
        this.defineGridViews();
        this.generateGrid(this.rowNum);
        $(".inputPop").remove();
        this.el.after(this.popup.render());
        return this.popup.setHandlers();
      };

      BoardView.prototype.check = function(coordinate) {};

      BoardView.prototype.isWin = function() {};

      return BoardView;

    })(Base);
  });

}).call(this);
