(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["jquery", "utils/event"], function($, Event) {
    var Base;
    return Base = (function(_super) {
      __extends(Base, _super);

      function Base(el) {
        if (el == null) {
          el = null;
        }
        this.el = el;
      }

      Base.prototype.setHandlers = function() {};

      return Base;

    })(Event);
  });

}).call(this);
