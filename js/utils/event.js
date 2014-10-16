(function() {
  define(["jquery"], function($) {
    var Event;
    return Event = (function() {
      var events;

      function Event() {}

      events = {};

      Event.prototype.on = function(action, callback) {
        events[action] = callback;
        return this;
      };

      Event.prototype.off = function(action) {
        if (events != null) {
          delete events[action];
        }
        return this;
      };

      Event.prototype.trigger = function(action) {
        var args;
        args = Array.prototype.slice.call(arguments, 1);
        if (action in events) {
          return events[action].apply(this, args);
        } else {
          return console.log(action, "is not listened");
        }
      };

      return Event;

    })();
  });

}).call(this);
