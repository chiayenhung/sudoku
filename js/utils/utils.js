(function() {
  define([], function() {
    var Util;
    return Util = (function() {
      function Util() {}

      Util.timeFormat = function(dateStr) {
        var date;
        date = new Date(dateStr);
        return "" + (date.getMonth() + 1) + "/" + (date.getDate()) + " " + (date.getHours()) + ":" + (date.getMinutes());
      };

      return Util;

    })();
  });

}).call(this);
