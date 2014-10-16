(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["jquery", "views/base"], function($, Base) {
    var GridView;
    return GridView = (function(_super) {
      var model;

      __extends(GridView, _super);

      model = null;

      function GridView(el, coordinate, number, immutable) {
        this.coordinate = coordinate;
        this.immutable = immutable;
        this.number = number;
        GridView.__super__.constructor.apply(this, arguments);
      }

      GridView.prototype.setHandlers = function() {
        var _this = this;
        return this.el.off(".click").on("click.click", function(e) {
          if (!_this.immutable) {
            if (_this.el.hasClass("pressed")) {
              _this.trigger("closePopup");
              return _this.close();
            } else {
              _this.trigger("openPopup", e);
              return _this.open();
            }
          }
        });
      };

      GridView.prototype.render = function() {
        if (this.number > 0) {
          return this.el.text(this.number);
        } else {
          return this.el.text("");
        }
      };

      GridView.prototype.update = function(number) {
        this.number = number;
        this.render();
        return this.trigger("update", this.coordinate, this.number);
      };

      GridView.prototype.open = function() {
        return this.el.addClass("pressed");
      };

      GridView.prototype.close = function() {
        return this.el.removeClass("pressed");
      };

      GridView.prototype.addClass = function(cls) {
        return this.el.addClass(cls);
      };

      GridView.prototype.removeClass = function(cls) {
        return this.el.removeClass(cls);
      };

      GridView.prototype.isError = function() {
        return this.el.find(".error-column, .error-row, .error-block").length > 0;
      };

      return GridView;

    })(Base);
  });

}).call(this);
