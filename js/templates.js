define(['jade'], function(jade) {
var JST = {};
JST['lobby'] = function anonymous(locals) {
var buf = [];
with (locals || {}) {
var listItems_mixin = function(games, timeFormat){
var block = this.block, attributes = this.attributes || {}, escaped = this.escaped || {};
// iterate games
;(function(){
  var $$obj = games;
  if ('number' == typeof $$obj.length) {

    for (var $index = 0, $$l = $$obj.length; $index < $$l; $index++) {
      var item = $$obj[$index];

buf.push("<li" + (jade.attrs({ 'data-id':(item.id) }, {"data-id":true})) + "><span>" + (jade.escape(null == (jade.interp = item.id) ? "" : jade.interp)) + "</span><span>" + (jade.escape(null == (jade.interp = timeFormat(item.val.updateTime)) ? "" : jade.interp)) + "</span><a class=\"remove\">x</a></li>");
    }

  } else {
    var $$l = 0;
    for (var $index in $$obj) {
      $$l++;      if ($$obj.hasOwnProperty($index)){      var item = $$obj[$index];

buf.push("<li" + (jade.attrs({ 'data-id':(item.id) }, {"data-id":true})) + "><span>" + (jade.escape(null == (jade.interp = item.id) ? "" : jade.interp)) + "</span><span>" + (jade.escape(null == (jade.interp = timeFormat(item.val.updateTime)) ? "" : jade.interp)) + "</span><a class=\"remove\">x</a></li>");
      }

    }

  }
}).call(this);

};
buf.push("<div class=\"container\"><button class=\"btn next\">Next Game</button><button class=\"btn save\">Save</button><button class=\"btn load hasMenu\">Load<div class=\"menu\"><ul>");
listItems_mixin(games, timeFormat);
buf.push("</ul></div></button></div><div class=\"container\"><div class=\"board\"></div></div><div class=\"popup winPopup\"><header class=\"popupHeader\">Congratulation!</header><div class=\"popupContent\"><div>The problem solved!</div></div></div>");
}
return buf.join("");
};
JST['grid'] = function anonymous(locals) {
var buf = [];
with (locals || {}) {
buf.push("<div class=\"grid\"></div>");
}
return buf.join("");
};
JST['row'] = function anonymous(locals) {
var buf = [];
with (locals || {}) {
buf.push("<div class=\"row\"></div>");
}
return buf.join("");
};
JST['column'] = function anonymous(locals) {
var buf = [];
with (locals || {}) {
buf.push("<div class=\"column\"></div>");
}
return buf.join("");
};
JST['list'] = function anonymous(locals) {
var buf = [];
with (locals || {}) {
var listItems_mixin = function(games, timeFormat){
var block = this.block, attributes = this.attributes || {}, escaped = this.escaped || {};
// iterate games
;(function(){
  var $$obj = games;
  if ('number' == typeof $$obj.length) {

    for (var $index = 0, $$l = $$obj.length; $index < $$l; $index++) {
      var item = $$obj[$index];

buf.push("<li" + (jade.attrs({ 'data-id':(item.id) }, {"data-id":true})) + "><span>" + (jade.escape(null == (jade.interp = item.id) ? "" : jade.interp)) + "</span><span>" + (jade.escape(null == (jade.interp = timeFormat(item.val.updateTime)) ? "" : jade.interp)) + "</span><a class=\"remove\">x</a></li>");
    }

  } else {
    var $$l = 0;
    for (var $index in $$obj) {
      $$l++;      if ($$obj.hasOwnProperty($index)){      var item = $$obj[$index];

buf.push("<li" + (jade.attrs({ 'data-id':(item.id) }, {"data-id":true})) + "><span>" + (jade.escape(null == (jade.interp = item.id) ? "" : jade.interp)) + "</span><span>" + (jade.escape(null == (jade.interp = timeFormat(item.val.updateTime)) ? "" : jade.interp)) + "</span><a class=\"remove\">x</a></li>");
      }

    }

  }
}).call(this);

};
listItems_mixin(games, timeFormat);
}
return buf.join("");
};
JST['popup'] = function anonymous(locals) {
var buf = [];
with (locals || {}) {
buf.push("<div class=\"popup inputPop\"><div class=\"popupHeader\"></div><div class=\"popupContent\"><div class=\"row\"><button data-number=\"1\" class=\"btn\">1</button><button data-number=\"2\" class=\"btn\">2</button><button data-number=\"3\" class=\"btn\">3</button></div><div class=\"row\"><button data-number=\"4\" class=\"btn\">4</button><button data-number=\"5\" class=\"btn\">5</button><button data-number=\"6\" class=\"btn\">6</button></div><div class=\"row\"><button data-number=\"7\" class=\"btn\">7</button><button data-number=\"8\" class=\"btn\">8</button><button data-number=\"9\" class=\"btn\">9</button></div><button data-number=\"0\" class=\"btn\">remove</button></div></div>");
}
return buf.join("");
};
return JST;
});
