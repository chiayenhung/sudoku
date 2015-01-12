(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["jquery", "views/base", "templates"], function($, Base, JST) {
    var Popup;
    return Popup = (function(_super) {
      var grid, template;

      __extends(Popup, _super);

      template = JST["popup"];

      grid = null;

      function Popup(el) {
        Popup.__super__.constructor.apply(this, arguments);
      }

      Popup.prototype.render = function() {
        return this.el = $(template());
      };

      Popup.prototype.setHandlers = function() {
        var _this = this;
        this.el.on("click", "button", function() {
          var data;
          data = $(this).data();
          if (grid) {
            return grid.update(data.number);
          }
        });
        return $(document).on("click", function(e) {
          if ($(e.target).closest(".board").length === 0) {
            _this.close();
            return _this.trigger("closePop");
          }
        });
      };

      Popup.prototype.open = function(e, gridView) {
        var $grid, height, position, positionTop, width;
        grid = gridView;
        $grid = $(e.target);
        position = $grid.position();
        width = $grid.width() / 2;
        height = $grid.height();
        positionTop = position.top + height;
        if (positionTop + this.el.height() > $(window).innerHeight()) {
          positionTop = position.top - this.el.height();
        }
        this.el.css("left", position.left + width);
        this.el.css("top", positionTop);
        return this.el.addClass("open");
      };

      Popup.prototype.close = function() {
        this.el.removeClass("open");
        this.el.css("left", "50%");
        return this.el.css("top", "50%");
      };

      return Popup;

    })(Base);
  });

}).call(this);
