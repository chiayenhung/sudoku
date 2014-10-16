(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["jquery", "templates", "utils/utils", "views/base", "views/sudokuBoard", "models/game"], function($, JST, utils, Base, SudokuBoard, Game) {
    var LobbyView;
    return LobbyView = (function(_super) {
      var generateRandom, setToList;

      __extends(LobbyView, _super);

      LobbyView.prototype.template = JST["lobby"];

      function LobbyView() {
        var _this = this;
        this.board = null;
        $.ajax({
          url: "data/pattern.json",
          dataType: "json",
          cache: false,
          success: function(data) {
            _this.allGames = data;
            _this.render();
            _this.generateNewGame();
            return _this.board.on("isWin", function(isWin) {
              if (isWin) {
                $(".winPopup").addClass("open");
                return setTimeout(function() {
                  return $(".winPopup").removeClass("open");
                }, 3000);
              }
            });
          }
        });
        LobbyView.__super__.constructor.apply(this, arguments);
      }

      LobbyView.prototype.render = function() {
        var savedGames;
        savedGames = this.getSaveGame();
        return this.el.html(this.template({
          games: savedGames,
          timeFormat: utils.timeFormat
        }));
      };

      LobbyView.prototype.renderList = function() {
        var $ul;
        $ul = this.el.find("ul");
        return $ul.html(JST["list"]({
          games: this.getSaveGame(),
          timeFormat: utils.timeFormat
        }));
      };

      LobbyView.prototype.setHandlers = function() {
        var copy,
          _this = this;
        copy = this;
        this.el.on("click", ".save", function() {
          if (copy.board) {
            return copy.board.game.save(function(err) {
              if (!err) {
                return copy.renderList();
              }
            });
          }
        });
        this.el.on("click", ".hasMenu", function() {
          return $(this).toggleClass("pressed");
        });
        $(document).on("click", function(e) {
          if ($(e.target).closest(".hasMenu").length === 0) {
            return $(".hasMenu").removeClass("pressed");
          }
        });
        this.el.on("click", ".next", function() {
          return _this.generateNewGame();
        });
        this.el.on("click", "li", function() {
          var id;
          id = $(this).data("id");
          copy.board = new SudokuBoard(copy.el.find(".board"));
          return copy.board.game.fetch(id, function(err) {
            if (!err) {
              copy.board.render();
              return copy.board.setHandlers();
            }
          });
        });
        return this.el.on("click", ".remove", function(e) {
          var id;
          e.stopPropagation();
          id = $(this).closest("li").data("id");
          return copy.removeGame(id);
        });
      };

      LobbyView.prototype.removeGame = function(id) {
        var copy, game;
        copy = this;
        if (!id) {
          return;
        }
        game = new Game;
        return game.fetch(id, function() {
          return game.remove(function() {
            return copy.renderList();
          });
        });
      };

      LobbyView.prototype.generateNewGame = function() {
        var pick, _ref, _ref1, _ref2, _ref3;
        pick = generateRandom(this.allGames.pattern.length);
        this.board = new SudokuBoard(this.el.find(".board"), (_ref = this.allGames) != null ? (_ref1 = _ref.pattern) != null ? _ref1[pick].length : void 0 : void 0, (_ref2 = this.allGames) != null ? (_ref3 = _ref2.pattern) != null ? _ref3[pick] : void 0 : void 0);
        this.board.render();
        return this.board.setHandlers();
      };

      LobbyView.prototype.getSaveGame = function() {
        var data;
        data = JSON.parse(localStorage.getItem("Game"));
        return setToList(data);
      };

      generateRandom = function(range) {
        return Math.floor(Math.random() * range);
      };

      setToList = function(set) {
        var id, res;
        res = [];
        for (id in set) {
          res.push({
            id: id,
            val: set[id]
          });
        }
        return res;
      };

      return LobbyView;

    })(Base);
  });

}).call(this);
