(function() {
  var DIR;

  DIR = "../lib/js";

  requirejs.config({
    paths: {
      'jquery': "" + DIR + "/jquery-1.11.0.min",
      'jade': "" + DIR + "/jade.min"
    },
    shim: {
      'jquery': {
        exports: '$'
      },
      'jade': {
        exports: 'jade'
      }
    }
  });

  requirejs(["jquery", "views/lobbyView"], function($, LobbyView) {
    var lobby;
    lobby = new LobbyView($(".lobby"));
    return lobby.setHandlers();
  });

}).call(this);
